import 'package:http/http.dart' as http;
import 'dart:convert';

class FrequentZone {
  final double lo_crd; //다발지역지점 중심점의 경도(EPSG 4326)
  final double la_crd; //다발지역의 중심점의 위도(EPSG 4326)
  final String spot_nm; //위치 이름

  FrequentZone({this.lo_crd, this.la_crd, this.spot_nm});

  factory FrequentZone.fromJson(Map<String, dynamic> json) {
    return FrequentZone(
        lo_crd: double.parse(json['lo_crd']),
        la_crd: double.parse(json['la_crd']),
        spot_nm: json['spot_nm']);
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
