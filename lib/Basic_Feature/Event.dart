import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:turnhouse/Adding/add_Event.dart';
import 'package:turnhouse/Item_data.dart';
import 'package:turnhouse/http_func.dart';
import 'package:turnhouse/modify_Event.dart';

class EventWidget extends StatefulWidget {
  const EventWidget({Key? key}) : super(key: key);

  @override
  _EventWidgetState createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future <List<dynamic>> getevent() async {
    final String url = "http://3.39.183.150:8080/api/events/${context.read<User_info>().town_id}";

    Http_get get_data = Http_get(url);
    var event_data = await get_data.getJsonData();

    print(event_data['data']);
    return event_data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF252735),
        automaticallyImplyLeading: false,
        leading: IconButton(
          //borderColor: Colors.transparent,
          //borderRadius: 30,
          //borderWidth: 1,
          //buttonSize: 60,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Color(0xFF4391F1),
            size: 30,
          ),
          onPressed: () {
            print('IconButton pressed ...');

            Navigator.pop(context, '이전 화면');
          },
        ),
        title: Text(
          '홈 화면',
          style: GoogleFonts.lato(
            color: Color(0xFF4391F1),
            fontSize: 22,
          ),
        ),
        centerTitle: false,
        elevation: 2,
      ),
      backgroundColor: Color(0xFF1A1925),
      body: Center(
        child:  FutureBuilder<List<dynamic>>(
          future: getevent(),
          builder: (context, snapshot) {
            if (snapshot.hasData == false) {
              return CircularProgressIndicator();
            }
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(40, 10, 10, 10),
                      child: Text(
                        '마을 행사 내역',
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index){
                      int id = snapshot.data?[index]['id'];
                      //print(id);
                      int townId = snapshot.data?[index]['townId'];
                      //print(townId);
                      String title = snapshot.data?[index]['title'];
                      //print(title);
                      String content = snapshot.data?[index]['content'];
                      //print(content);
                      String fromEventDate = snapshot.data?[index]['fromEventDate'];
                      //print(fromEventDate);
                      String toEventDate = snapshot.data?[index]['toEventDate'];
                      //print(toEventDate);

                      return Container(
                        child: ListTile(
                          onTap: () {
                            showDialog(
                                context: context,
                                //barrierDismissible: false,
                                builder: (BuildContext context){
                                  return AlertDialog(
                                    backgroundColor: Color(0xFF252735),
                                    title: Text(
                                      '[ ' + fromEventDate + ' ~ ' +  toEventDate + ' ] ' + title,
                                      style: GoogleFonts.lato(
                                        color: Colors.white,
                                        fontSize: 30,
                                      ),
                                    ),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text(
                                            ' •  행사 내용: ' + content,
                                            style: GoogleFonts.lato(
                                              color: Colors.white70,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('확인'),
                                        onPressed: (){
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                }
                            );
                          },
                          leading: Icon(
                            Icons.event,
                            color: Colors.white,
                            size: 24.0,
                          ),
                          title: Text(
                              '[ ' + fromEventDate + ' ~ ' +  toEventDate + ' ] ' + title
                          ),
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.white24,
                                width: 0.5,
                              )
                          ),
                          trailing: OutlinedButton(
                            onPressed: () {
                              print('삭제 버튼 pressed ...');

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        modify_Event(id, fromEventDate, toEventDate, title, content)),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(width: 1.0, color: Color(0xFF4291F2)),
                            ),
                            child: Text(
                              '수정',
                              style: GoogleFonts.lato(
                                color: Color(0xFF4291F2),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 40),
                        child: Container(
                          width: 350,
                          height: 80,
                          child: ElevatedButton(
                            onPressed: () {
                              print('기능 버튼 pressed ...');

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => add_Event()),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color(0xFF4391F1)),
                              //textStyle: GoogleFonts.lato(color: Colors.white),
                            ),
                            child: Text(
                              '마을 이벤트 추가',
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
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
          }
        ),
      ),
    );
  }
}
