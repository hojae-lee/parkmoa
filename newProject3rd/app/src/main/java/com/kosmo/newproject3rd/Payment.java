package com.kosmo.newproject3rd;

import androidx.appcompat.app.AppCompatActivity;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Color;
import android.os.AsyncTask;
import android.os.Bundle;
import android.text.Editable;
import android.text.Selection;
import android.text.TextWatcher;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;

import android.widget.TextView;
import android.widget.Toast;

import com.kakao.usermgmt.LoginButton;

import org.json.JSONArray;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Locale;

public class Payment extends AppCompatActivity {

    ProgressDialog dialog;
    SharedPreferences.Editor editor;
    public static TextView totalPrice;
    public static String m_membership, sum;
    String sessionKey = "SESSION_INFO";//로그인 아이디 저장용
    String TAG = "iKosmo";
    LinearLayout container;
    public String serverUrl, tp_idx, date, jsontp_idx, jsonr_useregi, jsonp_num, m_mobile
            , m_email, m_name, m_id, t_name, tp_name;
    JSONArray p_content;
    EditText use_membership;

    int p_repeatNum, parkingIndex, after_membership;
    int selectedNum=0;

    ArrayList<String> p_numList = new ArrayList<>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_payment);

        serverUrl = getString(R.string.serverUrl);

        //ProgressDialog객체생성
        dialog = new ProgressDialog(this);
        dialog.setProgressStyle(ProgressDialog.STYLE_SPINNER);
        dialog.setIcon(android.R.drawable.ic_dialog_alert);
        dialog.setTitle("서버 데이터 수신");
        dialog.setMessage("서버로부터 데이터 수신중입니다.");

        Intent intent = getIntent();
        sum = intent.getStringExtra("sum");
        tp_idx = intent.getStringExtra("tp_idx");
        date = intent.getStringExtra("date");
        t_name = intent.getStringExtra("t_name");
        tp_name = intent.getStringExtra("tp_name");

        totalPrice = findViewById(R.id.totalPrice);
        totalPrice.setText(moneyFormatToWon(sum));
        SharedPreferences preferences = getSharedPreferences("USER_ID",Activity.MODE_PRIVATE);
        String sid = preferences.getString("USER_ID", "");
        editor = preferences.edit();
        Log.i(TAG,"아이디"+preferences.getString("USER_ID",""));
        //주차장 레이아웃 띄우기
        new Payment.AsyncHttpRequest().execute(
                serverUrl+"/project3rd/parkmoa/androidPayment.do"
                ,"tp_idx="+tp_idx,"m_id="+sid

        );

        Button Action = findViewById(R.id.paymentAction);
        Action.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                SharedPreferences pref = getSharedPreferences("USER_ID",
                        Activity.MODE_PRIVATE);
                editor = pref.edit();

                Intent actionIntent = new Intent(getApplicationContext(),importActivity.class);

                after_membership = Integer.parseInt(m_membership);
                use_membership = (EditText) findViewById(R.id.use_membership);
                after_membership = Integer.parseInt(m_membership)
                        -Integer.parseInt(use_membership.getText().toString().replace(",",""))
                        +Integer.parseInt(sum)/100;
                Log.i(TAG,"m_id="+m_id);
                actionIntent.putExtra("m_id", m_id);
                actionIntent.putExtra("tp_idx", tp_idx);
                actionIntent.putExtra("t_name", t_name);
                actionIntent.putExtra("TotalPrice", sum);
                actionIntent.putExtra("r_useregi", date);
                actionIntent.putExtra("m_mobile", m_mobile);
                actionIntent.putExtra("m_email", m_email);
                actionIntent.putExtra("tp_name", tp_name);
                actionIntent.putExtra("p_num", Integer.toString(selectedNum));
                actionIntent.putExtra("after_membership", Integer.toString(after_membership));

                Log.i(TAG, Integer.toString(after_membership));
                startActivity(actionIntent);

            }
        });
    }



    class AsyncHttpRequest extends AsyncTask<String,Void,String>{
        @Override
        protected void onPreExecute() {
            super.onPreExecute();
            if(!dialog.isShowing()){
                dialog.show();
            }
        }
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
            catch (Exception e) {
                e.printStackTrace();
            }

            //JSON Array 파싱
            try {
                JSONObject jsonObject = new JSONObject(jsonString.toString());
                JSONObject parkingInfo = new JSONObject(jsonObject.getString("parkingInfoDTO"));

                JSONObject TPdto = new JSONObject(jsonObject.getString("TPdto"));
                tp_name = TPdto.getString("tp_name");
                p_repeatNum = Integer.parseInt(parkingInfo.getString("p_repeatNum"));
                p_content = parkingInfo.getJSONArray("p_content");

                JSONObject dto = new JSONObject(jsonObject.getString("dto"));
                Log.i(TAG, dto.toString());

                m_membership = dto.getString("m_membership");
                m_mobile = dto.getString("m_mobile");
                m_email = dto.getString("m_email");
                m_name = dto.getString("m_name");
                m_id = dto.getString("m_id");

                JSONArray paymentList = new JSONArray(jsonObject.getString("paymentList"));

                for(int i=0; i<paymentList.length(); i++){

                    JSONObject payment = new JSONObject(paymentList.getString(i));
                    jsontp_idx = payment.getString("tp_idx");
                    jsonr_useregi = payment.getString("r_useregi");
                    jsonp_num = payment.getString("p_num");

                    if(tp_idx.equals(jsontp_idx)
                            && date.equals(jsonr_useregi.substring(0,10))
                            && !jsonp_num.equals("0")){
                        p_numList.add(jsonp_num);
                    }
                }
            }
            catch (Exception e){
                e.printStackTrace();
            }
            return jsonString.toString();
        }
        @Override
        protected void onPostExecute(String s) {
            super.onPostExecute(s);
            dialog.dismiss();

            container = findViewById(R.id.container);
            LinearLayout row = new LinearLayout(Payment.this);
            Button white = findViewById(R.id.white);
            white.setBackgroundResource(R.drawable.white);
            int rowNum = 0;
            parkingIndex = 0;

            for(int i=0; i<p_content.length(); i++){
                if(i%p_repeatNum == 0){
                    row = new LinearLayout(Payment.this);
                    row.setLayoutParams(new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT));
                    row.setOrientation(LinearLayout.HORIZONTAL);
                    container.addView(row);
                    rowNum++;
                }
                Button button = new Button(Payment.this);
                button.setLayoutParams(new LinearLayout.LayoutParams(0, 120,1f));
                button.setTextSize(10);
                button.setPadding(0,0,0,0);
                try {
                    if(p_content.get(i).toString().equals("0")){
                        button.setStateListAnimator(null);
                        button.setText(" ");
                        button.setEnabled(false);
                        button.setBackgroundResource(R.drawable.pass);
                    }else{
                        button.setText(String.valueOf(++parkingIndex));
                        button.setId(parkingIndex);
                        button.setBackgroundResource(R.drawable.white);
                        //예약된자리
                        for(int k=0; k<p_numList.size();k++){
                            if(Integer.toString(parkingIndex).equals(p_numList.get(k))){
                                button.setTextColor(Color.rgb(255,255,255));
                                button.setBackgroundResource(R.drawable.red);
                            }
                        }
                        button.setOnClickListener(listener);
                    }
                }catch (Exception e){
                    e.printStackTrace();
                }
                row.addView(button);
            }
            TextView m_membershipTV = findViewById(R.id.m_membership);
            m_membershipTV.setText(moneyFormatToWon(m_membership));

            use_membership = findViewById(R.id.use_membership);
            TextWatcher watcher = new TextWatcher_MoneyToComma(use_membership);
            use_membership.addTextChangedListener(watcher);

            Button useAll = findViewById(R.id.useAll);
            useAll.setOnClickListener(membership);
        }
    }

    public View.OnClickListener membership = new View.OnClickListener() {
        @Override
        public void onClick(View view) {
            use_membership.setText(moneyFormatToWon(m_membership));
            int newSum = Integer.parseInt(sum) - Integer.parseInt(m_membership);

            totalPrice.setText(moneyFormatToWon(Integer.toString(newSum)));
        }
    };

    public View.OnClickListener listener = new View.OnClickListener() {
        @Override
        public void onClick(View view) {
            int index = view.getId();

            for(int i=0; i<p_numList.size(); i++){
                if(p_numList.get(i).equals(Integer.toString(index))){
                    Toast.makeText(getApplicationContext(),"이미 예약된 자리입니다.", Toast.LENGTH_SHORT).show();
                    return;
                }
            }
            if(index == selectedNum){
                for (int i=1;i<=parkingIndex; i++){
                    Button anotherButton = findViewById(i);
                    anotherButton.setEnabled(true);
                }
                view.setBackgroundResource(R.drawable.white);
                Toast.makeText(getApplicationContext(),index+"번 선택해제하셨습니다.", Toast.LENGTH_SHORT).show();
                selectedNum = 0;
            }else{
                for (int i=1;i<=parkingIndex; i++){
                    Button anotherButton = findViewById(i);
                    anotherButton.setEnabled(false);
                    view.setEnabled(true);
                }
                selectedNum = index;
                view.setBackgroundResource(R.drawable.blue);
                Toast.makeText(getApplicationContext(),index+"번 선택하셨습니다.", Toast.LENGTH_SHORT).show();
            }
        }
    };

    public static String moneyFormatToWon(String inputMoney) {

        int number = Integer.parseInt(inputMoney);
        NumberFormat nf = NumberFormat.getInstance(Locale.KOREA);

        return nf.format(number);
    }
}

class TextWatcher_MoneyToComma extends Payment implements TextWatcher {
    @SuppressWarnings("unused")
    private EditText mEditText;
    String strAmount = ""; // 임시 저장값 (콤마)

    public TextWatcher_MoneyToComma(EditText e) {
        mEditText = e;

    }

    @Override
    public void afterTextChanged(Editable s) {
        // TODO Auto-generated method stub

    }

    @Override
    public void beforeTextChanged(CharSequence s, int start, int count, int after) {
        // TODO Auto-generated method stub


    }

    @Override
    public void onTextChanged(CharSequence s, int start, int before, int count) {
        if(s.toString().equals("") || s == null){
            strAmount="0";
            mEditText.setText(strAmount);
            Editable e = mEditText.getText();
            Selection.setSelection(e, strAmount.length());
            totalPrice.setText(setStrDataToComma(sum));
            return;
        }
        if (!s.toString().equals(strAmount)) {

            if (Integer.parseInt(s.toString().replace(",",""))
                    >Integer.parseInt(Payment.m_membership)){
                strAmount = setStrDataToComma(Payment.m_membership);
            }else{
                strAmount = setStrDataToComma(s.toString().replace(",", ""));
            }
            mEditText.setText(strAmount);
            Editable e = mEditText.getText();
            Selection.setSelection(e, strAmount.length());

            int total = Integer.parseInt(sum)
                    -Integer.parseInt(strAmount.replace(",",""));

            totalPrice.setText(setStrDataToComma(Integer.toString(total)));
        }
    }

    protected String setStrDataToComma(String str) {
        if (str.length() == 0)
            return "";
        long value = Long.parseLong(str);
        DecimalFormat format = new DecimalFormat("###,###");
        return format.format(value);
    }
}


