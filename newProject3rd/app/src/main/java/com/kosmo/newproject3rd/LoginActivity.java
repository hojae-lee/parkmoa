package com.kosmo.newproject3rd;

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
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import com.kakao.auth.ApprovalType;
import com.kakao.auth.AuthType;
import com.kakao.auth.IApplicationConfig;
import com.kakao.auth.ISessionConfig;
import com.kakao.auth.KakaoAdapter;
import com.kakao.usermgmt.LoginButton;
import com.nhn.android.naverlogin.OAuthLogin;
import com.nhn.android.naverlogin.OAuthLoginHandler;
import com.nhn.android.naverlogin.ui.view.OAuthLoginButton;

import org.json.JSONArray;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

public class LoginActivity extends AppCompatActivity {

    String TAG = "iKOSMO";
    static Context context;
    static final Map<String,Object> navermap = new HashMap<String,Object>();
    private OAuthLoginButton naverLogInButton;
    private static OAuthLogin naverLoginInstance;
    static final String CLIENT_ID = "j6kMUm6QYBmwTHvbN1KS";
    static final String CLIENT_SECRET = "Sn0wuVhDpp";
    static final String CLIENT_NAME = "네이버 아이디로 로그인 테스트";
    EditText id,pw;
    ProgressDialog dialog;//요청/응답 대기시 프로그레스창 or 서버와 통신중 띄워줄 진행대화창.
    int buttonResId;
    String sessionKey = "SESSION_INFO";
    SharedPreferences.Editor editor;
    String testid;
    PendingIntent intent;
    public static final int NOTIFICATION_ID = 1;
    private Button btn_custom_login;
    private LoginButton btn_kakao_login;
    private Context mContext;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);
        init();
        init_View();
        naverLoginInstance.getAccessToken(context);
        id = (EditText)findViewById(R.id.idform);
        pw = (EditText)findViewById(R.id.passform);
        Button btnJson = (Button)findViewById(R.id.btn_login);
        //회원리스트 버튼을 눌렀을때 AsyncHttpRequest 객체생성 및 실행
        btnJson.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View view) {
                buttonResId = view.getId();

                new AsyncHttpRequest().execute(
                        "http://192.168.219.157:8080/project3rd/parkmoa/androidLoginAction.do"
                        ,"m_id="+id.getText().toString()//뒤에있는 parameter 을전달.
                        ,"m_pw="+pw.getText().toString()
                );
            }
        });

        //진행대화창을 띄우기 위한 객체생성
        dialog = new ProgressDialog(this);
        //프로그레스바 스타일 설정(원형)
        dialog.setProgressStyle(ProgressDialog.STYLE_SPINNER);
        //아이콘 설정
        dialog.setIcon(android.R.drawable.ic_dialog_alert);
        //제목설정
        dialog.setTitle("회원정보 리스트 가져오기");
        //메세지 설정
        dialog.setMessage("서버로부터 응답을 기다리고 있습니다.");
        //back키를 눌렀을때 취소되지 않도록 하는 설정(AlertDialog에도 있음)
        dialog.setCancelable(false);


        final Button find_id = (Button)findViewById(R.id.find_id);
        find_id.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(v.getContext(),find_id.class);
                startActivity(intent);
            }
        });

        Button backToMain = (Button)findViewById(R.id.backToMain);
        backToMain.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();

            }
        });

        Button find_pw = (Button)findViewById(R.id.find_pw);
        find_pw.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(v.getContext(),find_pw.class);
                startActivity(intent);
                overridePendingTransition(R.anim.slide_in_right, R.anim.hold);
            }
        });

        Button memberRegist = (Button)findViewById(R.id.memberRegist);
        memberRegist.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(v.getContext(),memberRegist.class );
                startActivity(intent);
                overridePendingTransition(R.anim.slid_in_right, R.anim.hold);
            }
        });

    }//oncreate
    //초기화
    private void init(){
        context = this;
        naverLoginInstance = OAuthLogin.getInstance();
        naverLoginInstance.init(this,CLIENT_ID,CLIENT_SECRET,CLIENT_NAME);
    }
    //변수 붙이기
    private void init_View(){
        naverLogInButton = (OAuthLoginButton)findViewById(R.id.buttonNaverLogin);

        //로그인 핸들러
        OAuthLoginHandler naverLoginHandler  = new OAuthLoginHandler() {
            @Override
            public void run(boolean success) {
                if (success) {//로그인 성공
                    new RequestApiTask().execute();
                    //Toast.makeText(context,"로그인 성공"+"아이디:"+navermap.get("id")+",이메일:"+navermap.get("email"),Toast.LENGTH_SHORT).show();

                } else {//로그인 실패
                    String errorCode = naverLoginInstance.getLastErrorCode(context).getCode();
                    String errorDesc = naverLoginInstance.getLastErrorDesc(context);
                    Toast.makeText(context, "errorCode:" + errorCode + ", errorDesc:" + errorDesc, Toast.LENGTH_SHORT).show();
                }
            }
        };

        naverLogInButton.setOAuthLoginHandler(naverLoginHandler);


    }
    private class RequestApiTask extends AsyncTask<Void, Void, String> {
        @Override
        protected void onPreExecute() {//작업이 실행되기 전에 먼저 실행.
            //tv_mail.setText((String) "");//메일 란 비우기
            //tv_id.setText((String) "");
        }

        @Override
        protected String doInBackground(Void... params) {//네트워크에 연결하는 과정이 있으므로 다른 스레드에서 실행되어야 한다.
            String url = "https://openapi.naver.com/v1/nid/me";
            String at = naverLoginInstance.getAccessToken(context);


            return naverLoginInstance.requestApi(context, at, url);//url, 토큰을 넘겨서 값을 받아온다.json 타입으로 받아진다.

        }

        protected void onPostExecute(String content) {//doInBackground 에서 리턴된 값이 여기로 들어온다.
            try {
                JSONObject jsonObject = new JSONObject(content);
                JSONObject response = jsonObject.getJSONObject("response");
                String email = response.getString("email");
                String id = response.getString("id");

                navermap.put("email",email);
                navermap.put("id",id);

                new AsyncHttpRequest2().execute(
                        "http://192.168.219.157:8080/project3rd/parkmoa/androidnaverAction.do"
                        ,"m_id="+id
                        ,"m_email="+email
                );
                intent = PendingIntent.getActivity(LoginActivity.this, 0,
                        new Intent(getApplicationContext(), MainActivity.class), PendingIntent.FLAG_UPDATE_CURRENT);

                NotificationManager notificationManager = (NotificationManager)getSystemService(Context.NOTIFICATION_SERVICE);
                Notification.Builder builder;
                if(Build.VERSION.SDK_INT >=Build.VERSION_CODES.O){

                    //Android8.0(Oreo) API26이상일때 채널생성 필요.
                    NotificationChannel notificationChannel =
                            new NotificationChannel("kosmo_id","kosmo_name",
                                    NotificationManager.IMPORTANCE_DEFAULT);
                    notificationChannel.setDescription("코스모채널입니다");
                    notificationChannel.enableLights(true);
                    notificationChannel.setLightColor(Color.GREEN);
                    notificationChannel.enableVibration(true);
                    notificationChannel.setVibrationPattern(new long[]{100,200,100,200});
                    notificationChannel.setLockscreenVisibility(Notification.VISIBILITY_PRIVATE);
                    //notificationCompat.Builder - deprecated
                    //notification.builder를 사용하여 알림을 설정한다.
                    notificationManager.createNotificationChannel(notificationChannel);
                    builder = new Notification.Builder(LoginActivity.this,"kosmo_id");
                }
                else{
                    //Android7.0 api25이하일때 채널생성 필요없음.
                    builder = new Notification.Builder(LoginActivity.this);
                }
                //알림바에 표시되는 아이콘
                builder.setSmallIcon(R.drawable.android);
                //사용자가 알림바를 클릭할때 실행할 인텐트 지정.
                builder.setContentIntent(intent);
                //알림바에 표시되는 아이콘
                builder.setLargeIcon(BitmapFactory.decodeResource(getResources(),R.drawable.android));
                //알림제목
                builder.setContentTitle("파크모아 로그인");
                //알림 내용
                builder.setContentText(id+"님 환영합니다.");
                /*
                알림의 서브텍스트 (API16[android4.1 젤리빈] 이상에서만 표시됨.
                 */
                builder.setSubText("방문을 환영합니다.");
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

                Log.d(TAG,navermap.toString());
                Log.d(TAG,email);
                Log.d(TAG,id);



                //id.(email);//메일 란 채우기

                //tv_id.setText(id);//아이디란 채우기
            }
            catch (Exception e){
                e.printStackTrace();
            }
        }
    }
    class AsyncHttpRequest2 extends  AsyncTask<String,Void,String>{
        @Override
        protected void onPreExecute() {
            super.onPreExecute();
            if (!dialog.isShowing()) {
                dialog.show();
            }
        }

        @Override
        protected String doInBackground(String... strings) {
            StringBuffer sBuffer = new StringBuffer();
            try {
                //접속할 (첫번째 파라미터)를 통해 URL 객체생성 및 연결
                URL url = new URL(strings[0]);
                HttpURLConnection connection = (HttpURLConnection) url.openConnection();
                //POST 방식으로 통신설정(디폴트 Get방식)
                connection.setRequestMethod("POST");
                /*
                OutPutStream으로 파라미터를 전달할때 post방식으로 하겠다는 설정.
                만약 위에서 get으로 설정하더라도 아래 코드가 추가 되면 post방식으로 변경된다.
                 */
                connection.setDoOutput(true);

                /*
                요청 파라미터 설정
                    - 파라미터는 쿼리스트링 형태로 지정된다.
                    - 한글의 경우 URL인코딩을 해야한다.
                 : Request Body에 Data를 담기 위해 OutputStream을 생성한다.
                 */
                OutputStream out = connection.getOutputStream();
                out.write(strings[1].getBytes());
                out.write("&".getBytes());
                out.write(strings[2].getBytes());
                /*
                파라미터가 2개 이상이라면 &로 문자열을 연결
                 out.write("&".getBytes());
                 out.write(params[2].getBytes());
                 */
                out.flush();
                out.close();

                //서버에 요청이 전달되고 성공이라면 HTTP_OK로 확인인
                if (connection.getResponseCode() == HttpURLConnection.HTTP_OK) {

                    //서버로부터 받는 응답 내용
                    BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream(), "UTF-8"));

                    String responseData;
                    //내용을 한줄씩 읽어서 StringBuffer 변수에 저장함
                    while ((responseData = reader.readLine()) != null) {
                        sBuffer.append(responseData + "\n\r");
                    }
                    reader.close();
                }
                else {
                    //서버와 연결실패
                    Log.i("AsyncTask Class", "HTTP_OK안됨");
                }
                try {
                    JSONObject JsonObject = new JSONObject(sBuffer.toString());
                    int result = Integer.parseInt(JsonObject.getString("exist"));
                    Log.i(TAG, "exist=" + result);
                    sBuffer.setLength(0);

                    //기존회원인경우
                    if (result == 1) {
                        JSONObject memberInfo = JsonObject.getJSONObject("memberInfo");
                        String id = memberInfo.getString("m_id").toString();
                        String pass = memberInfo.getString("m_pw").toString();

                        Log.i(TAG, "id=" + id + ",pass=" + pass);

                        SharedPreferences sf = getSharedPreferences(sessionKey, 0);
                        SharedPreferences.Editor editor = sf.edit();
                        editor.putString("USER_ID", id);
                        editor.putString("USER_PW", pass);
                        editor.commit();

                        Log.i(TAG, "로그인 성공");
                        sBuffer.append("success");
                    }
                    else if(result ==0){
                        sBuffer.append("newMember");
                    }
                    else {
                        Log.i(TAG, "로그인실패");
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
        protected void onPostExecute(String s) {
            super.onPostExecute(s);
            dialog.dismiss();
            if(s.equals("success")){
                Intent intent = new Intent(getApplicationContext(),MainActivity.class);
                startActivity(intent);
                //overridePendingTransition(R.);
                finish();
            }
            else if(s.equals("newMember")){
                Intent intent = new Intent(getApplicationContext(),memberRegist.class);
                startActivity(intent);
                finish();
            }
            else if(s.equals("fail")){
                Toast.makeText(getApplicationContext(), "로그인실패", Toast.LENGTH_SHORT).show();
            }
        }
    }

    class AsyncHttpRequest extends AsyncTask<String,Void, String> {
        @Override
        protected void onPreExecute() {
            super.onPreExecute();

            //doInBackground 실행전 진행대화창이 없다면 띄워준다.
            if (!dialog.isShowing()) {
                dialog.show();
            }
        }

        /*
        execute()메소드 호출시 전달한 2개의 매개변수를 가변인자가 받음.
        사용시에는 배열형태로 사용함.
         */
        @Override
        protected String doInBackground(String... strings) {

            StringBuffer sBuffer = new StringBuffer();
            try {
                //접속할 (첫번째 파라미터)를 통해 URL 객체생성 및 연결
                URL url = new URL(strings[0]);
                HttpURLConnection connection = (HttpURLConnection) url.openConnection();
                //POST 방식으로 통신설정(디폴트 Get방식)
                connection.setRequestMethod("POST");
                /*
                OutPutStream으로 파라미터를 전달할때 post방식으로 하겠다는 설정.
                만약 위에서 get으로 설정하더라도 아래 코드가 추가 되면 post방식으로 변경된다.
                 */
                connection.setDoOutput(true);

                /*
                요청 파라미터 설정
                    - 파라미터는 쿼리스트링 형태로 지정된다.
                    - 한글의 경우 URL인코딩을 해야한다.
                 : Request Body에 Data를 담기 위해 OutputStream을 생성한다.
                 */
                OutputStream out = connection.getOutputStream();
                out.write(strings[1].getBytes());
                out.write("&".getBytes());
                out.write(strings[2].getBytes());
                /*
                파라미터가 2개 이상이라면 &로 문자열을 연결
                 out.write("&".getBytes());
                 out.write(params[2].getBytes());
                 */
                out.flush();
                out.close();

                //서버에 요청이 전달되고 성공이라면 HTTP_OK로 확인인
                if (connection.getResponseCode() == HttpURLConnection.HTTP_OK) {

                    //서버로부터 받는 응답 내용
                    BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream(), "UTF-8"));

                    String responseData;
                    //내용을 한줄씩 읽어서 StringBuffer 변수에 저장함
                    while ((responseData = reader.readLine()) != null) {
                        sBuffer.append(responseData + "\n\r");
                    }
                    reader.close();
                } else {
                    //서버와 연결실패
                    Log.i("AsncTask Class", "HTTP_OK안됨");
                }
                try {
                    JSONObject JsonObject = new JSONObject(sBuffer.toString());
                    int result = Integer.parseInt(JsonObject.getString("success"));
                    //Log.i(TAG, "result=" + result);
                    sBuffer.setLength(0);

                    if (result == 1) {
                        JSONObject memberInfo = JsonObject.getJSONObject("memberInfo");
                        String id = memberInfo.getString("m_id").toString();
                        String pass = memberInfo.getString("m_pw").toString();

                        //Log.i(TAG, "id=" + id + ",pass=" + pass);

                        SharedPreferences sf = getSharedPreferences(sessionKey, 0);
                        SharedPreferences.Editor editor = sf.edit();
                        editor.putString("USER_ID", id);
                        editor.putString("USER_PW", pass);
                        editor.commit();

                        Log.i(TAG, "로그인 성공");
                        sBuffer.append("success");
                    } else {
                        Log.i(TAG, "로그인실패");
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
        protected void onPostExecute (String s){
            super.onPostExecute(s);

            //대화창닫기
            dialog.dismiss();

            if (s.equals("fail")) {
                Toast.makeText(getApplicationContext(), "로그인실패", Toast.LENGTH_SHORT).show();
            } else {

                intent = PendingIntent.getActivity(LoginActivity.this, 0,
                        new Intent(getApplicationContext(), MainActivity.class), PendingIntent.FLAG_UPDATE_CURRENT);

                NotificationManager notificationManager = (NotificationManager)getSystemService(Context.NOTIFICATION_SERVICE);
                Notification.Builder builder;
                if(Build.VERSION.SDK_INT >=Build.VERSION_CODES.O){

                    //Android8.0(Oreo) API26이상일때 채널생성 필요.
                    NotificationChannel notificationChannel =
                            new NotificationChannel("kosmo_id","kosmo_name",
                                    NotificationManager.IMPORTANCE_DEFAULT);
                    notificationChannel.setDescription("코스모채널입니다");
                    notificationChannel.enableLights(true);
                    notificationChannel.setLightColor(Color.GREEN);
                    notificationChannel.enableVibration(true);
                    notificationChannel.setVibrationPattern(new long[]{100,200,100,200});
                    notificationChannel.setLockscreenVisibility(Notification.VISIBILITY_PRIVATE);
                    //notificationCompat.Builder - deprecated
                    //notification.builder를 사용하여 알림을 설정한다.
                    notificationManager.createNotificationChannel(notificationChannel);
                    builder = new Notification.Builder(LoginActivity.this,"kosmo_id");
                }
                else{
                    //Android7.0 api25이하일때 채널생성 필요없음.
                    builder = new Notification.Builder(LoginActivity.this);
                }
                //알림바에 표시되는 아이콘
                builder.setSmallIcon(R.drawable.android);
                //사용자가 알림바를 클릭할때 실행할 인텐트 지정.
                builder.setContentIntent(intent);
                //알림바에 표시되는 아이콘
                builder.setLargeIcon(BitmapFactory.decodeResource(getResources(),R.drawable.android));
                //알림제목
                builder.setContentTitle("파크모아 로그인");
                //알림 내용
                builder.setContentText("파크모아에 접속하셨습니다.방문을 환영합니다.");
                /*
                알림의 서브텍스트 (API16[android4.1 젤리빈] 이상에서만 표시됨.
                 */
                builder.setSubText("방문을 환영합니다.");
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

                Intent intent = new Intent(getApplicationContext(), MainActivity.class);
                startActivity(intent);
                overridePendingTransition(R.anim.slide_in_right, R.anim.hold);
                finish();
            }
        }
    }



}