import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:scaleapplication/Page/new_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../constant.dart';
import 'existing_client.dart';
import 'previousrecipe_colorlist.dart';
// import 'package:intl/intl.dart';


class PreviousRecipe extends StatefulWidget {
  const PreviousRecipe({Key? key}) : super(key: key);
  @override
  _PreviousRecipeState createState() => _PreviousRecipeState();
}


class _PreviousRecipeState extends State<PreviousRecipe> {

  SharedPreferences? loginData;
  SharedPreferences? clientData;
  String?  email, name;
  String? clientName, clientTime, clientId;

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
      print(clientName);
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetchClients();
    });
  }


  List<dynamic> clients = [];

  void fetchClients() async {
    String url = 'https://scaleapplication.herokuapp.com/getByIdClient/$clientId';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);

    clientData = await SharedPreferences.getInstance();

    print(clientId);
    setState(() {
      clients = json['previous_recipe'];
      print(clients);
    });
    print('fetchclients completed');
  }


  var now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    DateTime now = new DateTime.now();
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
                children:  <Widget>[
                  SizedBox(height: 50),
                  Text("$clientTime",
                      style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        // color: Color(0xFFf07590),
                          fontSize: 23
                      ),
                      textAlign: TextAlign.right),
                  SizedBox(width: 10),
                  IconButton(
                    iconSize: 50.0,
                    icon: Icon(Icons.search),
                    tooltip: 'Search',
                    onPressed: null,
                  ),
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
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "Stylist: $name",
                  style: stylistNameStyle,
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  "Client: $clientName",
                  style: clientNameStyle,
                  textAlign: TextAlign.left,
                ),
              ),

              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: ElevatedButton(
                  child: const Text('See All', style: TextStyle(fontSize: 20.0),),
                  // color: Colors.blueAccent,
                  // textColor: Colors.white,
                  onPressed: () {},
                ),
              ),
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
                                itemCount: clients.length,
                                separatorBuilder: (_ , __ ) => Divider(height: 0.6,
                                  color: Colors.black87,),
                                itemBuilder: (context, index) {
                                  // for(int i = 0; i<clients.length; i++){
                                  //
                                  // }

                                  final hairStyle = clients[index][0];
                                  final date = clients[index][1];
                                  List<String> recipes =[];
                                    return ListTile(
                                      onTap: () {
                                        for(int i = 2; i < clients[index].length; i++){
                                          recipes.add(clients[index][i]);
                                          String rec = clients[index][i];
                                          clientData?.setStringList('my_recipe', recipes);
                                          print("Recipe: $i ${clients[index][i]}");
                                        }
                                        clientData?.setString('style', hairStyle);
                                        print(date);
                                        print(hairStyle);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => const listColor()));
                                          recipes.clear();
                                      },
                                      leading: Text("Appointment: $date",
                                        style: TextStyle(fontSize: 20.0),),
                                      title: Text("Style: $hairStyle",
                                        style: TextStyle(fontSize: 20.0),
                                        textAlign: TextAlign.center,),
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
              )
            ],
          ),
        ),
      ),
      // ),
    );
  }}

