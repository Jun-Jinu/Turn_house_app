import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:turnhouse/Basic_Feature/Customer_center.dart';
import 'package:turnhouse/Basic_Feature/Broadcast.dart';
import 'package:turnhouse/Basic_Feature/Message.dart';
import 'package:turnhouse/Basic_Feature/Event.dart';
import 'package:turnhouse/Basic_Feature/town_info.dart';
//import 'package:turnhouse/MyLocation.dart';
import 'package:turnhouse/http_func.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/services.dart';
import 'package:turnhouse/Item_data.dart';

const apiKey = '38c5dd9bd8cfd2ef10e5d910725383c9';

class MainWidget extends StatefulWidget {//
  const MainWidget({Key? key}) : super(key: key);

  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  double? latitude3; // 위도
  double? longitude3; // 경도

  Future<Weather> getWeather() async {
    //MyLocation myLocation = MyLocation();
    //await myLocation.getMyCurrentLocation();

    //현재 위도, 경도
    latitude3 = 37.54783024;//= myLocation.latitude2;
    longitude3 = 127.07471134;//myLocation.longitude2;
    print(latitude3);
    print(longitude3);
    Weather weather;

    //날씨 API - url로 경도, 위도의 날씨 json get하고 parsing
    Http_get network = Http_get('http://api.openweathermap.org/data/2.5/weather?lat=$latitude3&lon=$longitude3&appid=$apiKey');

    var weatherData = await network.getJsonData();
    print(weatherData);

    weather = Weather(
        (weatherData['main']['temp'] - 273.15).toStringAsFixed(1),
        (weatherData["main"]["temp_min"] - 273.15).toStringAsFixed(1),
        (weatherData["main"]["temp_max"] - 273.15).toStringAsFixed(1),
        weatherData["weather"][0]["main"],
        weatherData["weather"][0]["id"]
    );

    print("유져 고유번호 : " + context.read<User_info>().user_id);
    print("마을 고유번호 : " + context.read<User_info>().town_id);
    print('(디버깅)최고/최저 온도: ' + weather.temp.toString() + ' ' + weather.tempMin.toString());
    return weather;
  }

  @override
  Widget build(BuildContext context) {
    //회전 방지
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFF1A1925),
      body: Center(
        child: FutureBuilder(
          future: getWeather(),
          builder: (context, AsyncSnapshot<Weather> snapshot){
            if (snapshot.hasData == false) {
              return CircularProgressIndicator();
            }
            return Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      //padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                      child: Image.asset(
                        'assets/logo.png',
                      ),
                    ),
                    Container(
                      width: 210,
                      height: 65,
                      child:ElevatedButton.icon(
                        onPressed: () {
                          print('고객센터 pressed ...');

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Custemer_centerWidget()),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color(0xFF4291F2)),
                          //textStyle: GoogleFonts.lato(color: Colors.white),
                        ),
                        icon: Icon(
                          Icons.phone_callback,
                          color: Colors.white,
                          size: 24,
                        ),
                        label: Text('고객센터'),
                      ),
                    ),
                  ],
                ),

                Container(
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    color: Color(0xFF252735),
                  ),
                  width: width * 0.8,
                  height: height * 0.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        width: width * 0.3,
                        height: height * 0.2,
                        padding: EdgeInsetsDirectional.fromSTEB(width * 0.02, 0, 0, 0),
                        child: snapshot.data!.code == 800
                            ? Icon(Icons.wb_sunny, size: 100, color: Colors.white)
                            : snapshot.data!.code / 100 == 8 ||
                            snapshot.data!.code / 100 == 2
                            ? Icon(Icons.wb_cloudy, size: 100, color: Colors.white)
                            : snapshot.data!.code / 100 == 3 ||
                            snapshot.data!.code / 100 == 5
                            ? Icon(Icons.beach_access, size: 100, color: Colors.white)
                            : snapshot.data!.code / 100 == 6
                            ? Icon(Icons.ac_unit, size: 100, color: Colors.white)
                            : Icon(Icons.cloud_circle, size: 100, color: Colors.white),
                      ),


                      // 온도
                      Container(
                        alignment: Alignment.center,
                        width: width * 0.4,
                        height: height * 0.2,
                        child: EasyRichText(
    /*'현재 온도 : 16.7°\n\n'
                              '14.3°  /  '
                              '24.2°',
                          defaultStyle: TextStyle(fontSize: 16, color: Colors.white),
                          patternList: [
                            EasyRichTextPattern(
                              targetString: '14.3°',
                              style: TextStyle(color: Colors.blue),
                            ),
                            EasyRichTextPattern(
                              targetString: '24.2°',
                              style: TextStyle(color: Colors.red),
                            ),
                          ],*/
                        '현재 온도 : ${snapshot.data?.temp}°\n\n'
                            '${snapshot.data?.tempMin}°  /  '
                            '${snapshot.data?.tempMax}°',
                          defaultStyle: TextStyle(fontSize: 16, color: Colors.white),
                          patternList: [
                            EasyRichTextPattern(
                              targetString: '${snapshot.data?.tempMin}°',
                              style: TextStyle(color: Colors.blue),
                            ),
                            EasyRichTextPattern(
                              targetString: '${snapshot.data?.tempMax}°',
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                          textAlign: TextAlign.center,
                        ),
                      ),

                    ],
                  ),
                ),

                Row(

                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),

                      child:Container(
                        width: width * 0.35,
                        height: height * 0.2,
                        child:ElevatedButton(
                          onPressed: () {
                            print('summit pressed ...');

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MessageWidget()),
                            );
                          },
                          style: ButtonStyle(
                            //backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
                            //backgroundColor: MaterialStateProperty.all(Color(0xFF252735)),
                            //textStyle: GoogleFonts.lato(color: Colors.white),
                          ),
                          child: Text(
                            '문자\n하기',
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                    ),

                    Align(
                      alignment: AlignmentDirectional(0.05, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        child:Container(
                          width: width * 0.35,
                          height: height * 0.2,
                          child:ElevatedButton(
                            onPressed: () {
                              print('summit pressed ...');

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => BroadcastWidget()),
                              );
                            },
                            style: ButtonStyle(
                              //backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
                              //backgroundColor: MaterialStateProperty.all(Color(0xFF252735)),
                              //textStyle: GoogleFonts.lato(color: Colors.white),
                            ),
                            child: Text(
                              '방송\n하기',
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),

                //아래 버튼 2개
                Row(

                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),

                      child:Container(
                        width: width * 0.35,
                        height: height * 0.2,
                        child:ElevatedButton(
                          onPressed: () {
                            print('summit pressed ...');

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => EventWidget()),
                            );
                          },
                          style: ButtonStyle(
                            //backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
                            //backgroundColor: MaterialStateProperty.all(Color(0xFF252735)),
                            //textStyle: GoogleFonts.lato(color: Colors.white),
                          ),
                          child: Text(
                            '행사\n관리',
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                    ),

                    Align(
                      alignment: AlignmentDirectional(0.05, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        child:Container(
                          width: width * 0.35,
                          height: height * 0.2,
                          child:ElevatedButton(
                            onPressed: () {
                              print('summit pressed ...');

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => TownInfoWidget()),
                              );
                            },
                            style: ButtonStyle(
                              //backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
                              //backgroundColor: MaterialStateProperty.all(Color(0xFF252735)),
                              //textStyle: GoogleFonts.lato(color: Colors.white),
                            ),
                            child: Text(
                              '마을\n정보',
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
