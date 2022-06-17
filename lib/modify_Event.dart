import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:turnhouse/Item_data.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:turnhouse/http_func.dart';
import 'package:turnhouse/Basic_Feature/Event.dart';

class modify_Event extends StatefulWidget {
  final int e_id;
  final String fromEventDate;
  final String toEventDate;
  final String title;
  final String content;

  const modify_Event(this.e_id, this.fromEventDate, this.toEventDate,
      this.title, this.content);

  @override
  _modify_EventWidgetState createState() => _modify_EventWidgetState();
}

class _modify_EventWidgetState extends State<modify_Event> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  Future<String> modify_existing_event() async {
    final String url = "http://3.39.183.150:8080/api/events/${widget.e_id.toString()}";
    Map data = {"townId": int.parse(context.read<User_info>().town_id), "title": _title.text, "content": _content.text, "fromEventDate": _fromEventData.text, "toEventDate": _toEventDate.text };

    var body = json.encode(data);
    String status;

    Http_post post_data = Http_post(url, body);

    var event_data = await post_data.getJsonData();

    //status로 받아와서 성공여부만 표시
    status = event_data['status'];

    return status;
  }

  TextEditingController _fromEventData = TextEditingController();//행사시작
  TextEditingController _toEventDate = TextEditingController();//행사 끝
  TextEditingController _title = TextEditingController();//제목
  TextEditingController _content = TextEditingController();//내용


  @override
  void initState(){
    _fromEventData = TextEditingController(text: widget.fromEventDate);//행사시작
    _toEventDate = TextEditingController(text: widget.toEventDate);//행사 끝
    _title = TextEditingController(text: widget.title);//제목
    _content = TextEditingController(text: widget.content);//내용
  }

  @override
  void dispose(){
    _fromEventData.dispose();
    _toEventDate.dispose();
    _title.dispose();
    _content.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.e_id);
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
                        '마을 행사 수정',
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: _fromEventData,
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context, initialDate: DateTime.parse(widget.fromEventDate),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2100)
                      );

                      if(pickedDate != null ){
                        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                        setState(() {
                          _fromEventData.text = formattedDate;
                        });
                      }
                      print(_fromEventData.text);
                    },
                    validator: (value){
                      if(value == null){
                        return '행사 시작 일자를 입력해주세요';
                      }
                      return null;
                    },
                    style: GoogleFonts.lato(
                      color: Colors.black87,
                      fontSize: 24,
                    ),
                    decoration: InputDecoration(
                      labelText: '행사 시작',
                      hintText: '행사 시작 날을 입력해주세요.',
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
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: _toEventDate,
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context, initialDate: DateTime.parse(widget.toEventDate),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2100)
                      );
                      if(pickedDate != null ){
                        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                        setState(() {
                          _toEventDate.text = formattedDate;
                        });
                      }
                    },
                    validator: (value){
                      if(value == null){
                        return '행사 종료 일자를 입력해주세요';
                      }
                      return null;
                    },
                    style: GoogleFonts.lato(
                      color: Colors.black87,
                      fontSize: 24,
                    ),
                    decoration: InputDecoration(
                      labelText: '행사 종료',
                      hintText: '행사 종료 날을 입력해주세요.',
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
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: _title,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return '행사 이름을 입력해주세요';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: '제목',
                      hintText: '행사 이름을 입력해주세요.',
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
                      fontSize: 24,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: _content,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return '행사 설명을 입력해주세요';
                      }
                      return null;
                    },
                    minLines: 6,
                    maxLines: 6,
                    decoration: InputDecoration(
                      labelText: '내용',
                      hintText: '행사 설명을 입력해주세요.',
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
                            print('확인 버튼 pressed ...');

                            modify_existing_event().then((result) {//가입 JSON post받음
                              setState(() {
                                print("성공 여부: " + result);

                                if(_formKey.currentState!.validate()){
                                  Navigator.pop(context, '이전 화면');
                                  Navigator.pop(context, '이전 화면');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => EventWidget()),
                                  );
                                }
                              });
                            });
                          },
                          child: Text(
                            '확  인',
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
