import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:scaleapplication/Page/newrecipe.dart';
import 'package:scaleapplication/Page/previousrecipe.dart';
import 'package:scaleapplication/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';


class listColor extends StatefulWidget {
  const listColor({Key? key}) : super(key: key);
  @override
  _listColorState createState() => _listColorState();
}


class _listColorState extends State<listColor> {
  SharedPreferences? loginData;
  SharedPreferences? clientData;
  String?  email, name;
  String? clientName, clientTime, clientId, style;
  List<String> recipes =[];

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async{
    loginData = await SharedPreferences.getInstance();
    clientData = await SharedPreferences.getInstance();
    setState(() {
      email = loginData!.getString('email');
      name = loginData!.getString('name');
      clientId = clientData!.getString('clientId');
      clientName = clientData!.getString('clientName');
      clientTime = clientData!.getString('clientTime');
      style = clientData!.getString('style');
      recipes = clientData!.getStringList('my_recipe') ?? [];
      print(clientName);
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // fetchClients();
      for(int i = 0; i<recipes.length; i++){
        print("This is the: ${recipes[i]}");
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Previous Recipe'),
      ),
      body: Container(
        // child: Form(
        // key: _formkey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(height: 50),
                  Text('Appointment: $clientTime',
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
              const SizedBox(height: 10.0),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "Style: $style",
                  style: clientNameStyle,
                  textAlign: TextAlign.left,
                ),
              ),
//               Container(
//                 // width: size.width,
//                 // margin: EdgeInsets.symmetric(horizontal: size.width * 0.035),
//                 child: Row(
//                   children: [
//                     SizedBox(width: 40),
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (context) =>  const PreviousRecipe()));
//                         },
//                         // textColor: Colors.white,
//                         // padding: const EdgeInsets.all(0),
//                         child: Container(
//                           alignment: Alignment.center,
//                           height: 100.0,
//                           decoration: const BoxDecoration(
//                             // borderRadius: BorderRadius.circular(80.0),
//                               gradient:  LinearGradient(
//                                   colors: [
// //                              Color.fromARGB(255, 255, 136, 34),
// //                              Color.fromARGB(255, 255, 177, 41)
// //                              Color(0xFFff0066),
// //                              Color(0xFFff99cc)
// //                                 Color(0xffEF716B),
// //                                 Color(0xffff9999),
//                                     Colors.cyan,
//                                     Colors.indigo,
//                                   ]
//                               )
//                           ),
//                           padding: const EdgeInsets.all(0),
//                           child: const Text(
//                             "Scan",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               // fontWeight: FontWeight.bold,
//                               fontSize: 40.0,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const Expanded(
//                       child: Text('Or',
//                           style: TextStyle(
//                             // fontWeight: FontWeight.bold,
//                             // color: Color(0xFFf07590),
//                               fontSize: 35
//                           ),
//                           textAlign: TextAlign.center
//                       ),
//                     ),
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (context) =>  const NewRecipe()));
//                         },
//                         // textColor: Colors.white,
//                         // padding: const EdgeInsets.all(0),
//                         child: Container(
//                           alignment: Alignment.center,
//                           height: 100.0,
//                           decoration: const BoxDecoration(
//                             // borderRadius: BorderRadius.circular(80.0),
//                               gradient:  LinearGradient(
//                                   colors: [
// //                              Color.fromARGB(255, 255, 136, 34),
// //                              Color.fromARGB(255, 255, 177, 41)
// //                              Color(0xFFff0066),
// //                              Color(0xFFff99cc)
// //                                 Color(0xffEF716B),
// //                                 Color(0xffff9999),
//                                     Colors.cyan,
//                                     Colors.indigo,
//                                   ]
//                               )
//                           ),
//                           padding: const EdgeInsets.all(0),
//                           child: const Text(
//                             "Select Color",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               // fontWeight: FontWeight.bold,
//                               fontSize: 40.0,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 40),
//                   ],
//                 ),
//               ),
              const SizedBox(height: 20.0),
              Container(
                // padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Card(
                      elevation: 4,
                      child: Column(
                        children: [
                          Scrollbar(
                            child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: recipes.length,
                                separatorBuilder: (_ , __ ) => Divider(height: 0.6,
                                  color: Colors.black87,),
                                itemBuilder: (context, index) {
                                  // for(int i = 0; i<clients.length; i++){
                                  //
                                  // }

                                  final color = recipes[index];
                                  // final date = recipes[index][1];
                                  return ListTile(
                                    onTap: () {
                                      // for(int i = 2; i < clients[index].length; i++){
                                      //   String rec = clients[index][i];
                                      //   // clientData?.setStringList('my_recipe', [rec]);
                                      //   print("Recipe: $i ${clients[index][i]}");
                                      // }
                                      print(color);
                                      // print(hairStyle);
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => const listColor()));
                                    },
                                    title: Text("Color: $color",
                                      style: TextStyle(fontSize: 20.0),
                                    textAlign: TextAlign.center,),
                                    // title: Text("Style: $hairStyle",
                                    //   style: TextStyle(fontSize: 20.0),
                                    //   textAlign: TextAlign.center,),
                                    // trailing: Text("asd",
                                    //   style: TextStyle(fontSize: 20.0),
                                    //   textAlign: TextAlign.center,),
                                  );
                                }
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
              const SizedBox(height: 35.0),
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: ElevatedButton(
                  child: const Text('Continue', style: TextStyle(fontSize: 25.0),),
                  // color: Colors.blueAccent,
                  // textColor: Colors.white,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  const NewRecipe()));
                  },
                ),
              )

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
            ],
          ),
        ),
      ),
      // ),
    );
  }}


