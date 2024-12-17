import 'dart:convert';
import 'package:dutch_pay/component/list_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
class DutchGroup extends StatefulWidget{

  @override
  _GroupPageState createState()=> _GroupPageState();
  }

  class _GroupPageState extends State<DutchGroup> {
    List<int> group_id = [];
    List<String> group_name = [];
    List<DateTime> create_date = [];
    List<Map<dynamic, dynamic>> object = [];


    Future<void> fetchGroups() async {
      final url = Uri.parse('http://localhost:8082/Group/getGroup');
      try {
        final response = await http.get(url);
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          print(responseData);
          setState(() {
            if (responseData['data'] != null) {
              object = List<Map<String, dynamic>>.from(responseData['data']);
              group_name =
                  object.map((item) => item['group_name'] as String).toList();
              group_id = object.map((id) => id['group_id'] as int).toList();
              create_date = object.map((date) => DateTime.parse(date['create_date'] as String)).toList();
            } else {
              print('데이터가 없습니다.');
            }
            print(object);
          });
        } else {
          print('서버 오류: ${response.statusCode}');
        }
      } catch (e) {
        print('데이터 가져오기 실패: $e');
      }
    }
    @override
    void initState() {
      super.initState();
      fetchGroups();
    }


    @override
    Widget build(BuildContext context) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: Column(
              children: [
                Container(
                  width: 450,
                  height: 150,
                  margin: EdgeInsets.all(20),
                  child: Center(
                    child: Column(
                      children: [
                        Text("모임(" + (group_name.length).toString() + "개)",
                          style: TextStyle(color: Color(0xff22844c),
                              fontFamily: 'Jua',
                              fontSize: 40),),
                        Text("※모임을 선택하세요", style: TextStyle(
                            color: Color(0xff22844c),
                            fontFamily: 'Jua',
                            fontSize: 15)),
                        Divider(thickness: 1, color: Colors.blueGrey,)
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: group_name.length,
                    itemBuilder: (context, index) {
                      final formattedDate = DateFormat('yyyy-MM-dd').format(create_date[index]);

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ListDetailPage(
                                groupid: group_id[index],
                                groupName: group_name[index],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: 400,
                          height: 80,
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border(
                              left: BorderSide(color: Color(0xff22844c), width: 3),
                              right: BorderSide(color: Color(0xff22844c), width: 3),
                              top: BorderSide(color: Color(0xff22844c), width: 3),
                              bottom: BorderSide(color: Color(0xff22844c), width: 3),
                            ),
                          ),
                          child: ListView(
                            children: [
                              Text(
                                group_name[index],
                                style: TextStyle(color: Color(0xff22844c), fontFamily: 'Jua', fontSize: 25),
                                textAlign: TextAlign.start,
                              ),
                              Text(
                                formattedDate,
                                style: TextStyle(fontFamily: 'Jua', fontSize: 15),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          )
      );
    }
  }

