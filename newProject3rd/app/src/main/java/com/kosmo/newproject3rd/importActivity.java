package com.kosmo.newproject3rd;

import androidx.appcompat.app.AppCompatActivity;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.widget.Button;

import com.kosmo.newproject3rd.KakaoWebViewClient;

import java.net.URL;

public class importActivity extends AppCompatActivity {

    private WebView mainWebView;
    private final String APP_SCHEME = "iamportkakao://";
    private final String TAG="kosmo";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_import);

        mainWebView = (WebView) findViewById(R.id.mainWebView);
        mainWebView.getSettings().setDefaultTextEncodingName("UTF-8");
        mainWebView.setWebViewClient(new KakaoWebViewClient(this));
        WebSettings settings = mainWebView.getSettings();
        settings.setJavaScriptEnabled(true);

        final Intent intent = getIntent();
        String tp_name = intent.getExtras().getString("tp_name");
        String m_id = intent.getExtras().getString("m_id");
        String t_name = intent.getExtras().getString("t_name");
        String TotalPrice = intent.getExtras().getString("TotalPrice");
        String r_useregi = intent.getExtras().getString("r_useregi");
        String m_membership = intent.getExtras().getString("after_membership");
        String p_num = intent.getExtras().getString("p_num");
        String m_mobile = intent.getExtras().getString("m_mobile");
        String m_email = intent.getExtras().getString("m_email");
        String tp_idx = intent.getExtras().getString("tp_idx");

        Log.i(TAG,"인텐트아이디:"+m_id);

        mainWebView.loadUrl("http://192.168.219.157:8080/project3rd/parkmoa/AndroidPaymentAction.do?m_id="+m_id+"&t_name="+t_name+"&TotalPrice="+TotalPrice+"&r_useregi="+r_useregi+"&m_membership="+m_membership+"&p_num="+p_num+"&m_mobile="+m_mobile+"&m_email="+m_email+"&tp_idx="+tp_idx+"&tp_name="+tp_name); //redirectURLm_mobile

        final Button home = (Button) findViewById(R.id.home);

        home.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent homeIntent = new Intent(getApplicationContext(), MainActivity.class);
                startActivity(homeIntent);
            }
        });

    }

    @Override
    public boolean shouldUpRecreateTask(Intent targetIntent) {
        return super.shouldUpRecreateTask(targetIntent);
    }

    @Override
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        setIntent(intent);
    }

    @Override
    protected void onResume() {
        super.onResume();

        Intent intent = getIntent();
        if ( intent != null ) {
            Uri intentData = intent.getData();

            if ( intentData != null ) {
                //카카오페이 인증 후 복귀했을 때 결제 후속조치
                Log.i(TAG,"여기들어오나요?");
                String url = intentData.toString();

                if ( url.startsWith(APP_SCHEME) ) {
                    String path = url.substring(APP_SCHEME.length());
                    if ( "process".equalsIgnoreCase(path) ) {
                        mainWebView.loadUrl("javascript:IMP.communicate({result:'process'})");
                    } else {
                        mainWebView.loadUrl("javascript:IMP.communicate({result:'cancel'})");
                    }
                }
            }
        }

    }


}
