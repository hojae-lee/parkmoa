package com.kosmo.newproject3rd;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.media.Image;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class SubActivity extends AppCompatActivity {

    ArrayList<String> itemNum = new ArrayList<String>();
    ArrayList<String> itemTitle = new ArrayList<String>();
    ArrayList<String> itemAddress = new ArrayList<String>();
    ArrayList<String> itemPostDate = new ArrayList<String>();
    ArrayList<String> itemImage = new ArrayList<String>();
    ArrayList<String> itemVisitcount = new ArrayList<String>();
    ArrayList<String> requestURLArr = new ArrayList<String>();//이미지 경로를 저장한 컬렉션
    Bitmap bitmap;
    private final int SCALE = 2;
    ListView listView;
    String serverUrl="";
    public static final String TAG = "iKosmo";

    ProgressDialog dialog;//대화상자


    //JSON으로 가져온 게시판 레코드 저장용(DTO객체대신)
    Map<String, String> mapDto = new HashMap<>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_sub);
        serverUrl = getString(R.string.serverUrl);
        //위젯가져오기
        //ProgressDialog객체생성
        dialog = new ProgressDialog(this);
        dialog.setProgressStyle(ProgressDialog.STYLE_SPINNER);
        dialog.setIcon(android.R.drawable.ic_dialog_alert);
        dialog.setTitle("서버 데이터 수신");
        dialog.setMessage("서버로부터 데이터 수신중입니다.");

        //Toast.makeText(getApplicationContext(),"tp_category", Toast.LENGTH_SHORT).show();

        Intent intent = getIntent();
        String tp_category = intent.getStringExtra("tp_category");
        new AsyncHttpRequest5().execute(
                serverUrl+"/project3rd/parkmoa/androidTplist.do"
                ,"tp_category="+tp_category
        );

    }

    class AsyncHttpRequest5 extends AsyncTask<String,Void,String>{
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
                Log.i(TAG,"리스트찍히는곳");
                Log.i(TAG,jsonString.toString());
                JSONObject jsonObject = new JSONObject(jsonString.toString());
                JSONArray boardArray = (JSONArray)jsonObject.get("Tpmap");

                for(int i=0; i< boardArray.length();i++){

                    JSONObject boardRecord = boardArray.getJSONObject(i);

                    itemImage.add(boardRecord.getString("tp_attach"));//파일이름
                    itemNum.add(boardRecord.getString("tp_idx"));
                    itemVisitcount.add(boardRecord.getString("tp_visitcount"));
                    itemAddress.add(boardRecord.getString("tp_addr1"));
                    itemTitle.add(boardRecord.getString("tp_name"));
                    itemPostDate.add(boardRecord.getString("tp_regidate"));

                }

                String requestURL ="";
                for(int i=0;i<itemImage.size();i++) {
                    requestURL = "http://192.168.219.157:8080/project3rd/resources/upload/"+itemImage.get(i);

                    Log.i(TAG,"requestURL"+requestURL);

                    requestURLArr.add(requestURL);

                    mapDto.put("requestURL",requestURL);

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

            class CustomList extends ArrayAdapter<String> {

                private final Activity context;

                public CustomList(Activity context){
                    super(context, R.layout.board_item, itemNum);
                    this.context = context;
                }

                @NonNull
                @Override
                public View getView(final int position, @Nullable View convertView, @NonNull ViewGroup parent) {

                    LayoutInflater inflater = context.getLayoutInflater();
                    View rowView = inflater.inflate(R.layout.board_item,null,true);

                    //위젯가져오기
                    final ImageView imageViewTV = (ImageView)rowView.findViewById(R.id.itemImage);
                    TextView itemTitleTV = (TextView)rowView.findViewById(R.id.itemTitle);
                    TextView itemVisitcountTV = (TextView)rowView.findViewById(R.id.itemVisitcount);
                    TextView itemaddrTV = (TextView)rowView.findViewById(R.id.itemAddress);
                    //뷰에 내용 삽입하기안드로이드 이미지를 리스트뷰에 출력
                    itemTitleTV.setText(itemTitle.get(position));
                    itemVisitcountTV.setText(itemVisitcount.get(position));
                    itemaddrTV.setText(itemAddress.get(position));

                    Thread mThread = new Thread(){
                        @Override
                        public void run() {
                            try {
                                URL url = new URL(requestURLArr.get(position));
                                HttpURLConnection connection = (HttpURLConnection) url.openConnection();
                                connection.setDoInput(true);
                                connection.connect();

                                InputStream is = connection.getInputStream();
                                bitmap = BitmapFactory.decodeStream(is);
                                //bitmap = Bitmap.createScaledBitmap(bitmap,bitmap.getWidth()*SCALE,bitmap.getHeight()*SCALE,true);

                                imageViewTV.setImageBitmap(bitmap);

                            }
                            catch (MalformedURLException e) {}
                            catch (IOException e) {}

                        }
                    };
                    mThread.start();
                    try {mThread.join();}
                    catch (InterruptedException e){}

                    return rowView;
                }
            }//CustomList

            //커스텀뷰
            CustomList customList = new CustomList(SubActivity.this);
            listView = (ListView)findViewById(R.id.mainList);
            listView.setAdapter(customList);
            listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
                @Override
                public void onItemClick(AdapterView<?> parent, View view, int position, long id) {

                    //상세보기 액티비티 띄우기
                    Intent intent = new Intent(getApplicationContext(), BoardViewActivitys.class);
                    intent.putExtra("tp_idx", itemNum.get(position));
                    startActivity(intent);

                }
            });


        }
    }



}