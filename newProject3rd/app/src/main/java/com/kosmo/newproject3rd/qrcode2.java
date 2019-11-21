package com.kosmo.newproject3rd;


import android.app.Activity;
import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.os.AsyncTask;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import com.google.zxing.integration.android.IntentIntegrator;
import com.google.zxing.integration.android.IntentResult;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;


public class qrcode2 extends AppCompatActivity {

    //view Objects
    private Button buttonScan;
    private TextView textViewName, textViewAddress, textViewResult;
    Map<String, String> mapDto = new HashMap<>();
    //qr code scanner object
    private IntentIntegrator qrScan;
    ProgressDialog dialog;
    String sessionKey = "SESSION_INFO";
    PendingIntent intent;
    public static final int NOTIFICATION_ID = 1;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_qrcode2);

        //ProgressDialog객체생성
        dialog = new ProgressDialog(this);
        dialog.setProgressStyle(ProgressDialog.STYLE_SPINNER);
        dialog.setIcon(android.R.drawable.ic_dialog_alert);
        dialog.setTitle("서버 데이터 수신");
        dialog.setMessage("서버로부터 데이터 수신중입니다.");

        //View Objects
        buttonScan = (Button) findViewById(R.id.buttonScan);
        textViewName = (TextView) findViewById(R.id.textViewName);
        /*textViewAddress = (TextView) findViewById(R.id.textViewAddress);*/
        textViewResult = (TextView)  findViewById(R.id.textViewResult);

        //intializing scan object
        qrScan = new IntentIntegrator(this);

        //button onClick
        buttonScan.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                //scan option
                qrScan.setPrompt("Scanning...");
                //qrScan.setOrientationLocked(false);
                qrScan.initiateScan();
            }
        });
    }

    //Getting the scan results
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data){
        IntentResult result = IntentIntegrator.parseActivityResult(requestCode, resultCode, data);
        if (result != null) {
            //qrcode 가 없으면
            if (result.getContents() == null) {
                Toast.makeText(qrcode2.this, "취소!", Toast.LENGTH_SHORT).show();
            } else {
                //qrcode 결과가 있으면
                Toast.makeText(qrcode2.this, "마일리지적립완료!", Toast.LENGTH_SHORT).show();
                try {
                    //data를 json으로 변환
                    JSONObject obj = new JSONObject(result.getContents());
                    textViewName.setText(obj.getString("name"));
                    textViewAddress.setText(obj.getString("address"));

                } catch (JSONException e) {
                    e.printStackTrace();
                    //Toast.makeText(MainActivity.this, result.getContents(), Toast.LENGTH_LONG).show();
                    textViewResult.setText(result.getContents());
                    SharedPreferences sf = getSharedPreferences(sessionKey,0);
                    String sid = sf.getString("USER_ID","");
                    new AsyncHttpRequest().execute(
                            //파라미터로 넘겨야 할게 m_id랑 마일리지값... 세션아이디로 바꾸시오..!!
                            "http://192.168.219.157:8080/project3rd/parkmoa/qrcode.do",
                            "m_id="+sid,
                            "membership="+result.getContents()
                    );

                }
            }

        } else {
            super.onActivityResult(requestCode, resultCode, data);
        }
    }
    class AsyncHttpRequest extends AsyncTask<String,Void,String>
    {
        //실행전 호출되는 메소드
        @Override
        protected void onPreExecute() {
            super.onPreExecute();
            if(!dialog.isShowing()){
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
                out.write("&".getBytes());
                out.write(strings[2].getBytes());
                /*
                파라미터없음
                out.write("&".getBytes());
                out.write(strings[2].getBytes());
                */
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
                JSONObject jsonObject = new JSONObject(jsonString.toString());

                //map에 저장
                mapDto.put("success", jsonObject.getString("success"));
                mapDto.put("fail", jsonObject.getString("fail"));
            }
            catch (Exception e){
                e.printStackTrace();
            }

            return "JSON Parsing 완료";
        }

        @Override
        protected void onPostExecute(String s) {

            super.onPostExecute(s);
            dialog.dismiss();//대화창닫기

            intent = PendingIntent.getActivity(qrcode2.this, 0,
                    new Intent(getApplicationContext(), MainActivity.class), PendingIntent.FLAG_UPDATE_CURRENT);

            NotificationManager notificationManager = (NotificationManager)getSystemService(Context.NOTIFICATION_SERVICE);
            Notification.Builder builder;
            if(Build.VERSION.SDK_INT >=Build.VERSION_CODES.O){

                //Android8.0(Oreo) API26이상일때 채널생성 필요.
                NotificationChannel notificationChannel =
                        new NotificationChannel("kosmo_id","kosmo_name",
                                NotificationManager.IMPORTANCE_DEFAULT);
                notificationChannel.setDescription("파크모아채널입니다");
                notificationChannel.enableLights(true);
                notificationChannel.setLightColor(Color.GREEN);
                notificationChannel.enableVibration(true);
                notificationChannel.setVibrationPattern(new long[]{100,200,100,200});
                notificationChannel.setLockscreenVisibility(Notification.VISIBILITY_PRIVATE);
                //notificationCompat.Builder - deprecated
                //notification.builder를 사용하여 알림을 설정한다.
                notificationManager.createNotificationChannel(notificationChannel);
                builder = new Notification.Builder(qrcode2.this,"kosmo_id");
            }
            else{
                //Android7.0 api25이하일때 채널생성 필요없음.
                builder = new Notification.Builder(qrcode2.this);
            }
            //알림바에 표시되는 아이콘
            builder.setSmallIcon(R.drawable.android);
            //사용자가 알림바를 클릭할때 실행할 인텐트 지정.
            builder.setContentIntent(intent);
            //알림바에 표시되는 아이콘
            builder.setLargeIcon(BitmapFactory.decodeResource(getResources(),R.drawable.android));
            //알림제목
            builder.setContentTitle("파크모아");
            //알림 내용
            builder.setContentText("마일리지가 적립되셨습니다.");
                /*
                알림의 서브텍스트 (API16[android4.1 젤리빈] 이상에서만 표시됨.
                 */
            builder.setSubText("원하시는 상품을 사러 가보세요!");
                /*
                알림방법
                    DEFAULT_SOUND: 알림 소리가 난다. (단말에 설정된 알림사운드)
                    DEFAULT_VIBRATE : 진동으로 알려준다.
                 */
            builder.setDefaults(Notification.DEFAULT_SOUND);
                /*
                알림바를 클릭했을때 상태바에서 제거할지 여부 설정
                    true : 클릭했을때 제거됨
                    false : 클릭해도 제거되지 않고 유지됨.
                 */
            builder.setAutoCancel(true);

            //NotificationManager notificationManager = (NotificationManager)getSystemService((NOTIFICATION_SERVICE));
            //알림바에 알림을 표시한다.
            notificationManager.notify(NOTIFICATION_ID,builder.build());
            overridePendingTransition(R.anim.slide_in_right, R.anim.hold);
            finish();
        }
    }////AsyncHttpRequest class


}