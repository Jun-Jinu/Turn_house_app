import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turnhouse/Item_data.dart';
import 'package:turnhouse/Adding/add_terminal.dart';
import 'package:turnhouse/Adding/add_enquiry.dart';

class Custemer_centerWidget extends StatefulWidget {
  const Custemer_centerWidget({Key? key}) : super(key: key);

  @override
  _Custemer_centerWidgetState createState() => _Custemer_centerWidgetState();
}

class _Custemer_centerWidgetState extends State<Custemer_centerWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final _Customer_Service = <Customer_Service>[];

  void _addCustomer_Service(Customer_Service customer_Service){
    setState(() {
      _Customer_Service.add(customer_Service);

      customer_Service.date = DateTime.now();
      customer_Service.title = '단말기가 고장났어요!';
      customer_Service.sender = '전진우';
      customer_Service.category = '고장';
      customer_Service.content = '아침에 일어났더니 단말기가 켜지지 않아요!';
      customer_Service.answer_check = false;

    });
  }

  void _addCustomer_Service2(Customer_Service customer_Service){
    setState(() {
      _Customer_Service.add(customer_Service);

      customer_Service.date = DateTime.now();
      customer_Service.title = '방송기능 사용 방법';
      customer_Service.sender = '김성욱';
      customer_Service.category = '질문';
      customer_Service.content = '방송은 어떻게 하나요?';
      customer_Service.answer_check = false;

    });
  }

  void _deleteCustomer_Service(Customer_Service customer_Service){
    setState(() {
      _Customer_Service.remove(customer_Service);
    });
  }
  Widget _buildItemWidget(Customer_Service customer_Service){

    String a_check;
    return ListTile(
      onTap: () {
        showDialog(
            context: context,
            //barrierDismissible: false,
            builder: (BuildContext context){
              return AlertDialog(
                backgroundColor: Color(0xFF252735),
                title: Text(
                  customer_Service.date.month.toString() + '/' + customer_Service.date.day.toString() +
                      ' - ' +'[ ' + customer_Service.category + ' ] ' + customer_Service.title,
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text(
                        ' •  송신자: ' + customer_Service.sender + '\n\n'
                        + ' •  답변 유무: ' +  (customer_Service.answer_check == false ? '미답변' : '답변') + '\n\n',
                        style: GoogleFonts.lato(
                          color: Colors.white70,
                          fontSize: 24,
                        ),
                      ),

                      Text(
                        ' •  문의 내용: ' + customer_Service.content,
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
                    child: const Text('확인'),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            }
        );
      },
      leading: Text(
          customer_Service.date.month.toString() + '/' + customer_Service.date.day.toString()
      ),
      title: Text(
          '[ ' + customer_Service.category + ' ] ' + customer_Service.title
      ),
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.white24,
            width: 0.5,
          )
      ),
      subtitle: Text(
          customer_Service.answer_check == false ? '미답변' : '답변',

        style: GoogleFonts.lato(
          color: Colors.white38,
        ),
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
                        Text('선택한 문의 기록을 삭제합니다.'),
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
                        _deleteCustomer_Service(customer_Service);
                        Navigator.of(context).pop();
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
    );

  }
  @override
  Widget build(BuildContext context) {
    _addCustomer_Service(Customer_Service(DateTime.now(), '2', '3', '4', '5', false));
    _addCustomer_Service2(Customer_Service(DateTime.now(), '2', '3', '4', '5', false));
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
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(40, 10, 10, 10),
                    child: Text(
                      '고 객 센 터',
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  children: _Customer_Service.map((customer_Service) => _buildItemWidget(customer_Service)).toList(),
                ),
              ),



              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),

                      child:Container(
                        width: 350,
                        height: 80,
                        child:ElevatedButton(
                          onPressed: () {
                            print('단말기 추가 요청 버튼 pressed ...');

                            //_addEvent(Event(DateTime.now(), '2', '3'));
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => add_Terminal()),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color(0xFF4391F1)),
                            //textStyle: GoogleFonts.lato(color: Colors.white),
                          ),
                          child: Text(
                            '단말기 추가 요청',
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
                            print('기타 문의 버튼 pressed ...');

                            //_addEvent(Event(DateTime.now(), '2', '3'));
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => add_Enquiry()),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color(0xFF4391F1)),
                            //textStyle: GoogleFonts.lato(color: Colors.white),
                          ),
                          child: Text(
                            '기타 문의',
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
          ),
        ),
      ),
    );
  }
}
