package com.kosmo.newproject3rd;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.SharedPreferences;
import android.graphics.Color;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.TextView;

import org.json.JSONArray;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.DecimalFormat;
import java.util.ArrayList;

public class MyParkingInfo extends AppCompatActivity {

    ProgressDialog dialog;
    final static String TAG ="iKosmo";
    String sessionKey = "SESSION_INFO";//로그인 아이디 저장용
    String serverUrl = "";

    ListView listView;
    JSONArray p_contentArray;
    JSONObject p_contentObject, parkingInfo;

    ArrayList<Object> p_contentList = new ArrayList<Object>();
    ArrayList<String> pay_idx = new ArrayList<String>();
    ArrayList<String> p_num = new ArrayList<String>();
    ArrayList<String> r_useregi = new ArrayList<String>();
    ArrayList<String> tp_name = new ArrayList<String>();
    ArrayList<String> p_repeatNum = new ArrayList<String>();

    int parkingIndex;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_my_parking_info);

        serverUrl = getString(R.string.serverUrl);

        dialog = new ProgressDialog(this);
        dialog.setProgressStyle(ProgressDialog.STYLE_SPINNER);
        dialog.setIcon(android.R.drawable.ic_dialog_alert);
        dialog.setTitle("서버 데이터 수신");
        dialog.setMessage("서버로부터 데이터 수신중입니다.");

        SharedPreferences sf = getSharedPreferences(sessionKey,0);
        String sid = sf.getString("USER_ID","");
        String spw = sf.getString("USER_PW","");
        String temp = "parkmoa1";

        //내 결제목록 가져오기
        new MyParkingInfo.AsyncHttpRequest().execute(
                serverUrl+"project3rd/parkmoa/androidParkingHistory.do",
                "m_id="+sid
        );
    }
    class AsyncHttpRequest extends AsyncTask<String,Void,String> {
        @Override
        protected void onPreExecute() {
            super.onPreExecute();
            if (!dialog.isShowing()) {
                dialog.show();
            }
        }

        @Override
        protected String doInBackground(String... strings) {

            StringBuffer jsonString = new StringBuffer();

            try{
                URL url = new URL(strings[0]);
                HttpURLConnection conn = (HttpURLConnection)url.openConnection();
                conn.setRequestMethod("POST");
                conn.setDoOutput(true);

                OutputStream out = conn.getOutputStream();
                out.write(strings[1].getBytes());

                out.flush();
                out.close();

                if(conn.getResponseCode()==HttpURLConnection.HTTP_OK){

                    BufferedReader reader = new BufferedReader(
                            new InputStreamReader(conn.getInputStream(),"UTF-8")
                    );
                    String data;
                    while((data=reader.readLine())!=null){
                        jsonString.append(data+"\r\n");
                    }
                    reader.close();
                }
            }
            catch (Exception e) {
                e.printStackTrace();
            }

            //JSON Array 파싱
            try {
                JSONObject jsonObject = new JSONObject(jsonString.toString());
                JSONArray paymentList = new JSONArray(jsonObject.getString("paymentList"));
                JSONObject payment = new JSONObject();

                for(int i=0; i<paymentList.length(); i++){
                    payment = paymentList.getJSONObject(i);
                    r_useregi.add(payment.get("r_useregi").toString().substring(0,10));
                    tp_name.add(payment.get("tp_name").toString());
                    p_num.add(payment.get("p_num").toString());
                    pay_idx.add(payment.get("pay_idx").toString());
                }
                JSONArray parkingList = new JSONArray(jsonObject.getString("parkingList"));

                for(int i=0; i<parkingList.length(); i++){
                    p_contentObject = parkingList.getJSONObject(i);
                    p_repeatNum.add(p_contentObject.getString("p_repeatNum"));
                    p_contentArray = p_contentObject.getJSONArray("p_content");
                    p_contentList.add(p_contentArray);
                }

            }
            catch (Exception e){
                e.printStackTrace();
            }

            return jsonString.toString();
        }

        @Override
        protected void onPostExecute(String s) {
            super.onPostExecute(s);
            dialog.dismiss();

            CustomList customList = new CustomList(MyParkingInfo.this);
            listView = (ListView)findViewById(R.id.ParkingArea);
            listView.setAdapter(customList);


        }
    }
    public class CustomList extends ArrayAdapter<String> {

        private final Activity context;

        public CustomList(Activity context) {
            super(context, R.layout.myparkinginfo, pay_idx);
            this.context = context;
        }

        @Override
        public String getItem(int position) {
            return super.getItem(position);
        }

        @NonNull
        @Override
        public View getView(final int position, @Nullable View convertView, @NonNull ViewGroup parent) {

            LayoutInflater inflater = context.getLayoutInflater();
            final View rowView = inflater.inflate(R.layout.myparkinginfo,null,true);

            TextView tp_nameTV = (TextView) rowView.findViewById(R.id.tp_name);
            TextView dateTV = (TextView) rowView.findViewById(R.id.date);
            LinearLayout area = (LinearLayout) rowView.findViewById(R.id.area);

            tp_nameTV.setText(tp_name.get(position));
            dateTV.setText(r_useregi.get(position));

            LinearLayout row = new LinearLayout(MyParkingInfo.this);
            int rowNum = 0;
            parkingIndex = 0;

            JSONArray p_contentArray = (JSONArray) p_contentList.get(position);

            if(!p_num.get(position).equals("0")){
                for(int i=0; i<p_contentArray.length(); i++){
                    if(i%Integer.parseInt(p_repeatNum.get(position)) == 0){
                        row = new LinearLayout(MyParkingInfo.this);
                        row.setLayoutParams(new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT));
                        row.setOrientation(LinearLayout.HORIZONTAL);
                        area.addView(row);
                        rowNum++;
                    }
                    Button button = new Button(MyParkingInfo.this);
                    button.setLayoutParams(new LinearLayout.LayoutParams(0, 100,1f));
                    button.setTextSize(10);
                    button.setPadding(0,0,0,0);

                    try {
                        if(p_contentArray.get(i).toString().equals("0")){
                            button.setStateListAnimator(null);
                            button.setText(" ");
                            button.setEnabled(false);
                            button.setBackgroundResource(R.drawable.pass);
                        }else{
                            button.setText(String.valueOf(++parkingIndex));
                            button.setId(parkingIndex);
                            button.setBackgroundResource(R.drawable.white);

                            if(Integer.parseInt(p_num.get(position))==parkingIndex){
                                button.setBackgroundResource(R.drawable.red);
                            }
                        }
                    }catch (Exception e){
                        e.printStackTrace();
                    }
                    row.addView(button);
                }

            }else{
                TextView textView = new TextView(MyParkingInfo.this);
                textView.setText("주차예약정보가 없습니다.");
                textView.setTextSize(20);
                textView.setTextColor(Color.rgb(0,0,255));

                area.addView(textView);
            }
            rowView.setPadding(0,90,0,0);
            return rowView;

        }
    }

}