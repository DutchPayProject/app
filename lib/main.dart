import 'package:flutter/material.dart';

void main() {
  runApp(const DutchMain());
}

class DutchMain extends StatelessWidget {
  const DutchMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GestureDetector(
        onTap: (){
        },
        child: Scaffold(
          body: Center(
            child: Container(
              height: 450,
              width: 350,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset('Doller.png', height: 300, width: 200,),
                  Text('Dutch Pay', style: TextStyle(color: Color(0xff22844c), fontSize: 40,fontFamily:'Jua'),),
                  Text('# 더치페이의 선택 1등 앱', style: TextStyle(color: Color(0xff22844c), fontSize: 30,fontFamily:'Jua'),),
                  Text('화면을 터치해주세요', style: TextStyle(color: Color(0xff22844c), fontSize: 30, fontFamily:'Jua'),)
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}



