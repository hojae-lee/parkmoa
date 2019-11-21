package com.kosmo.newproject3rd;


import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Intent;
import android.content.SharedPreferences;
import android.nfc.Tag;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.TextView;

import org.json.JSONArray;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;

public class MyPaymentHistory extends AppCompatActivity {
    final static String TAG ="kosmo";
    String sessionKey = "SESSION_INFO";//로그인 아이디 저장용
    String serverUrl = "";
    ProgressDialog dialog;

    ListView listView;
    ArrayList<String> P_IDX = new ArrayList<String>();
    ArrayList<String> pay_group = new ArrayList<String>();
    ArrayList<String> m_id = new ArrayList<String>();
    ArrayList<String> pay_price = new ArrayList<String>();
    ArrayList<String> pay_regidate = new ArrayList<String>();
    ArrayList<String> tp_name = new ArrayList<String>();
    ArrayList<String> t_name = new ArrayList<String>();
    ArrayList<String> p_num = new ArrayList<String>();
    ArrayList<String> r_useregi = new ArrayList<String>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.activity_my_payment_history);

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

        //게시판 리스트를 JSON으로 가져오기
        new AsyncHttpRequest().execute(
                serverUrl+"project3rd/parkmoa/androidPaymentList.do",
                "m_id="+sid
        );
    }
    class AsyncHttpRequest extends AsyncTask<String,Void,String> {
        //실행전 호출되는 메소드
        @Override
        protected void onPreExecute() {
            super.onPreExecute();
            if (!dialog.isShowing()) {
                dialog.show();
            }
        }

        //실행
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

                /*
                파라미터없음
                out.write(strings[1].getBytes());
                out.write("&".getBytes());
                out.write(strings[2].getBytes());*/
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
            catch (Exception e){
                e.printStackTrace();
            }

            //JSON Array 파싱
            try {
                //서버에서 가져온 데이터 출력
                //Log.i(jsonString.toString());

                System.out.println(jsonString.toString());
                JSONArray boardArray = new JSONArray(jsonString.toString());
                for (int i = 0; i < boardArray.length(); i++)
                {
                    JSONObject boardRecord = boardArray.getJSONObject(i);

                    P_IDX.add(boardRecord.getString("p_idx"));
                    pay_group.add(boardRecord.getString("pay_group"));
                    m_id.add(boardRecord.getString("m_id"));
                    pay_price.add(boardRecord.getString("pay_price"));
                    pay_regidate.add(boardRecord.getString("pay_regidate"));
                    tp_name.add(boardRecord.getString("tp_name"));
                    t_name.add(boardRecord.getString("t_name"));
                    p_num.add(boardRecord.getString("p_num"));
                    r_useregi.add(boardRecord.getString("r_useregi"));

                }
            }
            catch (Exception e){
                e.printStackTrace();
            }

            return jsonString.toString();
        }

        //doInBackground 메소드 정상종료시 호출되는 메소드
        @Override
        protected void onPostExecute(String s) {
            super.onPostExecute(s);
            dialog.dismiss();//대화창닫기

            //커스텀뷰
            CustomList customList = new CustomList(MyPaymentHistory.this);
            listView = (ListView) findViewById(R.id.mainList);
            listView.setAdapter(customList);

        }
    }
    public class CustomList extends ArrayAdapter<String> {

        private final Activity context;

        public CustomList(Activity context){
            super(context, R.layout.mypayment_history, P_IDX);
            this.context = context;
        }

        @NonNull
        @Override
        public View getView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {

            LayoutInflater inflater = context.getLayoutInflater();
            View rowView = inflater.inflate(R.layout.mypayment_history,null,true);

            //위젯가져오기
            //ImageView imageView = (ImageView)rowView.findViewById(R.id.image);
            TextView pay_groupTV = (TextView)rowView.findViewById(R.id.pay_group);
            TextView m_idTV = (TextView)rowView.findViewById(R.id.m_id);
            TextView pay_priceTV = (TextView)rowView.findViewById(R.id.pay_price);
            TextView pay_regidateTV = (TextView)rowView.findViewById(R.id.pay_regidate);
            TextView tp_nameTV = (TextView)rowView.findViewById(R.id.tp_name);
            TextView t_nameTV = (TextView)rowView.findViewById(R.id.t_name);
            TextView p_numTV = (TextView)rowView.findViewById(R.id.p_num);
            TextView r_useregiTV = (TextView)rowView.findViewById(R.id.r_useregi);
            Log.i(TAG ,tp_name.get(position));
            //뷰에 내용 삽입하기
            //imageView.setImageResource(images[position]);
            pay_groupTV.setText(pay_group.get(position));
            m_idTV.setText(m_id.get(position));
            pay_priceTV.setText(pay_price.get(position));
            pay_regidateTV.setText(pay_regidate.get(position));
            tp_nameTV.setText(tp_name.get(position));
            t_nameTV.setText(t_name.get(position));
            p_numTV.setText(p_num.get(position));
            r_useregiTV.setText(r_useregi.get(position));

            return rowView;
        }
    }//CustomList

}

