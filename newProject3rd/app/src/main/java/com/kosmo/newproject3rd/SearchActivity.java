package com.kosmo.newproject3rd;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.ActivityNotFoundException;
import android.content.Intent;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.AsyncTask;
import android.os.Bundle;
import android.speech.RecognitionListener;
import android.speech.RecognizerIntent;
import android.speech.SpeechRecognizer;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.ListView;
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
import java.util.ArrayList;

public class SearchActivity extends AppCompatActivity implements RecognitionListener {

    public static final String TAG = "iKosmo";
    private static final int REQUEST_CODE = 1000;
    private EditText id;//아이디 입력상자
    private TextView textResult;//결과 출력용 텍스트 상자
    private ProgressDialog dialog;
    private int buttonResId;//버튼 구분용 변수
    String str="";
    String serverURL= "";
    String sessionKey = "SESSION_INFO";
    ListView listView;
    ArrayList<String> themeNum = new ArrayList<String>();
    ArrayList<String> themeName =new ArrayList<String>();
    ArrayList<String> themeContent = new ArrayList<String>();
    ArrayList<String> themeRegidate = new ArrayList<String>();
    ArrayList<String> themeImage = new ArrayList<String>();
    ArrayList<String> requestURLArr = new ArrayList<String>();
    Bitmap bitmap;
    private final int SCALE = 2;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_search);

        id = (EditText) findViewById(R.id.id);
        final ImageButton btnJson = (ImageButton) findViewById(R.id.btn_json);

        btnJson.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                buttonResId = view.getId();

                new AsyncHttpRequest().execute(
                        "http://192.168.219.157:8080/project3rd/parkmoa/androidList.do"
                        , "tp_name=" + id.getText().toString());
            }
        });

        //게시판 리스트를 JSON으로 가져오기
        //진핼대화창을 띄우기 위한 객체 생성
        dialog = new ProgressDialog(this);
        //프로그래스바 스타일 설정(원형)
        dialog.setProgressStyle(ProgressDialog.STYLE_SPINNER);
        //아이콘 설정
        dialog.setIcon(android.R.drawable.ic_dialog_alert);
        //제목설정
        dialog.setTitle("회원정보 리스트 가져오기");
        //메세지설정
        dialog.setMessage("서버로부터 응답을 기다리고 있습니다.");
        //back키 를 눌렀을때 취소되지 않도록 하는 설정(AlertDialog에도 있음)
        dialog.setCancelable(false);
    }

    public void onBtn1Clicked(View v){
        //음성 인식의 실행 (1)
        try {
            //음성인식의 실행1
            Intent intent = new Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH);
            intent.putExtra(RecognizerIntent.EXTRA_CALLING_PACKAGE,
                    getPackageName());
            intent.putExtra(RecognizerIntent.EXTRA_LANGUAGE,"ko-KR");
            intent.putExtra(RecognizerIntent.EXTRA_PROMPT,"음성 검색");
            intent.putExtra(RecognizerIntent.EXTRA_MAX_RESULTS,1);

            //인텐트를 통해 음성을 전달한 후 결과를 되돌려 받기 위해 호출
            startActivityForResult(intent, REQUEST_CODE);
        }
        catch (ActivityNotFoundException e){
            Log.d(TAG, "ActivityNotFoundException");
        }
    }

    @Override
    public void onReadyForSpeech(Bundle bundle) {

    }

    @Override
    public void onBeginningOfSpeech() {

    }

    @Override
    public void onRmsChanged(float v) {

    }

    @Override
    public void onBufferReceived(byte[] bytes) {

    }

    @Override
    public void onEndOfSpeech() {

    }

    @Override
    public void onError(int i) {

        String message;
        switch (i){
            case SpeechRecognizer
                    .ERROR_AUDIO:
                message = "오디오 에러";
                break;
            case SpeechRecognizer
                    .ERROR_CLIENT:
                message = "클라이언트 에러";
                break;
            case SpeechRecognizer
                    .ERROR_INSUFFICIENT_PERMISSIONS:
                message = "퍼미션없음";
                break;
            case SpeechRecognizer
                    .ERROR_NETWORK:
                message = "네트워크 에러";
                break;
            case SpeechRecognizer
                    .ERROR_NETWORK_TIMEOUT:
                message = "네트워크 타임아웃";
                break;
            case SpeechRecognizer
                    .ERROR_NO_MATCH:
                message = "찾을수 없음";
                break;
            case SpeechRecognizer
                    .ERROR_RECOGNIZER_BUSY:
                message = "Busy";
                break;
            case SpeechRecognizer
                    .ERROR_SERVER:
                message = "서버이상";
                break;
            case SpeechRecognizer
                    .ERROR_SPEECH_TIMEOUT:
                message = "시간초과";
                break;
            default:
                message = "알수없음";
                break;
        }
        Log.d(TAG, "SPEECH ERROR: "+ message);

    }

    @Override
    public void onResults(Bundle bundle) {
        ArrayList<String> matches = bundle.getStringArrayList(SpeechRecognizer.RESULTS_RECOGNITION);

        Log.d(TAG,"onResults:"+matches );

        //String str = "";
        for(int i=0; i<matches.size(); i++){
            str = str + matches.get(i)+ "\n";
            Log.d(TAG,"onResults text:" + matches.get(i));
        }
        id.setText(str);

    }

    @Override
    public void onPartialResults(Bundle bundle) {

    }

    @Override
    public void onEvent(int i, Bundle bundle) {

    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        switch (requestCode){
            case REQUEST_CODE : {
                if(resultCode == RESULT_OK && null != data);

                ArrayList<String> text = data.getStringArrayListExtra(RecognizerIntent.EXTRA_RESULTS);

                str = "";
                for(int i=0; i< text.size(); i++){
                    str = str+text.get(i)+ "\n";
                    Log.i(TAG, "onActivityResult text : "+ text.get(i));
                }
                id.setText(str);

                String[] rs = new String[text.size()];
                text.toArray(rs);

                id.setText(str);

                if(str != null){
                    new AsyncHttpRequest().execute(
                            "http://192.168.219.157:8080/project3rd/parkmoa/androidList.do"
                            , "tp_name=" + str.trim());
                    Log.d(TAG,"음성 str=" + str.trim());
                }
            }
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

            StringBuffer sBuffer = new StringBuffer();
            try {
                //접속할 주소(첫번째 파라미터 ) 를 통해 URL객체 생성 및 연결
                URL url = new URL(strings[0]);
                HttpURLConnection connection = (HttpURLConnection) url.openConnection();
                //Post방식으로 통신설정(디폴트는 Get방식)
                connection.setRequestMethod("POST");
                connection.setDoOutput(true);

                OutputStream out = connection.getOutputStream();
                out.write(strings[1].getBytes());
                out.flush();
                out.close();

                //서버에 요청이 전달되고 성공이라면 HTTP_OK로 확인
                if (connection.getResponseCode() == HttpURLConnection.HTTP_OK) {
                    Log.d(TAG,"HTTP_OK");
                    //서버로 부터 받는 응답 내용
                    BufferedReader reader =
                            new BufferedReader(new InputStreamReader(
                                    connection.getInputStream(), "UTF-8"));

                    String responseData;
                    //내용을 한줄씩 읽어서 StringBuffer 변수에 저장함
                    while ((responseData = reader.readLine()) != null) {
                        sBuffer.append(responseData + "\n\r");
                    }
                    reader.close();
                } else {
                    //서버와 연결 실패
                    Log.i("AsncTask Class", "HTTP_OK안됨");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            if (buttonResId == R.id.btn_json || str != null) {
                themeNum.clear();
                themeName.clear();
                themeRegidate.clear();
                themeContent.clear();
                try {
                    JSONArray jsonArray = new JSONArray(sBuffer.toString());
                    Log.d(TAG, jsonArray.toString());
                    sBuffer.setLength(0);
                    for (int i = 0; i < jsonArray.length(); i++) {
                        JSONObject jsonObject = jsonArray.getJSONObject(i);

                        themeImage.add(jsonObject.getString("tp_attach"));
                        themeNum.add(jsonObject.getString("tp_idx"));
                        themeName.add(jsonObject.getString("tp_name"));
                        themeRegidate.add(jsonObject.getString("tp_regidate"));
                        themeContent.add(jsonObject.getString("tp_content"));
                        Log.i("TAG", themeName+"//"+themeRegidate+"//"+themeContent+ "/"+themeNum);
                    }
                    String requestURL ="";
                    for(int i=0;i<themeImage.size();i++) {
                        requestURL = "http://192.168.219.157:8080/project3rd/resources/upload/"+themeImage.get(i);

                        Log.i(TAG,"requestURL"+requestURL);

                        requestURLArr.add(requestURL);
                    }
                }
                catch(Exception e){
                    e.printStackTrace();
                }
            }

            //실횅 완료된 데이터를 반환하면 onPostExecute()로 전달한다.
            return sBuffer.toString();
        }

        //doInBackground 메소드 정상종료시 호출되는 메소드
        @Override
        protected void onPostExecute(String s) {
            super.onPostExecute(s);

            dialog.dismiss();//대화창닫기

            //커스텀뷰
            CustomList customList = new CustomList(SearchActivity.this);
            listView = (ListView)findViewById(R.id.text_result);
            listView.setAdapter(customList);
            listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
                @Override
                public void onItemClick(AdapterView<?> parent, View view, int position, long id) {

                    //선택한 항목의 position값 출력
                   /* Toast.makeText(getBaseContext(),
                            "[position="+position+"=>]"+"Num:"+itemNum.get(position),
                            Toast.LENGTH_SHORT).show();*/

                    //상세보기 액티비티 띄우기
                    Intent intent = new Intent(getApplicationContext(), BoardViewActivitys.class);
                    intent.putExtra("tp_idx", themeNum.get(position));
                    startActivity(intent);
                    overridePendingTransition(R.anim.slide_in_right, R.anim.hold);
                }
            });
        }
    }////AsyncHttpRequest class

    public class CustomList extends ArrayAdapter<String> {

        private final Activity context;

        public CustomList(Activity context){
            super(context, R.layout.search_list, themeNum);
            this.context = context;
        }

        @NonNull
        @Override
        public View getView(final int position, View convertView,  ViewGroup parent) {

            LayoutInflater inflater = context.getLayoutInflater();
            View rowView = inflater.inflate(R.layout.search_list,null,true);

            //위젯가져오기
            final ImageView imageViewTV = (ImageView)rowView.findViewById(R.id.imageView1);
            TextView tp_nameView = (TextView)rowView.findViewById(R.id.textView1);
            TextView tp_regidateView = (TextView)rowView.findViewById(R.id.textView2);
            TextView tp_contentView = (TextView)rowView.findViewById(R.id.content1);

            Log.i("어디한번바볼까", themeContent.get(position));

            //뷰에 내용 삽입하기
            //imageView.setImageResource(images[position]);

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
                        bitmap = Bitmap.createScaledBitmap(bitmap,bitmap.getWidth()*SCALE,bitmap.getHeight()*SCALE,true);


                        imageViewTV.setImageBitmap(bitmap);

                    }
                    catch (MalformedURLException e) {}
                    catch (IOException e) {}

                }
            };
            mThread.start();
            try {mThread.join();}
            catch (InterruptedException e){}


            if(themeName.get(position).length() <9){
                tp_nameView.setText(themeName.get(position));
            }
            else{
                tp_nameView.setText(themeName.get(position).substring(0,7)+"...");
            }


            tp_regidateView.setText(themeRegidate.get(position));

            if(themeContent.get(position).length() <17){
                tp_contentView.setText(themeContent.get(position));
            }
            else{
                tp_contentView.setText(themeContent.get(position).substring(0,14)+"...");
            }



            return rowView;
        }
    }//CustomList

 /*   public void onBtnLogoutClicked(View v){
        //객체를 비워준다.
        SharedPreferences sf = getSharedPreferences(sessionKey, 0);
        SharedPreferences.Editor editor = sf.edit();
        editor.putString("USER_ID", "");
        editor.putString("USER_PW", "");
        editor.commit(); // 파일에 최종 반영함

        Intent intent = new Intent(this, SearchActivity.class);
        startActivity(intent);
        overridePendingTransition(R.anim.slide_in_right, R.anim.hold);
        finish();
    }*/

}