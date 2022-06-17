import 'package:geolocator/geolocator.dart';

class MyLocation {
  double? latitude2;
  double? longitude2;

  Future<void> getMyCurrentLocation() async{
    try {
      Position position = await Geolocator.getCurrentPosition( // 위치와 경도 가져온다.
          desiredAccuracy: LocationAccuracy.high);
      latitude2 = position.latitude;
      longitude2 = position.longitude;

      print(position);
      print(latitude2);
      print(longitude2);
    } catch (e) {
      print("API 연결에 문제가 발생했습니다.");
    }
  }
}