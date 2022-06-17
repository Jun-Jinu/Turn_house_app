import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:turnhouse/Item_data.dart';
import 'package:turnhouse/http_func.dart';

class TownInfoWidget extends StatefulWidget {
  const TownInfoWidget({Key? key}) : super(key: key);

  @override
  _TownInfoWidgetState createState() => _TownInfoWidgetState();
}

class _TownInfoWidgetState extends State<TownInfoWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future <List<dynamic>> get_terminal() async {
    final String url = "http://3.39.183.150:8080/api/terminal/${context.read<User_info>().town_id}";

    Http_get get_data = Http_get(url);
    var terminal_data = await get_data.getJsonData();

    print(terminal_data['data']);
    return terminal_data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(//
        backgroundColor: Color(0xFF252735),
        automaticallyImplyLeading: false,
        leading: IconButton(
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
          future: get_terminal(),
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
                        '마을 정보',
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
                    itemBuilder: (context, index) {
                      int terminal_id = snapshot.data?[index]['id'];
                      //print(terminal_id);
                      String name = snapshot.data?[index]['name'];
                      //print(name);
                      String phone = snapshot.data?[index]['phone'];
                      //print(phone);
                      String address = snapshot.data?[index]['address'];
                      //print(address);

                      return Container(
                          child: ListTile(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  //barrierDismissible: false,
                                  builder: (BuildContext context){
                                    return AlertDialog(
                                      backgroundColor: Color(0xFF252735),
                                      title:Text(
                                        name + '의 단말기 정보',
                                        style: GoogleFonts.lato(
                                          color: Colors.white,
                                          fontSize: 30,
                                        ),
                                      ),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            Text(
                                              ' •  사용자 전화번호: ' + phone + '\n\n' +
                                                  ' •  사용자 주소: ' + address + '\n\n',
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
                              Icons.home_filled,
                              color: Colors.white,
                              size: 24.0,
                            ),
                            title: Text(
                              name,
                            ),
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.white24,
                                  width: 0.5,
                                )
                            ),
                            subtitle: Text(
                              phone,
                              style: GoogleFonts.lato(
                                color: Colors.white60,
                              ),
                            ),
                            trailing: Text(
                                '주소: ' + address
                            ),
                          ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}