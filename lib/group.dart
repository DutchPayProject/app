import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DutchGroup extends StatelessWidget{

  var Group_tittle = [
    "김밥천국",
    "라라코스트",
    "정성순대",
    "조방낙지",
    "돈아이가"
  ];






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
                        Text("모임("+(Group_tittle.length).toString()+"개)",style: TextStyle(color: Color(0xff22844c),fontFamily: 'Jua',fontSize: 40),),
                        Text("※모임을 선택하세요", style: TextStyle(color: Color(0xff22844c),fontFamily: 'Jua',fontSize: 15)),
                        Divider(thickness: 1,color: Colors.blueGrey,)
                      ],
                    ),
                  ),
                ),
                Expanded(child: ListView.builder(
                    itemCount : Group_tittle.length,
                    itemBuilder: (context, index){
                      return Container(
                          width: 400,
                          height: 80,
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border(
                      left: BorderSide(color: Color(0xff22844c),width: 3),
                      right: BorderSide(color: Color(0xff22844c),width: 3),
                      top: BorderSide(color: Color(0xff22844c),width: 3),
                      bottom: BorderSide(color: Color(0xff22844c),width: 3),
                      ),
                      ),
                        child: ListView(
                          children: [
                            Text(Group_tittle[index], style: TextStyle(color: Color(0xff22844c), fontFamily: 'Jua', fontSize: 25,),textAlign: TextAlign.start,),
                            Icon(Icons.people),
                          ],
                        ),
                      );
                    }))
              ],
            ),
        )
      );
  }
}