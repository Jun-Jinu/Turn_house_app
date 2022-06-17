import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:turnhouse/Item_data.dart';
import 'package:turnhouse/Adding/add_Broadcast.dart';
import 'package:turnhouse/http_func.dart';

class BroadcastWidget extends StatefulWidget {
  const BroadcastWidget({Key? key}) : super(key: key);

  @override
  _BroadcastState createState() => _BroadcastState();
}

class _BroadcastState extends State<BroadcastWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future <List<dynamic>> getBroadcast() async {
    final String url = "http://3.39.183.150:8080/api/announce/${context.read<User_info>().town_id}";

    Http_get get_data = Http_get(url);
    var event_data = await get_data.getJsonData();

    print(event_data['data']);
    return event_data['data'];
  }

  Future <String> delete_Broadcast(String broadcast_id) async {
    final String url = "http://3.39.183.150:8080/api/announce/${broadcast_id}";

    Http_delete del_data = Http_delete(url);
    var log_del = await del_data.getJsonData();

    print(log_del['status']);
    return log_del['status'];
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
        child: FutureBuilder<List<dynamic>>(
          future: getBroadcast(),
            builder: (context, snapshot){
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
                          '마을 방송 내역',
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
                        String content = snapshot.data?[index]['content'];
                        //print(content);
                        String createdDate = snapshot.data?[index]['createdDate'];
                        //print(content);

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
                                        '[${createdDate}] \n방송 내역',
                                        style: GoogleFonts.lato(
                                          color: Colors.white,
                                          fontSize: 30,
                                        ),
                                      ),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            Text(
                                              ' •  내용: ' + content,
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
                              Icons.announcement,
                              color: Colors.white,
                              size: 24.0,
                            ),
                            title: Text(
                                '[${createdDate}]\n마을 방송 내역'
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

                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context){
                                      return AlertDialog(
                                        title: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.dangerous_outlined,
                                              color: Colors.red,
                                              size: 22,
                                            ),
                                            Text(
                                              ' 경고',
                                              style: GoogleFonts.lato(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22,
                                              ),
                                            ),
                                          ],
                                        ),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: <Widget>[
                                              Text('선택한 방송 기록을 삭제합니다.'),
                                              Text('정말로 해당 기록을 삭제하시겠습니까?'),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text('취소'),
                                            onPressed: (){
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: Text('확인'),
                                            onPressed: (){
                                              delete_Broadcast(id.toString()).then((result) {//가입 JSON post받음
                                                setState(() {
                                                  print("결과: " + result);

                                                  Navigator.pop(context, '이전 화면');
                                                  Navigator.push(//재조회
                                                    context,
                                                    MaterialPageRoute(builder: (context) => BroadcastWidget()),
                                                  );
                                                });
                                              });
                                            },
                                          ),
                                        ],
                                      );
                                    }
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(width: 1.0, color: Color(0xFF4291F2)),
                              ),
                              child: Text(
                                '삭제',
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

                          child:Container(
                            width: 350,
                            height: 80,
                            child:ElevatedButton(
                              onPressed: () {
                                print('방송하기 버튼 pressed ...');

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => add_Broadcast()),
                                );
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Color(0xFF4391F1)),
                              ),
                              child: Text(
                                '방 송 하 기',
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