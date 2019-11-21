package com.kosmo.newproject3rd;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

public class LocationActivity extends AppCompatActivity {

    Button button1;
    Button button2;
    Button button3;
    Button button4;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_location);

        button1 = (Button)findViewById(R.id.button1);
        button2 = (Button)findViewById(R.id.button2);
        button3 = (Button)findViewById(R.id.button3);
        button4 = (Button)findViewById(R.id.button4);

        button1.setOnClickListener(onClickListener);
        button2.setOnClickListener(onClickListener);
        button3.setOnClickListener(onClickListener);
        button4.setOnClickListener(onClickListener);
    }

    View.OnClickListener onClickListener = new View.OnClickListener(){
        @Override
        public void onClick(View view) {
            if(view.getId() == R.id.button1){
                Intent intent = new Intent(view.getContext(), Parkmap.class);
                startActivity(intent);
            }
            else if(view.getId() == R.id.button2){
                Intent intent = new Intent(view.getContext(), Watermap.class);
                startActivity(intent);
            }
            else if(view.getId() == R.id.button3){
                Intent intent = new Intent(view.getContext(), Zoomap.class);
                startActivity(intent);
            }
            else if(view.getId() == R.id.button4){
                Intent intent = new Intent(view.getContext(), TreeMap.class);
                startActivity(intent);
            }
        }
    };

}