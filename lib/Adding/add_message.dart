import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:turnhouse/Item_data.dart';
import 'dart:convert';
import 'package:turnhouse/http_func.dart';
import 'package:turnhouse/Basic_Feature/Message.dart';

class add_Message extends StatefulWidget {
  const add_Message({Key? key}) : super(key: key);

  @override
  _add_MessageWidgetState createState() => _add_MessageWidgetState();
}

class _add_MessageWidgetState extends State<add_Message> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  Future<String> get_message_info() async {
    final String url = "http://3.39.183.150:8080/api/message";
    Map data = {"townId": int.parse(context.read<User_info>().town_id), "target": (_valueList == "마을 전체") ? 'a' : (_valueList == "마을 관리자" ? 'm' : 'p') , "content": _content.text};

    var body = json.encode(data);

    Http_post post_data = Http_post(url, body);

    //var message_data =
    await post_data.getJsonData();

    return "Good";
  }

  //카테고리 드롭 버튼 설정
  final _valueList = ['메시지 수신 대상을 선택하세요.','마을 전체', '마을 관리자', '보호자'];
  var _selectedValue = '메시지 수신 대상을 선택하세요.';

  var _content = TextEditingController();

  @override
  void dispose(){
    _content.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF252735),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Color(0xFF4391F1),
            size: 40,
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
            fontSize: 28,
          ),
        ),
        centerTitle: false,
        elevation: 2,
      ),
      backgroundColor: Color(0xFF1A1925),
      body: Form(
        key: _formKey,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: ListBody(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(30, 10, 0, 10),
                      child: Text(
                        '문자 전송',
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ],
                ),

                Container(
                  margin: const EdgeInsets.all(16.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.blue,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButton(
                    value: _selectedValue,
                    items: _valueList.map(
                          (value){
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                    onChanged: (value){
                      setState(() {
                        _selectedValue = value.toString();
                      });
                    },
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                    ),
                    isExpanded: true,
                    dropdownColor: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: _content,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return '문자 내용을 입력해주세요';
                      }
                      return null;
                    },
                    minLines: 6,
                    maxLines: 6,
                    decoration: InputDecoration(
                      labelText: '내용',
                      hintText: '문자 내용을 입력해주세요.',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF4291F2),
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.redAccent,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.redAccent,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    style: GoogleFonts.lato(
                      color: Colors.black87,
                      fontSize: 16,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 100,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            print('취소 버튼 pressed ...');

                            Navigator.pop(context, '이전 화면');
                          },
                          child: Text(
                            '취  소',
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        width: 100,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            print('전송 버튼 pressed ...');
                            get_message_info().then((result) {//가입 JSON post받음
                              setState(() {
                                print("내용: " + result);

                                Navigator.pop(context, '이전 화면');
                                Navigator.pop(context, '이전 화면');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => MessageWidget()),
                                );
                              });
                            });

                          },
                          child: Text(
                            '전  송',
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
