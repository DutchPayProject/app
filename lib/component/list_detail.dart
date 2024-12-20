import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ListDetailPage extends StatefulWidget {
  final int groupid;
  final String groupName;

  ListDetailPage({
    required this.groupid,
    required this.groupName,
  });

  @override
  _ListDetailPageState createState() => _ListDetailPageState();
}

class _ListDetailPageState extends State<ListDetailPage> {
  List<Map<String, dynamic>> groupList = [];
  List<Map<String, dynamic>> listList = [];

  // API call to fetch group details
  Future<void> grouppostList() async {
    final url = Uri.parse('http://localhost:8082/Details/get');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'group_id': widget.groupid,
        }),
      );
      if (response.statusCode == 200) {
        final res = json.decode(response.body);
        setState(() {
          groupList = List<Map<String, dynamic>>.from(res);
        });
        print('서버 응답: $res');
      } else {
        print('서버오류 : ${response.statusCode}');
      }
    } catch (e) {
      print('Post 요청 실패 : $e');
    }
  }

  Future<void> memberList() async {
    final url = Uri.parse('http://localhost:8082/member/listget');

    try {

      if (groupList.isNotEmpty) {
        final listId = groupList[0]['list_id'];

        final response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'member_id': listId,
          }),
        );

        if (response.statusCode == 200) {
          final res = json.decode(response.body);
          setState(() {
            listList = List<Map<String, dynamic>>.from(res);
          });
          print('서버 응답: $res');
        } else {
          print('서버 오류 : ${response.statusCode}');
        }
      } else {
        print('memberList가 비어 있습니다.');
      }
    } catch (e) {
      print('Post 요청 실패 : $e');
    }
  }

  @override
  void initState() {
    super.initState();
    grouppostList();
    memberList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
               "${widget.groupName}",
              style: TextStyle(
                color: Color(0xff22844c),
                fontFamily: 'Jua',
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: groupList.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: groupList.length,
          itemBuilder: (context, index) {
            final groupItem = groupList[index];
            final listItem = listList[index];

            return Container(
              width: 400,
              height: 80,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Color(0xff22844c),
                  width: 3,
                ),
              ),
              child: ListView(
                children: [
                  Text(
                    groupItem['title'] ,
                    style: TextStyle(
                      color: Color(0xff22844c),
                      fontFamily: 'Jua',
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    listItem['title'] ,
                    style: TextStyle(
                      color: Color(0xff22844c),
                      fontFamily: 'Jua',
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
