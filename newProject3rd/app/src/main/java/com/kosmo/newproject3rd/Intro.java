package com.kosmo.newproject3rd;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;

import androidx.appcompat.app.AppCompatActivity;

public class Intro extends AppCompatActivity {

    Handler handler = new Handler();
    Runnable r = new Runnable() {
        @Override
        public void run() {
            //메인액티비티 인플레이션
            Intent intent = new Intent(getApplicationContext(),
                    MainActivity.class);
            startActivity(intent);

            //인트로와 메인사이의 애니메이션 효과(팀별로 활용)
            overridePendingTransition(R.anim.slide_in_left, R.anim.hold);
            //인트로 액티비티종료
            finish();
        }
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_intro);
    }

    //수명주기 메소드 오버라이딩
    @Override
    protected void onResume() {
        super.onResume();
        //화면에 들어오면 2초후 Runnable 객체 실행함
        handler.postDelayed(r,2000);
    }

    @Override
    protected void onPause() {
        super.onPause();
        //화면을 벗어나면 handler에 예약해놓은 작업을 취소함
        handler.removeCallbacks(r);
    }
}
