import 'package:http/http.dart' as http;
import 'dart:convert';

class FrequentZone {
  final double lo_crd; //다발지역지점 중심점의 경도(EPSG 4326)
  final double la_crd; //다발지역의 중심점의 위도(EPSG 4326)
  final String spot_nm; //위치 이름
  final String bjd_cd; //법정동 코드
  final String spot_cd; //사고다발지역 목록 내의 지점코드
  final String sido_sgg_nm; //지점의 관할경찰서명
  final int occrrnc_cnt; //다발지역 내 발생건수
  final int caslt_cnt; //다발지역 내 사상자수
  final int dth_dnv_cnt; //다발지역 내 사망자수
  final int se_dnv_cnt; //다발지역 내 중상자수
  final int sl_dnv_cnt; //다발지역 내 경상자수
  final int wnd_dnv_cnt;//다발지역 내 부상신고자수

  FrequentZone({this.bjd_cd, this.spot_cd, this.sido_sgg_nm, this.occrrnc_cnt, this.caslt_cnt, this.dth_dnv_cnt, this.se_dnv_cnt, this.sl_dnv_cnt, this.wnd_dnv_cnt, this.lo_crd, this.la_crd, this.spot_nm});

  factory FrequentZone.fromJson(Map<String, dynamic> json) {
    return FrequentZone(
        lo_crd: double.parse(json['lo_crd']),
        la_crd: double.parse(json['la_crd']),
        spot_nm: json['spot_nm'],
        bjd_cd: json['bjd_cd'],
        spot_cd : json['spot_cd'],
        sido_sgg_nm : json['sido_sgg_nm'],
        occrrnc_cnt : json['occrrnc_cnt'],
        caslt_cnt : json['caslt_cnt'],
        dth_dnv_cnt : json['dth_dnv_cnt'],
        se_dnv_cnt : json['se_dnv_cnt'],
        sl_dnv_cnt : json['sl_dnv_cnt'],
        wnd_dnv_cnt : json['wnd_dnv_cnt']
    );
  }
}

Future<List<FrequentZone>> fetchPost() async {
  String authKey =
      'qNERkMUMsUQ31Exb%2BQHaUTRqKK%2Fafnv4oOmL0crEcTXgjPSepxNdv07ap6IxuiEq';
  String searchYearCd = '2018';
  String siDo = '11';
  String guGun = '440';
  String type = 'json';

  final response = await http.get(
      'http://taas.koroad.or.kr/data/rest/frequentzone/pdestrians/jaywalking?authKey=$authKey&searchYearCd=$searchYearCd&siDo=$siDo&guGun=$guGun&type=$type');

  if (response.statusCode == 200) {
    List<FrequentZone> result = new List<FrequentZone>();
    int totalCount = json.decode(response.body)['totalCount']; //총 결과
    for (int i = 0; i < totalCount; i++) {
      var item = json.decode(response.body)['items']['item'][i];
      result.add(FrequentZone.fromJson(item));
    }
    return result;
  } else {
    // 만약 응답이 OK가 아니면, 에러를 던지기.
    throw Exception('Failed to load post');
  }
}
