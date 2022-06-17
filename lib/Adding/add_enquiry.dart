import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turnhouse/Item_data.dart';

class add_Enquiry extends StatefulWidget {
  const add_Enquiry({Key? key}) : super(key: key);

  @override
  _add_EnquiryWidgetState createState() => _add_EnquiryWidgetState();
}

class _add_EnquiryWidgetState extends State<add_Enquiry> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  //카테고리 드롭 버튼 설정
  final _valueList = ['문의 종류를 선택하세요.', '질문', '고장', '계정 관리','단말기 관리', '기타'];
  var _selectedValue = '문의 종류를 선택하세요.';

  var _title = TextEditingController();
  var _writer = TextEditingController();
  var _content = TextEditingController();

  @override
  void dispose(){
    _title.dispose();
    _writer.dispose();
    _content.dispose();
    super.dispose();
  }

  Widget _buildItemWidget(Event event){
    return ListTile(
      onTap: () {},
      leading: Text(
          ""
      ),
      title: Text(
          '[ ' + ' ] ' + event.title
      ),
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.white24,
            width: 0.5,
          )
      ),
      subtitle: Text(
          '여긴 부제'
      ),
      trailing: TextButton(
        onPressed: () {
          print('수정 버튼 pressed ...');

        },
        child: Text('수정'),
      ),

    );

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
                        '기타 문의',
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
                    controller: _writer,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return '작성자 정보를 입력해주세요';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: '작성자',
                      hintText: '작성자 정보를 입력해주세요.',
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
                      fontSize: 20,
                    ),
                  ),
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
