package com.kosmo.newproject3rd;


import androidx.appcompat.app.AppCompatActivity;

import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.Gravity;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import org.json.JSONArray;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

public class find_id extends AppCompatActivity {

    String TAG = "iKOSMO";
    EditText m_name, m_mobile;
    Button find_id,backToLogin;
    String id;

    ProgressDialog dialog;//요청/응답 대기시 프로그레스창 or 서버와 통신중 띄워줄 진행대화창.
    StringBuffer sBuffer = new StringBuffer();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.findid);

        find_id = (Button) findViewById(R.id.find_id);
        backToLogin = (Button)findViewById(R.id.backToLogin);

        find_id.setOnClickListener(onClickListener);
        backToLogin.setOnClickListener(onClickListener);

        dialog = new ProgressDialog(this);
        dialog.setProgressStyle(ProgressDialog.STYLE_SPINNER);
        dialog.setIcon(android.R.drawable.ic_dialog_info);
        dialog.setTitle("처리중");
        dialog.setMessage("서버로부터 응답을 기다리고 있습니다.");


    }
    View.OnClickListener onClickListener = new View.OnClickListener(){
        @Override
        public void onClick(View v){


            if(v.getId() == R.id.find_id){
                m_name =(EditText)findViewById(R.id.m_name);
                m_mobile =(EditText)findViewById(R.id.m_mobile);

                new AsyncHttpRequest ().execute(
                        "http://192.168.219.157:8080/project3rd/parkmoa/AndroidfindIdAction.do",
                        "m_name="+m_name.getText().toString(),
                        "m_mobile="+m_mobile.getText().toString()

                );

            }
            else if(v.getId()==R.id.backToLogin){
                Intent intent = new Intent(v.getContext(),LoginActivity.class);
                startActivity(intent);
                overridePendingTransition(R.anim.slide_in_right, R.anim.hold);
            }

        }
    };

    class AsyncHttpRequest extends AsyncTask<String,Void,String> {
        @Override
        protected void onPreExecute() {
            super.onPreExecute();

            if(!dialog.isShowing()){
                dialog.show();
            }
        }

        @Override
        protected String doInBackground(String... strings) {

            StringBuffer sBuffer = new StringBuffer();

            try {
                URL url = new URL(strings[0]);
                HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                conn.setRequestMethod("POST");
                conn.setDoOutput(true);
                OutputStream out = conn.getOutputStream();
                out.write(strings[1].getBytes());

                out.write("&".getBytes());
                out.write(strings[2].getBytes());

                out.flush();
                out.close();

                if (conn.getResponseCode() == HttpURLConnection.HTTP_OK) {
                    BufferedReader reader = new BufferedReader(
                            new InputStreamReader(conn.getInputStream(), "UTF-8")

                    );
                    String data;
                    while ((data = reader.readLine()) != null) {
                        sBuffer.append(data + "\r\n");
                    }
                    reader.close();
                    Log.i(TAG, "HTTP_OK");
                    Log.i(TAG, sBuffer.toString());
                } else {
                    Log.i(TAG, "HTTP_OK 안됌");
                }
                try {
                    JSONObject JsonObject = new JSONObject(sBuffer.toString());
                    int result = Integer.parseInt(JsonObject.getString("success"));
                    Log.i(TAG, "result=" + result);
                    sBuffer.setLength(0);

                    if (result == 1) {
                        JSONObject memberInfo = JsonObject.getJSONObject("memberInfo");
                        id = memberInfo.getString("m_id").toString();
                        Log.i(TAG, "찾으시는 아이디 id=" + id );

                        Log.i(TAG, "아이디 찾기 성공");
                        sBuffer.append("success");
                    } else {
                        Log.i(TAG, "아이디 찾기 실패");
                        sBuffer.append("fail");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return sBuffer.toString();
        }

        @Override
        protected void onPostExecute(String s){
            super.onPostExecute(s);

            //대화창닫기
            dialog.dismiss();

            if(s.equals("fail")) {
                Toast.makeText(getApplicationContext(), "ID찾기 실패. 입력하신 내용을 확인하세요", Toast.LENGTH_SHORT).show();
            }
            else{

                AlertDialog.Builder alert = new AlertDialog.Builder(find_id.this);
                alert.setTitle("아이디 찾기");
                alert.setPositiveButton("확인", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        dialog.dismiss();     //닫기
                        Intent intent = new Intent(getApplicationContext(),LoginActivity.class);
                        startActivity(intent);
                    }
                });
                alert.setMessage("찾으시는 아이디는 "+ id + "입니다.");
                alert.show();

                /*Toast.makeText(getApplicationContext(), "찾으시는 아이디는"+ id + "입니다.", Toast.LENGTH_LONG).show();
                Intent intent = new Intent(getApplicationContext(),LoginActivity.class);
                startActivity(intent);
                overridePendingTransition(R.anim.slide_in_right, R.anim.hold);
                finish();*/
            }

        }
    }

}
