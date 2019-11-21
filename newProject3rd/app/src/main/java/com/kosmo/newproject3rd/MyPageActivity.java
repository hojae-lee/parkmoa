package com.kosmo.newproject3rd;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ImageButton;
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

public class MyPageActivity extends AppCompatActivity {

    ImageButton paymentHistory,qrcode,refresh,parkingInfo;

    final static String TAG ="kosmo";
    String sessionKey = "SESSION_INFO";//로그인 아이디 저장용
    String serverUrl = "";
    ProgressDialog dialog;
    ListView listView;

    ArrayList<String> m_id = new ArrayList<String>();
    ArrayList<String> m_email = new ArrayList<String>();
    ArrayList<String> m_regidate = new ArrayList<String>();
    ArrayList<String> m_membership = new ArrayList<String>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_my_page);

        paymentHistory = (ImageButton) findViewById(R.id.paymentHistory);
        paymentHistory.setOnClickListener(onClickListener);
        qrcode = (ImageButton)findViewById(R.id.qrcode);
        qrcode.setOnClickListener(onClickListener);
        refresh = (ImageButton)findViewById(R.id.refresh);
        refresh.setOnClickListener(onClickListener);

        parkingInfo = (ImageButton) findViewById(R.id.parkingInfo);
        parkingInfo.setOnClickListener(onClickListener);


        serverUrl = getString(R.string.serverUrl);

        dialog = new ProgressDialog(this);
        dialog.setProgressStyle(ProgressDialog.STYLE_SPINNER);
        dialog.setIcon(android.R.drawable.ic_dialog_alert);
        dialog.setTitle("서버 데이터 수신");
        dialog.setMessage("서버로부터 데이터 수신중입니다.");

        Button returnToMain = (Button)findViewById(R.id.returnToMain);
        returnToMain.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });

        SharedPreferences sf = getSharedPreferences(sessionKey,0);
        String sid = sf.getString("USER_ID","");
        String spw = sf.getString("USER_PW","");
        String temp = "kosmo1";

        //게시판 리스트를 JSON으로 가져오기
        new AsyncHttpRequest().execute(
                serverUrl+"project3rd/parkmoa/androidPersonInfo.do",
                "m_id="+sid
        );
    }

    View.OnClickListener onClickListener = new View.OnClickListener() {
        @Override
        public void onClick(View v) {

            if(v.getId() == R.id.refresh){
                Intent intent = getIntent();
                finish();
                startActivity(intent);
            }

            if (v.getId() == R.id.paymentHistory) {
                Intent intent = new Intent(v.getContext(), MyPaymentHistory.class);
                startActivity(intent);

            }
            if (v.getId() == R.id.parkingInfo) {
                Intent intent = new Intent(v.getContext(), MyParkingInfo.class);
                startActivity(intent);
            }

            else if (v.getId() == R.id.qrcode){
                Intent intent = new Intent(v.getContext(),qrcode2.class);
                startActivity(intent);
            }
        }

    };

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

                    DecimalFormat myFormatter = new DecimalFormat("###,###");
                    String formattedStringPrice = myFormatter.format(Integer.parseInt(boardRecord.getString("m_membership")));

                    m_id.add(boardRecord.getString("m_id"));
                    m_email.add(boardRecord.getString("m_email"));
                    m_membership.add(formattedStringPrice);
                    m_regidate.add(boardRecord.getString("m_regidate"));
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
            CustomList customList = new CustomList(MyPageActivity.this);
            listView = (ListView) findViewById(R.id.myinfoList);
            listView.setAdapter(customList);

        }
    }
    public class CustomList extends ArrayAdapter<String> {

        private final Activity context;

        public CustomList(Activity context){
            super(context, R.layout.my_information, m_id);
            this.context = context;
        }

        @NonNull
        @Override
        public View getView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {

            LayoutInflater inflater = context.getLayoutInflater();
            View rowView = inflater.inflate(R.layout.my_information,null,true);

            //위젯가져오기
            //ImageView imageView = (ImageView)rowView.findViewById(R.id.image);

            TextView m_idTV = (TextView)rowView.findViewById(R.id.m_id);
            TextView m_emailTV = (TextView)rowView.findViewById(R.id.m_email);
            TextView m_membershipTV = (TextView)rowView.findViewById(R.id.m_membership);
            TextView m_regidateTV = (TextView)rowView.findViewById(R.id.m_regidate);

            Log.i(TAG ,m_id.get(position));

            //뷰에 내용 삽입하기
            //imageView.setImageResource(images[position]);

            m_idTV.setText(m_id.get(position));
            m_emailTV.setText(m_email.get(position));
            m_membershipTV.setText(m_membership.get(position));
            m_regidateTV.setText(m_regidate.get(position));

            return rowView;
        }
    }//CustomList


}