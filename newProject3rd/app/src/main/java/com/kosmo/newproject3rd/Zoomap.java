package com.kosmo.newproject3rd;

import androidx.appcompat.app.AppCompatActivity;

import android.graphics.Bitmap;
import android.graphics.drawable.BitmapDrawable;
import android.os.Bundle;
import android.util.Log;
import android.widget.Toast;

import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.MapsInitializer;
import com.google.android.gms.maps.OnMapReadyCallback;
import com.google.android.gms.maps.SupportMapFragment;
import com.google.android.gms.maps.model.BitmapDescriptorFactory;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.Marker;
import com.google.android.gms.maps.model.MarkerOptions;

import java.util.ArrayList;

public class Zoomap extends AppCompatActivity {

    private static final String TAG = "KOSMO";
    SupportMapFragment mapFragment;
    GoogleMap map;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_zoomap);

        mapFragment = (SupportMapFragment)getSupportFragmentManager().findFragmentById(R.id.map3);
        mapFragment.getMapAsync(new OnMapReadyCallback() {
            @Override
            public void onMapReady(GoogleMap googleMap) {
                Log.d(TAG,"GoogleMap is ready...");
                map = googleMap;

                //가산디지털단지역
                LatLng GASAN = new LatLng(37.478704, 126.878664);
                MarkerOptions markerOptions1 = new MarkerOptions();
                markerOptions1.position(GASAN);
                markerOptions1.title("현재내위치");
                BitmapDrawable bitmapdraw=(BitmapDrawable)getResources().getDrawable(R.drawable.myloc);
                Bitmap b=bitmapdraw.getBitmap();
                Bitmap smallMarker = Bitmap.createScaledBitmap(b, 100, 150, false);
                markerOptions1.icon(BitmapDescriptorFactory.fromBitmap(smallMarker));
                map.addMarker(markerOptions1);
                //지역명
                String[] titles={
                        "코엑스아쿠아리움",
                        "대전아쿠아리움",
                        "부산아쿠아리움",
                        "롯데월드아쿠아리움",
                        "대구아쿠아리움",
                        "울진아쿠아리움",
                        "단양다누리아쿠아리움",
                        "강릉경포아쿠아리움",
                        "거제씨월드",
                        "국립해양박물관",
                        "화진포해양박물관",
                        "서울어린이대공원",
                        "인천대공원 어린이동물원",
                        "아침고요가족동물원",
                        "쥬라리움 일산점",
                        "삼정더파크",
                        "진양호동물원",
                        "부경동물원",
                        "달성공원 동물원",
                        "대전 오월드",
                        "우치공원 동물원",
                        "전주동물원",
                        "육림랜드 동물원",
                        "알파카월드"
                };

                //위경도
                ArrayList<LatLng> loc = new ArrayList<LatLng>();

                loc.add(new LatLng(37.513131,127.0560994));
                loc.add(new LatLng(36.310209, 127.421068));
                loc.add(new LatLng(35.159599, 129.160927));
                loc.add(new LatLng(37.513738, 127.105087));
                loc.add(new LatLng(35.878038, 128.628506));
                loc.add(new LatLng(36.971062, 129.407640));
                loc.add(new LatLng(36.985347, 128.370808));
                loc.add(new LatLng(37.790997, 128.905881));
                loc.add(new LatLng(34.836171, 128.701497));
                loc.add(new LatLng(35.078747, 129.080213));
                loc.add(new LatLng(38.481393, 128.436869));
                loc.add(new LatLng(37.548378, 127.080902));
                loc.add(new LatLng(37.449599, 126.756933));
                loc.add(new LatLng(37.748358, 127.361174));
                loc.add(new LatLng(37.690049, 126.854677));
                loc.add(new LatLng(35.184412, 129.042532));
                loc.add(new LatLng(35.177040, 128.035995));
                loc.add(new LatLng(35.220532, 128.819830));
                loc.add(new LatLng(35.874256, 128.578163));
                loc.add(new LatLng(36.288844, 127.397788));
                loc.add(new LatLng(35.223180, 126.889167));
                loc.add(new LatLng(35.855719, 127.144641));
                loc.add(new LatLng(37.925087, 127.720535));
                loc.add(new LatLng(37.827890, 127.883545));

                String[] address ={
                        "서울특별시 강남구 삼성1동 영동대로513",
                        "대전광역시 중구 대사동 보문산공원로469",
                        "부산광역시 해운구 중동 해운대해변로 266",
                        "서울특별시 송파구 잠실6동 올림픽로 300",
                        "대구광역시 동구 신천4동 동부로 149",
                        "경상북도 울진군 근남면 수산리 346",
                        "충청북도 단양군 단양읍 별곡리 568",
                        "강원도 강릉시 경포동 난설헌로 131",
                        "경상남도 거제시 일운면 지세포해안로15",
                        "부산광역시 영도구 동삼1동 해양로301번길 45",
                        "강원도 고성군 현내면 화진포길 412",
                        "서울특별시 광진구 능동 능동로216",
                        "인천광역시 남동구 장수동 595-4",
                        "경기도 가평군 상면 임초밤안골로 301",
                        "경기도 고양시 덕양구 관산동 290",
                        "부산광역시 부산진구 초읍동 새싹로 295-1",
                        "경상남도 진주시 판문동 남강로1번길 130",
                        "경상남도 김해시 장유면 유하로226번길 70",
                        "대구광역시 중구 달성공원로 35",
                        "대전광역시 중구 사정동 사정공원로 70",
                        "광주광역시 북구 생용동 산138",
                        "전라북도 전주시 덕진구 덕진동1가 소리로68",
                        "강원도 춘천시 사농동 61-2",
                        "강원도 홍천군 화촌면 풍천리 310"
                };


                for(int idx=0; idx<titles.length; idx++){
                    MarkerOptions markerOptions = new MarkerOptions();
                    markerOptions.position(loc.get(idx));
                    markerOptions.title(titles[idx]);
                    markerOptions.snippet(address[idx]);

                    map.addMarker(markerOptions);
                }

                //카메라이동 및 최초레벨 지정
                map.animateCamera(CameraUpdateFactory.newLatLngZoom(GASAN, 10));
                map.setMapType(GoogleMap.MAP_TYPE_NORMAL);

                //마커클릭에 대한 리스너
                map.setOnMarkerClickListener(new GoogleMap.OnMarkerClickListener(){
                    @Override
                    public boolean onMarkerClick(Marker marker) {
                        Toast.makeText(getApplicationContext(),marker.getTitle(),
                                Toast.LENGTH_SHORT).show();

                        //true로 하면 InfoWindow가 안나온다.
                        return false;
                    }
                });

                //정보창 클릭에 대한 리스너
                map.setOnInfoWindowClickListener(new GoogleMap.OnInfoWindowClickListener() {
                    @Override
                    public void onInfoWindowClick(Marker marker) {
                        Toast.makeText(getApplicationContext(),
                                marker.getTitle(),
                                Toast.LENGTH_SHORT).show();
                    }
                });
            }
        });
        try {
            MapsInitializer.initialize(this);
        }
        catch (Exception e){
            e.printStackTrace();
        }
    }////onCreate
}