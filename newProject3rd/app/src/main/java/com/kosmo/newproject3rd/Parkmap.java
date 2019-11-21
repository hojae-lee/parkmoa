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

public class Parkmap extends AppCompatActivity {

    private static final String TAG = "KOSMO";
    SupportMapFragment mapFragment;
    GoogleMap map;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_parkmap);

        mapFragment = (SupportMapFragment)getSupportFragmentManager().findFragmentById(R.id.map1);
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
                        "에버랜드",
                        "롯데월드",
                        "서울랜드",
                        "아인스월드",
                        "서울대공원",
                        "월미테마파크",
                        "제주허브동산",
                        "어린이 대공원",
                        "하이원리조트 레포츠놀이동산",
                        "피터팬 놀이동산",
                        "제주마린파크",
                        "부산어린이대공원 키득키득파크",
                        "마이랜드",
                        "애니랜드",
                        "금강랜드",
                        "금오산랜드",
                        "금강하굿둑 놀이공원",
                        "광주 어린이대공원",
                        "대전오월드조이랜드",
                        "새만금 어린이랜드",
                        "고성당항포랜드",
                        "강촌랜드",
                        "꿈의동산놀이공원",
                        "두리랜드",
                        "육림랜드",
                        "진주랜드",
                        "삽교호놀이동산",
                        "수성랜드",
                        "일출랜드",
                        "농협안성팜랜드",
                        "경주월드",
                        "섬진강기차마을드림랜드",
                        "하이원 추추파크"
                };

                //위경도
                ArrayList<LatLng> loc = new ArrayList<LatLng>();

                loc.add(new LatLng(37.2939104, 127.2022928));
                loc.add(new LatLng(37.51112, 127.0959837));
                loc.add(new LatLng(37.4341605, 127.0179434));
                loc.add(new LatLng(37.5126744, 126.7446713));
                loc.add(new LatLng(37.4275289, 126.5941037));
                loc.add(new LatLng(37.4713222,126.5941037));
                loc.add(new LatLng(33.3297996, 126.8127607));
                loc.add(new LatLng(37.4892272, 126.98057011));
                loc.add(new LatLng(37.207469, 128.825320));
                loc.add(new LatLng(37.4491042,126.7092878));
                loc.add(new LatLng(33.241013, 126.334754));
                loc.add(new LatLng(35.184810, 129.043522));
                loc.add(new LatLng(37.4749807,126.5965668));
                loc.add(new LatLng(37.6043386,126.7445023));
                loc.add(new LatLng(36.019838, 126.758676));
                loc.add(new LatLng(36.112615, 128.316428));
                loc.add(new LatLng(36.019684, 126.735876));
                loc.add(new LatLng(35.181444, 126.884667));
                loc.add(new LatLng(36.288905, 127.397821));
                loc.add(new LatLng(35.947241, 126.611354));
                loc.add(new LatLng(35.056716, 128.398392));
                loc.add(new LatLng(37.8112988,127.6330484));
                loc.add(new LatLng(37.783986, 127.471792));
                loc.add(new LatLng(37.724906, 126.950483));
                loc.add(new LatLng(37.9178985,127.7179258));
                loc.add(new LatLng(35.174970, 128.035684));
                loc.add(new LatLng(36.890406, 126.822323));
                loc.add(new LatLng(35.826869, 128.613325));
                loc.add(new LatLng(33.383784, 126.841320));
                loc.add(new LatLng(36.992355, 127.193262));
                loc.add(new LatLng(35.835801, 129.282835));
                loc.add(new LatLng(35.277848, 127.310646));
                loc.add(new LatLng(37.182472, 129.039263));

                String[] address = {
                        "경기도 용인시 처인구 포곡읍 에버랜드로",
                        "서울특별시 송파구 잠실동 올림픽로 240",
                        "경기도 과천시 막계동 광명로 181",
                        "경기도 부천시 원미구 상동 도약로 1",
                        "경기도 과천시 막계동 대공원광장로 102",
                        "인천광역시 중구 북성동 월미문화로 81",
                        "제주특별자치도 서귀포시 표선면 돈오름로 170",
                        "서울특별시 광진구 능동 능동로 216",
                        "강원도 정선군 고한읍 하이원길 424",
                        "경상남도 거제시 중곡1로 92 한일빌딩",
                        "제주특별자치도 서귀포시 안덕면 화순중앙로 132",
                        "부산광역시 부산진구 새싹로 295",
                        "인천광역시 중구 월미로 252",
                        "경기도 화성시 송산면 지화리 산70",
                        "전라북도 군산시 성산면 철새로 53 금강랜드",
                        "경상남도 하동군 진교면 구고속도로 374-30",
                        "충청남도 서천군 마서면 장산로855번길 13",
                        "광주광역시 북구 하서로 52",
                        "대전광역시 중구 사정동",
                        "전라북도 군산시 새만금북로 520",
                        "경상남도 고성군 회화면 봉동리 산166-3",
                        "강원도 춘천시 남산면 강촌로 88",
                        "경기도 가평군 청평면 에덴벚꽃길 189",
                        "경기도 양주시 장흥면 권율로 120",
                        "강원도 춘천시 영서로 2965 육림공원",
                        "경상남도 진주시 남강로1번길 112-6 진주랜드",
                        "충청남도 당진시 신평면 삽교천3길 15 삽교호놀이동산",
                        "대구광역시 수성구 용학로 35-5",
                        "제주특별자치도 서귀포시 성산읍 중산간동로 4150-30",
                        "경기도 안성시 공도읍 대신두길 28",
                        "경상북도 경주시 보문로 544",
                        "전남 곡성군 오곡면 오지리 745-5",
                        "강원도 삼척시 도계음 심포남길 99호 (주)하히원추추파크"
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