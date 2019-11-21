package com.kosmo.newproject3rd;
import androidx.appcompat.app.AppCompatActivity;

import android.app.ProgressDialog;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import org.json.JSONArray;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

public class BoardViewActivitys extends AppCompatActivity {

        public static final String TAG = "iKosmo";
        String serverUrl="";
        ProgressDialog dialog;//대화상자
        ImageView imageView;
        Bitmap bitmap;
        TextView itemTitle, itemContent, itemAddress, itemVistcount;
        Map<String, String> mapDto = new HashMap<>();
        Button btn_buy;
        String tp_name;
        String sessionKey = "SESSION_INFO";
        @Override
        protected void onCreate(Bundle savedInstanceState) {
            super.onCreate(savedInstanceState);
            setContentView(R.layout.activity_board_view_activitys);

            //위젯가져오기
            itemTitle = findViewById(R.id.itemTitle);
            itemAddress = findViewById(R.id.itemAddress);
            itemContent = findViewById(R.id.itemContent);
            itemVistcount = findViewById(R.id.itemVisitcount);
            imageView = findViewById(R.id.itemImage);
            btn_buy = findViewById(R.id.btn_buy);

            serverUrl = getString(R.string.serverUrl);
            Log.i(TAG, "서버URL="+serverUrl);

            //ProgressDialog객체생성
            dialog = new ProgressDialog(this);
            dialog.setProgressStyle(ProgressDialog.STYLE_SPINNER);
            dialog.setIcon(android.R.drawable.ic_dialog_alert);
            dialog.setTitle("서버 데이터 수신");
            dialog.setMessage("서버로부터 데이터 수신중입니다.");

            Intent intent = getIntent();
            final String tp_idx = intent.getStringExtra("tp_idx");
            Toast.makeText(getApplicationContext(),
                    "게시판Num:"+tp_idx,
                    Toast.LENGTH_LONG).show();

            btn_buy.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {

                    //티켓보기 액티비티 띄우기
                    Intent intent = new Intent(getApplicationContext(), TicketList.class);
                    intent.putExtra("tp_idx", tp_idx);
                    startActivity(intent);
                }
            });


            new AsyncHttpRequest().execute(
                    "http://192.168.219.157:8080/project3rd/parkmoa/androidTplistView.do"
                    ,"tp_idx="+tp_idx
            );




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
                    //서버에서 가져온 데이터 출력
                    Log.i(TAG,"상세보기찍히는곳");
                    Log.i(TAG, jsonString.toString());
                    JSONObject jsonObject = new JSONObject(jsonString.toString());
                    JSONObject jsonObject1 = (JSONObject)jsonObject.get("Tpmap");
                    String tp_name = jsonObject1.get("tp_name").toString();
                    String tp_addr1 = jsonObject1.get("tp_addr1").toString();
                    String tp_visitcount = jsonObject1.get("tp_visitcount").toString();
                    String tp_content = jsonObject1.get("tp_content").toString();
                    String tp_attach = jsonObject1.get("tp_attach").toString();
                    //Map에 저장

                    mapDto.put("tp_name", tp_name);
                    mapDto.put("tp_addr1", tp_addr1);
                    mapDto.put("tp_visitcount",tp_visitcount);
                    mapDto.put("tp_content",tp_content);
                    mapDto.put("tp_attach",tp_attach);
                    //mapDto.put("content", boardRow.getString("content"));
                    //mapDto.put("id", boardRow.getString("id"));
                    //mapDto.put("postDate", boardRow.getString("postDate"));
                    //mapDto.put("visitcount", boardRow.getString("visitcount"));
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

                final String requestURL = "http://192.168.219.157:8080/project3rd/resources/upload/"+mapDto.get("tp_attach");
                Thread mThread = new Thread(){
                    @Override
                    public void run() {

                        try {
                            URL url = new URL(requestURL);
                            HttpURLConnection connection = (HttpURLConnection)url.openConnection();
                            connection.setDoInput(true);
                            connection.connect();

                            InputStream is = connection.getInputStream();
                            bitmap = BitmapFactory.decodeStream(is);
                        }
                        catch (MalformedURLException e){}
                        catch (IOException e){}
                    }
                };
                mThread.start();
                try {
                    mThread.join();

                }
                catch (InterruptedException e){}


                //텍스트뷰에 내용 삽입
                imageView.setImageBitmap(bitmap);
                itemTitle.setText(mapDto.get("tp_name"));
                itemContent.setText(mapDto.get("tp_content"));
                itemAddress.setText(mapDto.get("tp_addr1"));
                itemVistcount.setText(mapDto.get("tp_visitcount"));
            }
        }////AsyncHttpRequest class
}