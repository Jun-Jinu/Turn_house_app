import 'package:flutter/material.dart';

class Customer_Service {
  DateTime date;//자동저장_요청일
  String title;
  String sender;
  String category;
  String content;
  bool answer_check = false;

  Customer_Service(
      this.date, this.title, this.sender,
      this.category, this.content, this.answer_check
  );
}

class Terminal {//이름 번호 주소 보호자번호 보호자이름
  String name;
  String phone;
  String address;

  Terminal(this.name, this.phone, this.address);
}

class Broadcast {
  DateTime date;
  String receiver;
  String content;//음성 Speech To Text

  Broadcast(this.date, this.receiver, this.content);
}

class Message {//클리어
  String id;
  String townId;
  String target;//수신자 설정(전체_a, 마을관리자_m, 보호자_p)
  String content;//내용
  bool success;

  Message(
      this.id, this.townId, this.target,
      this.content, this.success
  );
}

class Event {
  String id;
  String townId;
  String title;
  String content;
  String createdDatetime;
  String fromEventDate;
  String toEventDate;

  Event(this.id, this.townId, this.title, this.content, this.createdDatetime,
      this.fromEventDate, this.toEventDate);
}

class Weather {
  String temp;//현재 온도
  String tempMin;//최저 온도
  String tempMax;//최고 온도
  String weatherMain;//흐림정도
  int code;//흐림정도의 id(icon 작업시 필요)

  Weather(this.temp, this.tempMin, this.tempMax,
    this.weatherMain, this.code,);
}

class User {
  String status;
  String id;//유저 계정 id가 아닌 고유번호(id)를 불러옴

  User(this.status, this.id);
}

class User_info with ChangeNotifier{
  String _user_id = "";//유저 고유번호
  String _town_id = "";//마을 고유번호

  void set_user_id(String id){
    _user_id = id;
    notifyListeners();
  }

  void set_town_id(String id){
    _town_id = id;
    notifyListeners();
  }

  String get user_id => _user_id;
  String get town_id => _town_id;
}