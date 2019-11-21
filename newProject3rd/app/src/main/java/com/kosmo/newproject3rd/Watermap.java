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

public class Watermap extends AppCompatActivity {

    private static final String TAG = "KOSMO";
    SupportMapFragment mapFragment;
    GoogleMap map;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_watermap);

        mapFragment = (SupportMapFragment)getSupportFragmentManager().findFragmentById(R.id.map2);
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
                        "월곶 에코피아 워터파크",
                        "강화로얄워터파크",
                        "통일 워터파크",
                        "중랑천 워터파크",
                        "워터킹덤 & 스파",
                        "씨랄라",
                        "아쿠와조이",
                        "아쿠아필드 하남",
                        "캐리비안 베이",
                        "블루레이크",
                        "설악워터피아",
                        "롯데 리조트 속초 워터파크",
                        "쏠비치아쿠아월드",
                        "하이원 워터월드",
                        "디오션 워터파크",
                        "대명리조트 천안오션파크",
                        "썬밸리호텔 워터파크",
                        "원마운트 워터파크",
                        "오션월드",
                        "경주월드캘리포니아비치"
                };

                //위경도
                ArrayList<LatLng> loc = new ArrayList<LatLng>();

                loc.add(new LatLng(37.409278, 126.755512));
                loc.add(new LatLng(37.624334, 126.487128));
                loc.add(new LatLng(37.689398, 126.874834));
                loc.add(new LatLng(37.6444693,127.0561312));
                loc.add(new LatLng(37.480273, 127.124279));
                loc.add(new LatLng(37.518125, 126.899916));
                loc.add(new LatLng(37.608927, 127.178003));
                loc.add(new LatLng(37.544357, 127.225679));
                loc.add(new LatLng(37.297125, 127.200907));
                loc.add(new LatLng(37.701822, 127.517707));
                loc.add(new LatLng(38.208115, 128.527323));
                loc.add(new LatLng(38.1805246,128.6120416));
                loc.add(new LatLng(38.088118, 128.665901));
                loc.add(new LatLng(37.211087, 128.815901));
                loc.add(new LatLng(34.731996, 127.644142));
                loc.add(new LatLng(36.757030, 127.223146));
                loc.add(new LatLng(37.293170, 127.660926));
                loc.add(new LatLng(37.664550, 126.754359));
                loc.add(new LatLng(37.648408, 127.685791));
                loc.add(new LatLng(35.835792, 129.282882));

                String[] address ={
                        "경기도 시흥시 서해안로 900",
                        "인천광역시 강화군 길상면 보리고개로 174",
                        "경기도 고양시 덕양구 대자동 1150-5",
                        "서울특별시 노원구 상계동 770-6",
                        "서울특별시 송파구 문정동 송파대로 111 송파파크하비오 202동 B1",
                        "서울특별시 영등포구 문래동 문래로 164",
                        "경기도 남양주시 이패동 강변북로 876",
                        "하남 스타필드 3층 신장동 616 하남시 경기도",
                        "경기도 용인시 처인구 포곡읍 에버랜드로 199",
                        "경기도 가평군 청평면 고성리 103-1",
                        "강원도 속초시 장사동 미시령로2983번길 88",
                        "강원도 속초시 대포동 908-1",
                        "강원도 양양군 손양면 오산리 23-4",
                        "강원도 정선군 사북읍 하이원길 175",
                        "전남 여수시 소호로 295",
                        "충남 천안시 동남구 성남면 종합휴양지로 200",
                        "경기 여주시 강변유원지길 45",
                        "경기 고양시 일산서구 한류월드로 300",
                        "강원 홍천군 서면 한치골길 262",
                        "경북 경주시 보문로 544"

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