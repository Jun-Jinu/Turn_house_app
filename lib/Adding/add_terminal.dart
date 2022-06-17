import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turnhouse/Item_data.dart';

class add_Terminal extends StatefulWidget {
  const add_Terminal({Key? key}) : super(key: key);

  @override
  _add_TerminalWidgetState createState() => _add_TerminalWidgetState();
}

class _add_TerminalWidgetState extends State<add_Terminal> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  var _name = TextEditingController();
  var _ph = TextEditingController();
  var _address = TextEditingController();
  var _protector_name = TextEditingController();
  var _protector_ph = TextEditingController();

  @override
  void dispose(){
    _name.dispose();
    _ph.dispose();
    _address.dispose();
    _protector_name.dispose();
    _protector_ph.dispose();

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
          //borderColor: Colors.transparent,
          //borderRadius: 30,
          //borderWidth: 1,
          //buttonSize: 60,
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
                        '단말기 추가 요청',
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ],
                ),

                Container(
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
                  child: Text(
                    ' 1. 단말기 사용자 정보',
                    style: GoogleFonts.lato(
                      color: Colors.white54,
                      fontSize: 20,
                    ),
                  ),
                ),


                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                  child: TextFormField(
                    controller: _name,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return '단말기 사용자 이름을 입력해주세요';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: '이름',
                      hintText: '단말기 사용자 이름을 입력해주세요.',
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


                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                  child: TextFormField(
                    controller: _ph,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return '단말기 사용자 번호를 입력해주세요';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: '번호',
                      hintText: '단말기 사용자 번호를 입력해주세요.',
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


                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 16),
                  child: TextFormField(
                    controller: _address,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return '단말기 사용자 주소를 입력해주세요';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: '주소',
                      hintText: '단말기 사용자 주소를 입력해주세요.',
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

                Container(
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
                  child: Text(
                    ' 2. 사용자 보호자 정보',
                    style: GoogleFonts.lato(
                      color: Colors.white54,
                      fontSize: 20,
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                  child: TextFormField(
                    controller: _protector_name,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return '보호자 이름을 입력해주세요';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: '보호자 이름',
                      hintText: '보호자 이름을 입력해주세요.',
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


                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 16),
                  child: TextFormField(
                    controller: _protector_name,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return '보호자 번호를 입력해주세요';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: '보호자 번호',
                      hintText: '보호자 번호를 입력해주세요.',
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

                            //_addEvent(Event(DateTime.now(), '2', '3', '4', '5'));

                            if(_formKey.currentState!.validate()){
                              Navigator.pop(context, '이전 화면');
                            }
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
