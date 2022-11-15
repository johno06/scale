import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:scaleapplication/Page/new_client.dart';
import 'package:scaleapplication/main.dart';
import 'package:scaleapplication/models/color_model.dart';
import 'package:scaleapplication/models/getData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../constant.dart';
import '../models/client.dart';
import 'existing_client.dart';


class SelectColor extends StatefulWidget {
  const SelectColor({Key? key}) : super(key: key);
  @override
  _SelectColorState createState() => _SelectColorState();
}





class _SelectColorState extends State<SelectColor> {
  int? H;
  int? h;
  int? m;
  int? s;

  SharedPreferences? loginData;
  SharedPreferences? clientData;

  ClientFetch clientVal = ClientFetch(time: '', name: '', id: '');
  String? clientName, clientTime;


  String?  email, name, security_key, id;
  int i = 0;

  @override
  void initState() {
    super.initState();
    initial();
    H = DateTime
        .now()
        .hour;
    h = (DateTime
        .now()
        .hour > 12) ? DateTime
        .now()
        .hour - 12 : (DateTime
        .now()
        .hour == 0) ? 12 : DateTime
        .now()
        .hour;
    m = DateTime
        .now()
        .minute;
    s = DateTime
        .now()
        .second;
    Timer.periodic(const Duration(seconds: 1), (Timer t) => getTime());

  }


  void initial() async{
    loginData = await SharedPreferences.getInstance();
    setState(() {
      email = loginData!.getString('email');
      name = loginData!.getString('name');
      security_key = loginData!.getString('security_key');
      id = loginData!.getString('_id');
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

    });
  }


  getTime() {
    if (mounted) {
      setState(() {
        H = DateTime
            .now()
            .hour;
        h = (DateTime
            .now()
            .hour > 12) ? DateTime
            .now()
            .hour - 12 : (DateTime
            .now()
            .hour == 0) ? 12 : DateTime
            .now()
            .hour;
        m = DateTime
            .now()
            .minute;
        s = DateTime
            .now()
            .second;
      });
    }
  }


  var now = DateTime.now();
  List<CheckBoxListTileModel> checkBoxListTileModel =
  CheckBoxListTileModel.getColors();

  // List<dynamic> clients = [];

  List<dynamic> colors = [
    ['Pfizer', 'Color', '2', 'Red'],
    ['Mic', 'Color', '1', 'Black'],
    ['Style', 'Color', '3', 'Yellow'],
    ['Pre', 'Color', '2', 'Green'],
    ['Prep', 'Color', '4', 'Blue'],
    ['Cologne', 'Color', '1', 'Purple'],
    ['Stay', 'Color', '3', 'Gray'],
    ['Pfizer', 'Color', '1', 'Light Red'],
  ];

  List<dynamic> selectedColors = [
  ];

bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Dashboard'),
      //   automaticallyImplyLeading: false,
      // ),
      appBar: AppBar(
        title: Text("Select Color"),
        // automaticallyImplyLeading: false,
      ),
      body:
      SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  const SizedBox(height: 50),
                  //with seconds ${(h!<10)?"$h":h}:${(m!<10)?"0$m":m}:${(s!<10)?"0$s":s}
                  Text('${(h!<10)?"$h":h}:${(m!<10)?"0$m":m} '+((H!>12)?"pm":"am"),
                      style: const TextStyle(
                        // fontWeight: FontWeight.bold,
                        // color: Color(0xFFf07590),
                          fontSize: 24
                      ),
                      textAlign: TextAlign.right),
                  const SizedBox(width: 10),
                  const IconButton(
                    iconSize: 50.0,
                    icon: Icon(Icons.search),
                    tooltip: 'Search',
                    onPressed: null,
                  ),
                  const IconButton(
                    iconSize: 50.0,
                    icon: Icon(Icons.settings),
                    tooltip: 'Settings',
                    onPressed: null,
                  ),
                  const SizedBox(width: 30),
                ],
              ),
              // const SizedBox(height: 20.0),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Colors',
                  style: stylistNameStyle,
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 20.0),

              // Container(
              //   alignment: Alignment.centerRight,
              //   padding: const EdgeInsets.symmetric(horizontal: 50),
              //   child: ElevatedButton(
              //     child: const Text(
              //       'See All', style: TextStyle(fontSize: 20.0),),
              //     // color: Colors.blueAccent,
              //     // textColor: Colors.white,
              //     onPressed: () {
              //       // fetchClients();
              //     },
              //   ),
              // ),
              // SizedBox(height: size.height * 0.03),

              // SizedBox(height: size.height * 0.03),

              // const SizedBox(height: 30.0),

//               Container(
//                 alignment: Alignment.centerRight,
//                 margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
//                 child: RaisedButton(
//                   onPressed: () {
//                   },
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(80.0)),
//                   textColor: Colors.white,
//                   padding: const EdgeInsets.all(0),
//                   child: Container(
//                     alignment: Alignment.center,
//                     height: 200.0,
//                     decoration: const BoxDecoration(
//                       // borderRadius: BorderRadius.circular(80.0),
//                         gradient:  LinearGradient(
//                             colors: [
// //                              Color.fromARGB(255, 255, 136, 34),
// //                              Color.fromARGB(255, 255, 177, 41)
// //                              Color(0xFFff0066),
// //                              Color(0xFFff99cc)
// //                                 Color(0xffEF716B),
// //                                 Color(0xffff9999),
//                               Colors.cyan,
//                               Colors.indigo,
//                             ]
//                         )
//                     ),
//                     padding: const EdgeInsets.all(0),
//                     child: const Text(
//                       "Create a New Recipe",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         // fontWeight: FontWeight.bold,
//                         fontSize: 50.0,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20.0),
//               Container(
//                 alignment: Alignment.centerRight,
//                 margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
//                 child: RaisedButton(
//                   onPressed: () {
//                   },
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(80.0)),
//                   textColor: Colors.white,
//                   padding: const EdgeInsets.all(0),
//                   child: Container(
//                     alignment: Alignment.center,
//                     height: 200.0,
//                     decoration: const BoxDecoration(
//                       // borderRadius: BorderRadius.circular(80.0),
//                         gradient:  LinearGradient(
//                             colors: [
// //                              Color.fromARGB(255, 255, 136, 34),
// //                              Color.fromARGB(255, 255, 177, 41)
// //                              Color(0xFFff0066),
// //                              Color(0xFFff99cc)
//                               Color(0xffEF716B),
//                               Color(0xffff9999),
//                             ]
//                         )
//                     ),
//                     padding: const EdgeInsets.all(0),
//                     child: const Text(
//                       "Manage Recipes",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         // fontWeight: FontWeight.bold,
//                         fontSize: 50.0,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),

              // Row(
              //     children: <Widget>[
              //       const SizedBox(width: 70,),
              //       Expanded(child: Text("Manufacturer",
              //       style: clientNameStyle,)),
              //       const SizedBox(width: 130,),
              //       Expanded(child: Text("Product",
              //         style: clientNameStyle,)),
              //       const SizedBox(width: 100,),
              //       Expanded(child: Text("Color",
              //         style: clientNameStyle,)),
              //     ]
              // ),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Card(
                  // child:

                  // FutureBuilder(
                  //   future: getClientsDatas(),
                  //   builder: (context, AsyncSnapshot snapshot){
                  //     if(snapshot.data == null){
                  //       return Container(
                  //         child: Center(
                  //           child: Text('Loading'),
                  //         ),
                  //       );
                  //     }
                  //     else{
                  //       // var data = (snapshot.data as List<Client>).toList();
                  //       return ListView.builder(
                  //         itemCount: snapshot.data!.length,
                  //         itemBuilder: (context, i){
                  //             return ListTile(
                  //               title: Text(snapshot.data[i]!.name),
                  //             );
                  //         },
                  //       );
                  //     }
                  //   },
                  // ),
                  //   ),
                  // ),
                  // decoration: BoxDecoration(
                  //   color: Colors.black12,
                  //   border: Border.all(width: 2.0)
                  // ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Card(
                      elevation: 4,
                      child: Column(
                        children: [
                          Scrollbar(
                            child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: checkBoxListTileModel.length,
                                separatorBuilder: (_ , __ ) => Divider(height: 0.6,
                                  color: Colors.black87,),
                                itemBuilder: (context, index) {
                                  final color = colors[index];
                                  final manufacturer = color[0];
                                  final product = color[1];
                                  final level = color[2];
                                  final colorStyle = color[3];
                                  return CheckboxListTile(
                                      // onTap: () {
                                      //   selectedColors.add(['$manufacturer','$product','$level','$colorStyle']);
                                      //   print(selectedColors);
                                      // },
                                      // leading: Text(
                                      //   manufacturer,
                                      //   style: TextStyle(fontSize: 20.0),
                                      // ),
                                      title: Text(
                                        // checkBoxListTileModel[index].title,
                                        "Manufacturer: $manufacturer",
                                        style: TextStyle(fontSize: 20.0),
                                        // textAlign: TextAlign.center,
                                      ),
                                      subtitle: Text(
                                        // checkBoxListTileModel[index].subtitle,
                                        "Level: $level   Color: $colorStyle",
                                        style: TextStyle(fontSize: 20.0),
                                        textAlign: TextAlign.center,
                                      ), value: checkBoxListTileModel[index].isCheck,
                                    onChanged: (bool? value) {
                                        setState(() {
                                          itemChange(value!, index);
                                          if(value == true) {
                                            // print(checkBoxListTileModel[index]
                                            //     .subtitle);
                                            selectedColors.add([manufacturer, product, level, colorStyle]);
                                            print(selectedColors);
                                            // print(colorStyle);
                                          }
                                          if(value == false){
                                            selectedColors.removeAt(index);
                                            selectedColors.removeWhere((str){
                                              return str == colorStyle;
                                            });
                                          }
                                        });
                                  },
                                      // trailing: Text(
                                      //   colorStyle,
                                      //   style: TextStyle(fontSize: 20.0),
                                      // ),
                                    );
                                  }
                                // }
                            ),
                          ),
                          //row for each deatails
                          // ListTile(
                          //   onTap: () {
                          //     Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (context) => const NewClient()));
                          //   },
                          //   leading: const Text("4:00 pm",
                          //       style: TextStyle(fontSize: 20.0)),
                          //   title: const Text("John Doe",
                          //     style: TextStyle(fontSize: 20.0),
                          //     textAlign: TextAlign.center,),
                          //   trailing: const Text("New Client",
                          //     style: TextStyle(fontSize: 20.0),
                          //     textAlign: TextAlign.center,),
                          // ),
                          // const Divider(
                          //   height: 0.6,
                          //   color: Colors.black87,
                          // ),
                          // ListTile(
                          //   onTap: () {
                          //     Navigator.push(
                          //         context,
                          //         MaterialPageRoute(builder: (
                          //             context) => const ExistingClient()));
                          //   },
                          //   leading: const Text("5:00 pm",
                          //       style: TextStyle(fontSize: 20.0)),
                          //   title: const Text("Sarah G",
                          //     style: TextStyle(fontSize: 20.0),
                          //     textAlign: TextAlign.center,),
                          //   trailing: const Text("Existing Client",
                          //     style: TextStyle(fontSize: 20.0),
                          //     textAlign: TextAlign.center,),
                          // ),
                          // const Divider(
                          //   height: 0.6,
                          //   color: Colors.black87,
                          // ),
                          // ListTile(
                          //   onTap: () {
                          //     Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (context) => const NewClient()));
                          //   },
                          //   leading: const Text("6:00 pm",
                          //       style: TextStyle(fontSize: 20.0)),
                          //   title: const Text("Karen Davile",
                          //     style: TextStyle(fontSize: 20.0),
                          //     textAlign: TextAlign.center,),
                          //   trailing: const Text("New Client",
                          //     style: TextStyle(fontSize: 20.0),
                          //     textAlign: TextAlign.center,),
                          // ),
                          // const Divider(
                          //   height: 0.6,
                          //   color: Colors.black87,
                          // ),
                          // ListTile(
                          //   onTap: () {
                          //     Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (context) => const NewClient()));
                          //   },
                          //   leading: const Text("7:00 pm",
                          //       style: TextStyle(fontSize: 20.0)),
                          //   title: const Text("Davile",
                          //     style: TextStyle(fontSize: 20.0),
                          //     textAlign: TextAlign.center,),
                          //   trailing: const Text("New Client",
                          //     style: TextStyle(fontSize: 20.0),
                          //     textAlign: TextAlign.center,),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: ElevatedButton(
                  child: const Text('Continue', style: TextStyle(fontSize: 25.0),),
                  // color: Colors.blueAccent,
                  // textColor: Colors.white,
                  onPressed: () {
                    // for(int i =0; i<selectedColors.length; i++){
                      print(selectedColors[i]);
                    // }

                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(builder: (context) =>  const NewRecipe()));
                  },
                ),
              )
            ]),

        // ],
      ),
    );
    // ),
    // );
  }

  void itemChange(bool val, int index) {
    setState(() {
      checkBoxListTileModel[index].isCheck = val;
    });
  }
}

class Client {
  final String name, time, stylist_id, verified;
  var id;
  // final Array previous_recipe;
  // late bool status;
  // Client(this.id, this.name, this.time, this.stylist_id, this.verified);
  Client({
    required this.id,
    required this.name,
    required this.time,
    required this.stylist_id,
    required this.verified
  });
}





