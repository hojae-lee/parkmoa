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

public class TreeMap extends AppCompatActivity {

    private static final String TAG = "KOSMO";
    SupportMapFragment mapFragment;
    GoogleMap map;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_tree_map);

        mapFragment = (SupportMapFragment)getSupportFragmentManager().findFragmentById(R.id.map4);
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
                        "세미원",
                        "제이드가든",
                        "천리포수목원",
                        "국립수목원",
                        "한밭수목원",
                        "물향기수목원",
                        "한라수목원",
                        "벽초지 수목원",
                        "대구수목원",
                        "양평들꽃수목원",
                        "홍릉숲",
                        "경상남도수목원",
                        "청산수목원",
                        "푸른수목원",
                        "산들소리수목원",
                        "덕평공룡수목원",
                        "강릉솔향수목원",
                        "금강수목원",
                        "한국도로공사 전주수목원",
                        "미동산수목원"
                };

                //위경도
                ArrayList<LatLng> loc = new ArrayList<LatLng>();

                loc.add(new LatLng(37.5382032,127.3195693));
                loc.add(new LatLng(37.8325325,127.5401149));
                loc.add(new LatLng(36.8005798,126.1487456));
                loc.add(new LatLng(37.7545707,127.1637625));
                loc.add(new LatLng(36.365911, 127.387865));
                loc.add(new LatLng(37.166809, 127.056751));
                loc.add(new LatLng(33.470151, 126.493245));
                loc.add(new LatLng(37.800776, 126.873872));
                loc.add(new LatLng(35.799212, 128.523700));
                loc.add(new LatLng(37.502392, 127.469715));
                loc.add(new LatLng(37.593711, 127.043994));
                loc.add(new LatLng(35.160180, 128.294253));
                loc.add(new LatLng(36.688505, 126.297075));
                loc.add(new LatLng(37.484171, 126.825498));
                loc.add(new LatLng(37.650770, 127.101190));
                loc.add(new LatLng(37.232561, 127.338214));
                loc.add(new LatLng(37.692967, 128.860918));
                loc.add(new LatLng(36.490517, 127.233423));
                loc.add(new LatLng(35.871181, 127.054243));
                loc.add(new LatLng(36.626124, 127.667214));

                String[] address = {
                        "경기 양평군 양서면 양수로 93",
                        "강원 춘천시 남산면 햇골길 80 제이드가든수목원",
                        "충남 태안군 소원면 천리포1길 187 천리포수목원",
                        "경기 포천시 소흘읍 광릉수목원로 415",
                        "대전 서구 둔산대로 169",
                        "경기 오산시 청학로 211",
                        "제주 제주시 수목원길 72",
                        "경기 파주시 광탄면 부흥로 242",
                        "대구 달서구 화암로 342 대구수목원관리사무소",
                        "경기 양평군 양평읍 수목원길 16",
                        "서울 동대문구 회기로 57",
                        "경남 진주시 이반성면 수목원로 386 경상남도수목원",
                        "충남 태안군 남면 연꽃길 70",
                        "서울 구로구 연동로 240",
                        "경기 남양주시 불암산로59번길 48-31 산들소리수목원",
                        "경기 이천시 마장면 작촌로 282",
                        "강원 강릉시 구정면 수목원길 156",
                        "세종 금남면 산림박물관길 110 산림박물관",
                        "전북 전주시 덕진구 번영로 462-45 전주수목원",
                        "충북 청주시 상당구 미원면 수목원길 51 충북 산림환경연구원"
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