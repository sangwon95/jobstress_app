import 'package:flutter/material.dart';
import 'package:jobstress_app/data/result.dart';
import 'package:jobstress_app/utils/color.dart';

import '../data/answer.dart';
import '../data/calculated.dart';

class ResultPage extends StatefulWidget {

  final Calculated calculated;
  ResultPage(this.calculated);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  final result = Result();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('직무스트레스 상담 결과',style: TextStyle(color: Colors.white, fontSize: 16)),
        backgroundColor: mainColor,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FittedBox(child: Text(result.headText, style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal),)),
                  SizedBox(height: 10),
                  Text('${widget.calculated.group} 에 해당하는 ${widget.calculated.color} 군', style: TextStyle(color: widget.calculated.colorHex,fontSize: 23,fontWeight: FontWeight.bold),),
                  SizedBox(height: 25),
                  Card(
                    color: widget.calculated.colorHex,
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                    child: FittedBox(
                      child: Container(
                        height: 40,
                        child: Center(child: Text('   ${widget.calculated.comment}  ', style: TextStyle(color:Colors.white, fontSize: 12))),
                      ),

                    ),
                  ),
                ],
              ),
            ),




            Expanded(
                flex:6,
                child: Image.asset(widget.calculated.imagePath, height: 200, width: 200)),
            SizedBox(height: 35),

            Card(
              color: Colors.white,
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  width: MediaQuery.of(context).size.width - 20,
                  height: 130,
                  child: Center(child: Text(result.bottomContent, textScaleFactor: 0.9, style: TextStyle(color:Colors.black))),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }


}
