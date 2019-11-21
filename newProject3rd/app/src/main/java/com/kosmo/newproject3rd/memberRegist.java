package com.kosmo.newproject3rd;

import androidx.appcompat.app.AppCompatActivity;

import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Color;
import android.os.AsyncTask;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class memberRegist extends AppCompatActivity {
    String TAG = "iKOSMO";
    Button registMember,backToLogin;
    EditText m_id, m_name, m_pw,m_pw1, m_mobile, m_email;

    ProgressDialog dialog;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_member_regist);

        m_pw1 =(EditText)findViewById(R.id.m_pw1);

        registMember = (Button) findViewById(R.id.registMember);
        backToLogin = (Button)findViewById(R.id.backToLogin);

        registMember.setOnClickListener(onClickListener);
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

            if(v.getId() == R.id.registMember){
                m_id =(EditText)findViewById(R.id.m_id);
                m_name =(EditText)findViewById(R.id.m_name);
                m_pw =(EditText)findViewById(R.id.m_pw);
                m_mobile =(EditText)findViewById(R.id.m_mobile);
                m_email = (EditText)findViewById(R.id.m_email);


                if(m_id.getText().toString().length() == 0){
                    Toast.makeText(memberRegist.this, "아이디를 입력하세요", Toast.LENGTH_SHORT).show();
                    m_id.requestFocus();
                    return;
                }
                if(m_name.getText().toString().length() == 0){
                    Toast.makeText(memberRegist.this, "이름을 입력하세요", Toast.LENGTH_SHORT).show();
                    m_name.requestFocus();
                    return;
                }
                if(m_pw.getText().toString().length() == 0){
                    Toast.makeText(memberRegist.this, "비밀번호를 입력하세요", Toast.LENGTH_SHORT).show();
                    m_pw.requestFocus();
                    return;
                }
                if(m_pw1.getText().toString().length() == 0){
                    Toast.makeText(memberRegist.this, "비밀번호 확인을 입력하세요", Toast.LENGTH_SHORT).show();
                    m_pw1.requestFocus();
                    return;
                }
                if(!m_pw.getText().toString().equals(m_pw1.getText().toString())){
                    Toast.makeText(memberRegist.this, "비밀번호가 일치하지 않습니다.", Toast.LENGTH_SHORT).show();
                    m_pw.setText("");
                    m_pw1.setText("");
                    m_pw.requestFocus();
                    return;
                }
                if(m_email.getText().toString().length() == 0){
                    Toast.makeText(memberRegist.this, "Email을 입력하세요", Toast.LENGTH_SHORT).show();
                    m_email.requestFocus();
                    return;
                }
                if(m_email.getText().toString().length() != 0){
                    String regex = "^[_a-zA-Z0-9-\\.]+@[\\.a-zA-Z0-9-]+\\.[a-zA-Z]+$";
                    Pattern p = Pattern.compile(regex);
                    Matcher m = p.matcher(m_email.getText().toString());
                    if(!m.matches()){
                        Toast.makeText(memberRegist.this, "Email 형식으로 입력하세요.",Toast.LENGTH_SHORT).show();
                        m_email.requestFocus();
                        return;
                    }
                }
                if(m_mobile.getText().toString().length() == 0){
                    Toast.makeText(memberRegist.this, "전화번호를 입력하세요", Toast.LENGTH_SHORT).show();
                    m_mobile.requestFocus();
                    return;
                }

                new AsyncHttpRequest().execute(
                        "http://192.168.219.157:8080/project3rd/parkmoa/AndroidMemberRegistAction.do",
                        "m_id="+m_id.getText().toString(),
                        "m_name="+m_name.getText().toString(),
                        "m_pw="+m_pw.getText().toString(),
                        "m_mobile="+m_mobile.getText().toString(),
                        "m_email="+m_email.getText().toString()

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
                out.write("&".getBytes());
                out.write(strings[3].getBytes());
                out.write("&".getBytes());
                out.write(strings[4].getBytes());
                out.write("&".getBytes());
                out.write(strings[5].getBytes());

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
                    Log.i(TAG, "success");
                    sBuffer.setLength(0);

                    if (result == 1) {

                        Log.i(TAG, "회원 가입 성공");
                        sBuffer.append("success");
                    } else {
                        Log.i(TAG, "회원 가입 실패");
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

                Toast.makeText(getApplicationContext(), "회원가입 실패. 중복된 아이디가 있습니다.", Toast.LENGTH_SHORT).show();
                m_id.requestFocus();
            }
            else {

                AlertDialog.Builder alert = new AlertDialog.Builder(memberRegist.this);
                alert.setTitle("회원가입");
                alert.setPositiveButton("확인", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        dialog.dismiss();     //닫기
                        Intent intent = new Intent(getApplicationContext(),LoginActivity.class);
                        startActivity(intent);
                    }
                });
                alert.setMessage("회원가입 성공!");
                alert.show();

            }


        }
    }

}