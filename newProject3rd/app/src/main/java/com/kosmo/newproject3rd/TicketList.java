package com.kosmo.newproject3rd;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import android.app.Activity;
import android.app.DatePickerDialog;
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
import android.widget.DatePicker;

import android.widget.EditText;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import org.json.JSONArray;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

public class TicketList extends AppCompatActivity {

    ArrayList<String> itemNum = new ArrayList<String>();
    ArrayList<String> itemName = new ArrayList<String>();
    ArrayList<String> itemPrice = new ArrayList<String>();
    ArrayList<String> priceList = new ArrayList<String>();
    ArrayList<String> cntList = new ArrayList<String>();
    Button btn_payment;
    String sessionKey = "SESSION_INFO";//로그인 아이디 저장용
    private TextView textView_date;
    private DatePickerDialog.OnDateSetListener callbackMethod;
    ListView listView;

    public static final String TAG = "iKosmo";
    String serverUrl, tp_name, date = "";
    ProgressDialog dialog;//대화상자

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_ticket_list);

        serverUrl = getString(R.string.serverUrl);
        Log.i(TAG, "서버URL="+serverUrl);

        //ProgressDialog객체생성
        dialog = new ProgressDialog(this);
        dialog.setProgressStyle(ProgressDialog.STYLE_SPINNER);
        dialog.setIcon(android.R.drawable.ic_dialog_alert);
        dialog.setTitle("서버 데이터 수신");
        dialog.setMessage("서버로부터 데이터 수신중입니다.");

        textView_date = (TextView)findViewById(R.id.btn_Date);

        callbackMethod = new DatePickerDialog.OnDateSetListener() {
            @Override
            public void onDateSet(DatePicker datePicker, int i, int i1, int i2) {
                int month = i1+1;

                date = i+"-"+month+"-"+i2;
                String dateType = "yyyy-MM-dd";
                String day="";
                try {
                    day = getDateDay(date, dateType);
                }catch (Exception e){
                    e.printStackTrace();
                }
                textView_date.setText(i + "년 " + month + "월 " + i2 + "일 ("+day+")");
            }
        };

        Intent intent = getIntent();
        final String tp_idx = intent.getStringExtra("tp_idx");
        tp_name = intent.getStringExtra("tp_name");

        SharedPreferences sf = getSharedPreferences(sessionKey,0);
        String sid = sf.getString("USER_ID","");
        new AsyncHttpRequest().execute(
                serverUrl+"/project3rd/parkmoa/ticketList.do"
                ,"tp_idx="+tp_idx

        );

        btn_payment = (Button)findViewById(R.id.btn_payment);

        btn_payment.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                //주차예약 및 결제창 띄우기
                Intent intent = new Intent(getApplicationContext(), Payment.class);
                String t_name = "";
                for(int i=0; i<cntList.size(); i++){
                    if(t_name==""){
                        if(!cntList.get(i).equals("0")){
                            t_name += itemName.get(i) + "*" + cntList.get(i);
                        }
                    }else{
                        if(!cntList.get(i).equals("0")){
                            t_name += ", "+itemName.get(i) + "*" + cntList.get(i);
                        }
                    }
                }

                int sum = 0;
                for(int i=0; i<priceList.size();i++){
                    sum += Integer.parseInt(priceList.get(i)) * Integer.parseInt(cntList.get(i));
                }

                Log.i(TAG,Integer.toString(sum));
                intent.putExtra("date", date);
                intent.putExtra("tp_idx", tp_idx);
                intent.putExtra("sum", Integer.toString(sum));
                intent.putExtra("t_name", t_name);
                intent.putExtra("tp_name", tp_name);
                startActivity(intent);
            }
        });
    }
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
                Log.i(TAG,"티켓리스트찍히는곳");
                Log.i(TAG,jsonString.toString());
                JSONObject jsonObject = new JSONObject(jsonString.toString());
                JSONArray boardArray = (JSONArray)jsonObject.get("ticketList");

                for(int i=0; i< boardArray.length();i++){

                    JSONObject boardRecord = boardArray.getJSONObject(i);

                    itemNum.add(boardRecord.getString("t_idx"));
                    itemName.add(boardRecord.getString("t_name"));
                    itemPrice.add(boardRecord.getString("t_price"));

                    priceList.add(boardRecord.getString("t_price"));
                    cntList.add("0");
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

            //커스텀뷰
            CustomList customList = new CustomList(TicketList.this);
            listView = (ListView)findViewById(R.id.ticketList);
            listView.setAdapter(customList);

        }
    }

    public class CustomList extends ArrayAdapter<String> {

        private final Activity context;

        public CustomList(Activity context){
            super(context, R.layout.ticketview, itemNum);
            this.context = context;
        }

        @Override
        public String getItem(int position) {
            return super.getItem(position);
        }

        @NonNull
        @Override
        public View getView(final int position, @Nullable View convertView, @NonNull ViewGroup parent) {

            LayoutInflater inflater = context.getLayoutInflater();
            final View rowView = inflater.inflate(R.layout.ticketview,null,true);

            //위젯가져오기
            TextView itemNameTV = (TextView)rowView.findViewById(R.id.itemName);
            TextView itemPriceTV = (TextView)rowView.findViewById(R.id.itemPrice);
            final TextView itemCntET = (TextView)rowView.findViewById(R.id.t_count);
            final Button btn_increase = (Button)rowView.findViewById(R.id.btn_increase);
            Button btn_decrease = (Button)rowView.findViewById(R.id.btn_decrease);
            final ListView listView = (ListView) findViewById(R.id.ticketList);
            final TextView totalPrice = (TextView)findViewById(R.id.totalPrice);

            btn_increase.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    //수량변경
                    int cnt = Integer.parseInt(itemCntET.getText().toString());
                    itemCntET.setText(String.valueOf(++cnt));

                    //총 결제금액 변경을 위한 변수선언
                    int index = btn_increase.getId();
                    String value = itemCntET.getText().toString();

                    //수량 ArrayList의 value값 변경
                    cntList.set(index, Integer.toString(cnt));

                    //합산
                    int sum = 0;
                    for(int i=0; i<priceList.size();i++){
                        sum += Integer.parseInt(priceList.get(i)) * Integer.parseInt(cntList.get(i));
                    }
                    //합산결과 입력
                    totalPrice.setText(moneyFormatToWon(Integer.toString(sum)));
                }
            });
            btn_decrease.setTag(position);
            btn_decrease.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    int cnt = Integer.parseInt(itemCntET.getText().toString());
                    cnt--;
                    if(cnt<0){
                        cnt = 0;
                    }
                    itemCntET.setText(String.valueOf(cnt));

                    int index = btn_increase.getId();
                    String value = itemCntET.getText().toString();

                    cntList.set(index, Integer.toString(cnt));
                    int sum = 0;
                    for(int i=0; i<priceList.size();i++){
                        sum += Integer.parseInt(priceList.get(i)) * Integer.parseInt(cntList.get(i));
                    }
                    totalPrice.setText(moneyFormatToWon(Integer.toString(sum)));
                }
            });
            itemCntET.setTag(position);

            //뷰에 내용 삽입하기
            itemNameTV.setText(itemName.get(position));
            String commaitemPrice = moneyFormatToWon(itemPrice.get(position));
            itemPriceTV.setText(commaitemPrice);

            itemPriceTV.setId(position);
            btn_increase.setId(position);

            return rowView;
        }

    }//CustomList

    public void OnClickHander(View view){

        Calendar c = Calendar.getInstance();
        Calendar minDate = Calendar.getInstance();
        int mYear = c.get(Calendar.YEAR);
        int mMonth = c.get(Calendar.MONTH);
        int mDay = c.get(Calendar.DAY_OF_MONTH);

        DatePickerDialog dialog = new DatePickerDialog(this, callbackMethod, mYear, mMonth,mDay);

        minDate.set(mYear,mMonth,mDay);
        dialog.getDatePicker().setMinDate(minDate.getTime().getTime());
        dialog.show();
    }

    public static String moneyFormatToWon(String inputMoney) {

        int number = Integer.parseInt(inputMoney);
        NumberFormat nf = NumberFormat.getInstance(Locale.KOREA);

        return nf.format(number);
    }
    /**
     * 특정 날짜에 대하여 요일을 구함(일 ~ 토)
     * @param date
     * @param dateType
     * @return
     * @throws Exception
     */
    public static String getDateDay(String date, String dateType) throws Exception {

        String day = "";

        SimpleDateFormat dateFormat = new SimpleDateFormat(dateType);
        Date nDate = dateFormat.parse(date);

        Calendar cal = Calendar.getInstance();
        cal.setTime(nDate);

        int dayNum = cal.get(Calendar.DAY_OF_WEEK);

        switch (dayNum) {
            case 1:
                day = "일";
                break;
            case 2:
                day = "월";
                break;
            case 3:
                day = "화";
                break;
            case 4:
                day = "수";
                break;
            case 5:
                day = "목";
                break;
            case 6:
                day = "금";
                break;
            case 7:
                day = "토";
                break;

        }
        return day;
    }
}