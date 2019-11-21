package com.kosmo.newproject3rd;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import android.app.AlertDialog;
import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.Signature;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.location.Location;
import android.os.Build;
import android.os.Bundle;
import android.util.Base64;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.ViewFlipper;

import com.kakao.auth.ApprovalType;
import com.kakao.auth.AuthType;
import com.kakao.auth.IApplicationConfig;
import com.kakao.auth.ISessionConfig;
import com.kakao.auth.KakaoAdapter;

import java.security.MessageDigest;
public class MainActivity extends AppCompatActivity {
    private ViewFlipper viewFlipper;
    public static final String TAG = "iKosmo";
    String sessionKey = "SESSION_INFO";
    private ImageView parkmoaImg1,parkmoaImg2,parkmoaImg3,parkmoaImg4;
    private TextView parkmoaTitle1,parkmoaTitle2,parkmoaTitle3,parkmoaTitle4;
    PendingIntent intent;
    public static final int NOTIFICATION_ID = 1;
    private Context mContext;
    String m_id;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        mContext = getApplicationContext();
        getHashKey(mContext);
        parkmoaImg1 = (ImageView)findViewById(R.id.parkmoaImg1);
        parkmoaImg2 = (ImageView)findViewById(R.id.parkmoaImg2);
        parkmoaImg3 = (ImageView)findViewById(R.id.parkmoaImg3);
        parkmoaImg4 = (ImageView)findViewById(R.id.parkmoaImg4);

        parkmoaImg1.setOnClickListener(listener);
        parkmoaImg2.setOnClickListener(listener);
        parkmoaImg3.setOnClickListener(listener);
        parkmoaImg4.setOnClickListener(listener);



        viewFlipper = (ViewFlipper) findViewById(R.id.vf);

        viewFlipper.setAutoStart(true);
        viewFlipper.setFlipInterval(2000);
        viewFlipper.startFlipping();

        ImageButton button1 = (ImageButton) findViewById(R.id.searchBtn);
        ImageButton button2 = (ImageButton) findViewById(R.id.mapBtn);
        Button button3 = (Button) findViewById(R.id.btn_login);
        Button button9 = (Button) findViewById(R.id.btn_logout);

        ImageButton button4 = (ImageButton) findViewById(R.id.myPageBtn);

        SharedPreferences sf = getSharedPreferences(sessionKey, 0);
        String sid = sf.getString("USER_ID", "");
        String spw = sf.getString("USER_PW", "");

        if(sid.equals("")|| sid==null){
            //Toast.makeText(this,"로그인정보 없음", Toast.LENGTH_SHORT).show();
            button3.setVisibility(View.VISIBLE);
            button9.setVisibility(View.INVISIBLE);

            /*Intent intent = new Intent(this, LoginActivity.class);
            startActivity(intent);
            overridePendingTransition(R.anim.slide_in_right, R.anim.hold);
            finish();*/
        }else{
            //Toast.makeText(this, "로그인정보있음:"+sid,Toast.LENGTH_SHORT).show();
            button3.setVisibility(View.INVISIBLE);
            Log.i(TAG,"로그인아이디:"+sid+",로그인패스워드:"+spw);
        }


        button1.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(view.getContext(), SearchActivity.class);
                //intent.putExtra("m_id",sid);
                startActivity(intent);
                overridePendingTransition(R.anim.slide_in_right, R.anim.hold);
            }
        });
        button2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(view.getContext(), LocationActivity.class);
                //intent.putExtra("m_id",sid);
                startActivity(intent);
                overridePendingTransition(R.anim.slide_in_right, R.anim.hold);
            }
        });
        button3.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                SharedPreferences sf = getSharedPreferences(sessionKey, 0);
                String sid = sf.getString("USER_ID", "");

                if(sid.equals("")|| sid==null) {

                    Intent intent = new Intent(view.getContext(),
                            LoginActivity.class);
                    startActivity(intent);
                }
                else{
                    AlertDialog.Builder alert = new AlertDialog.Builder(MainActivity.this);
                    alert.setTitle("로그인 중");
                    alert.setPositiveButton("확인", new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialog, int which) {
                            dialog.dismiss();     //닫기
                        }
                    });
                    alert.setMessage("이미 계정이 접속중에 있습니다. 로그아웃 후 타 계정으로 로그인 해주세요.");
                    alert.show();
                }

            }
        });
        button4.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                SharedPreferences sf = getSharedPreferences(sessionKey, 0);
                String sid = sf.getString("USER_ID", "");
                String spw = sf.getString("USER_PW", "");

                if(sid.equals("")|| sid==null){
                    AlertDialog.Builder alert = new AlertDialog.Builder(MainActivity.this);
                    alert.setTitle("마이페이지");
                    alert.setPositiveButton("확인", new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialog, int which) {
                            dialog.dismiss();     //닫기
                            Intent intent = new Intent(getApplicationContext(),LoginActivity.class);
                            startActivity(intent);
                        }
                    });
                    alert.setMessage("로그인 후 이용 바랍니다.");
                    alert.show();
                        /*Intent intent = new Intent(this, LoginActivity.class);
                        startActivity(intent);
                        overridePendingTransition(R.anim.slide_in_right, R.anim.hold);
                        finish();*/
                }
                else{
                    Intent intent = new Intent(view.getContext(),MyPageActivity.class);
                    startActivity(intent);
                    overridePendingTransition(R.anim.slide_in_right, R.anim.hold);
                }
            }
        });

    }
    View.OnClickListener listener = new View.OnClickListener() {
        @Override
        public void onClick(View view) {
            if(view.getId() == R.id.parkmoaImg1){
                Intent intent1 = new Intent(getApplicationContext(),SubActivity.class);
                intent1.putExtra("tp_category","park");
                startActivity(intent1);
            }
            if(view.getId() == R.id.parkmoaImg2){
                Intent intent2 = new Intent(getApplicationContext(),SubActivity.class);
                intent2.putExtra("tp_category","water");
                startActivity(intent2);
            }
            if(view.getId() == R.id.parkmoaImg3){
                Intent intent3 = new Intent(getApplicationContext(),SubActivity.class);
                intent3.putExtra("tp_category","forest");
                startActivity(intent3);
            }
            if(view.getId() == R.id.parkmoaImg4){
                Intent intent4 = new Intent(getApplicationContext(),SubActivity.class);
                intent4.putExtra("tp_category","zoo");
                startActivity(intent4);
            }

        }
    };
    @Nullable

    public static String getHashKey(Context context) {

        final String TAG = "KeyHash";
        String keyHash = null;

        try {
            PackageInfo info =
                    context.getPackageManager().getPackageInfo(context.getPackageName(), PackageManager.GET_SIGNATURES);

            for (Signature signature : info.signatures) {

                MessageDigest md;
                md = MessageDigest.getInstance("SHA");
                md.update(signature.toByteArray());
                keyHash = new String(Base64.encode(md.digest(), 0));
                Log.d(TAG, keyHash);

            }

        } catch (Exception e) {

            Log.e("name not found", e.toString());

        }



        if (keyHash != null) {

            return keyHash;

        } else {

            return null;

        }

    }
    public void onBtnLogoutClicked(View v){

        SharedPreferences sf = getSharedPreferences(sessionKey, 0);
        SharedPreferences.Editor editor = sf.edit();
        editor.putString("USER_ID", "");
        editor.putString("USER_PW", "");
        editor.commit();

        intent = PendingIntent.getActivity(MainActivity.this, 0,
                new Intent(getApplicationContext(), LoginActivity.class), PendingIntent.FLAG_UPDATE_CURRENT);
        //알림 클릭시 LoginActivity로 이동되도록 설정
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
            builder = new Notification.Builder(MainActivity.this,"kosmo_id");
        }
        else{
            //Android7.0 api25이하일때 채널생성 필요없음.
            builder = new Notification.Builder(MainActivity.this);
        }
        //알림바에 표시되는 아이콘
        builder.setSmallIcon(R.drawable.android);
        //사용자가 알림바를 클릭할때 실행할 인텐트 지정.
        builder.setContentIntent(intent);
        //알림바에 표시되는 아이콘
        builder.setLargeIcon(BitmapFactory.decodeResource(getResources(),R.drawable.android));
        //알림제목
        builder.setContentTitle("로그아웃");
        //알림 내용
        builder.setContentText("파크모아에서 로그아웃 하셨습니다.");
                /*
                알림의 서브텍스트 (API16[android4.1 젤리빈] 이상에서만 표시됨.
                 */
        builder.setSubText("안녕히 가십시오");
                /*
                알림방법
                    DEFAULT_SOUND: 알림 소리가 난다. (단말에 설정된 알림사운드)
                    DEFAULT_VIBRATE : 진동으로 알려준다.
                 */
        builder.setDefaults(Notification.DEFAULT_SOUND);

        builder.setAutoCancel(true);

        //NotificationManager notificationManager = (NotificationManager)getSystemService((NOTIFICATION_SERVICE));
        //알림바에 알림을 표시한다.
        notificationManager.notify(NOTIFICATION_ID,builder.build());

        Intent intent = new Intent(this, LoginActivity.class);
        startActivity(intent);
        overridePendingTransition(R.anim.slide_in_right,R.anim.hold);
        finish();
    }


}