import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:scaleapplication/Page/newrecipe_colorlist.dart';

import 'existing_client.dart';
// import 'package:intl/intl.dart';


class NewRecipeBowl extends StatefulWidget {
  const NewRecipeBowl({Key? key}) : super(key: key);
  @override
  _NewRecipeBowlState createState() => _NewRecipeBowlState();
}


class _NewRecipeBowlState extends State<NewRecipeBowl> with TickerProviderStateMixin{
  late AnimationController controller;

  bool isPlaying = false;
  String get countText {
    Duration count = controller.duration! * controller.value;
    return controller.isDismissed
        ? '${controller.duration!.inHours}:${(controller.duration!.inMinutes % 60).toString().padLeft(2, '0')}:${(controller.duration!.inSeconds % 60).toString().padLeft(2, '0')}'
        : '${count.inHours}:${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }
  double progress = 1.0;

  bool isButtonActive = false;

  void notify() {
    if (countText == '0:00:00') {
      FlutterRingtonePlayer.playNotification();
      isButtonActive = true;
    }
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );

    controller.reverse(
        from: controller.value == 0 ? 1.0 : controller.value);
    setState(() {
      isPlaying = true;

      controller.addListener(() {
        notify();
        if (controller.isAnimating) {
          setState(() {
            progress = controller.value;
          });
        } else {
          setState(() {
            progress = 1.0;
            isPlaying = false;
          });
        }
      });
    });
  }
  var now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    DateTime now = new DateTime.now();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Put The Bowl'),
      ),
      body: Container(
        // child: Form(
        // key: _formkey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const <Widget>[
                  SizedBox(height: 50),
                  Text("4:00 pm",
                      style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        // color: Color(0xFFf07590),
                          fontSize: 23
                      ),
                      textAlign: TextAlign.right),
                  SizedBox(width: 10),
                  IconButton(
                    iconSize: 50.0,
                    icon: Icon(Icons.settings),
                    tooltip: 'Settings',
                    onPressed: null,
                  ),
                  SizedBox(width: 30),
                ],
              ),
              // const SizedBox(height: 20.0),
              Container(
                margin: const EdgeInsets.fromLTRB(150.0, 20.0, 150.0, 0.0),
                padding: const EdgeInsets.all(10.0),
                decoration: myBoxDecoration(),
                alignment: Alignment.center,
                // padding: const EdgeInsets.symmetric(horizontal: 40),
                child: const Text(
                  "Put The Bowl in to Scale",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      // color: Color(0xFFf07590),
                      fontSize: 35
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
              Container(
                // decoration: BoxDecoration(
                //     color: Colors.black12,
                //     border: Border.all(width: 1.0)
                // ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 250,
                      height: 250,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.grey.shade300,
                        value: progress,
                        strokeWidth: 6,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // if (controller.isDismissed) {
                        //   showModalBottomSheet(
                        //     context: context,
                        //     builder: (context) => Container(
                        //       height: 300,
                        //       child: CupertinoTimerPicker(
                        //         initialTimerDuration: controller.duration!,
                        //         onTimerDurationChanged: (time) {
                        //           setState(() {
                        //             controller.duration = time;
                        //           });
                        //         },
                        //       ),
                        //     ),
                        //   );
                        // }
                      },
                      child: AnimatedBuilder(
                        animation: controller,
                        builder: (context, child) => Text(
                          countText,
                          style: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15.0),
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: TextButton(
                  child: const Text('Continue', style: TextStyle(fontSize: 20.0),),
                  // color: Colors.blueAccent,
                  // textColor: Colors.white,
                  onPressed: isButtonActive ? () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  const NewScanColor()));
                  }:null,
                ),
              )
            ],
          ),
        ),
      ),
      // ),
    );
  }}

BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    border: Border.all(
        width: 3.0
    ),
    borderRadius: BorderRadius.all(
        Radius.circular(5.0) //                 <--- border radius here
    ),
  );
}

