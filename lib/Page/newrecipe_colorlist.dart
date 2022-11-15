import 'package:flutter/material.dart';
import 'package:scaleapplication/Page/newrecipe.dart';
import 'package:scaleapplication/Page/previousrecipe.dart';
import 'package:scaleapplication/Page/select_color.dart';


class NewScanColor extends StatefulWidget {
  const NewScanColor({Key? key}) : super(key: key);
  @override
  _NewScanColorState createState() => _NewScanColorState();
}


class _NewScanColorState extends State<NewScanColor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Recipe'),
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
                children: const <Widget>[
                  SizedBox(height: 50),
                  Text('Appointment: 4:00 pm',
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
                // width: size.width,
                // margin: EdgeInsets.symmetric(horizontal: size.width * 0.035),
                child: Row(
                  children: [
                    SizedBox(width: 40),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  const PreviousRecipe()));
                        },
                        // textColor: Colors.white,
                        // padding: const EdgeInsets.all(0),
                        child: Container(
                          alignment: Alignment.center,
                          height: 100.0,
                          decoration: const BoxDecoration(
                            // borderRadius: BorderRadius.circular(80.0),
                              gradient:  LinearGradient(
                                  colors: [
//                              Color.fromARGB(255, 255, 136, 34),
//                              Color.fromARGB(255, 255, 177, 41)
//                              Color(0xFFff0066),
//                              Color(0xFFff99cc)
//                                 Color(0xffEF716B),
//                                 Color(0xffff9999),
                                    Colors.cyan,
                                    Colors.indigo,
                                  ]
                              )
                          ),
                          padding: const EdgeInsets.all(0),
                          child: const Text(
                            "Scan",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              fontSize: 40.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Expanded(
                        child: Text('Or',
                            style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              // color: Color(0xFFf07590),
                                fontSize: 35
                            ),
                            textAlign: TextAlign.center
                        ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  const SelectColor()));
                        },
                        // textColor: Colors.white,
                        // padding: const EdgeInsets.all(0),
                        child: Container(
                          alignment: Alignment.center,
                          height: 100.0,
                          decoration: const BoxDecoration(
                            // borderRadius: BorderRadius.circular(80.0),
                              gradient:  LinearGradient(
                                  colors: [
//                              Color.fromARGB(255, 255, 136, 34),
//                              Color.fromARGB(255, 255, 177, 41)
//                              Color(0xFFff0066),
//                              Color(0xFFff99cc)
//                                 Color(0xffEF716B),
//                                 Color(0xffff9999),
                                    Colors.cyan,
                                    Colors.indigo,
                                  ]
                              )
                          ),
                          padding: const EdgeInsets.all(0),
                          child: const Text(
                            "Select Color",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              fontSize: 40.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 40),
                  ],
                ),
              ),
              const SizedBox(height: 50.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                // decoration: BoxDecoration(
                //     color: Colors.black12,
                //     border: Border.all(width: 1.0)
                // ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Card(
                    elevation: 4,
                    child: Column(
                      children: [
                        //row for each deatails
                        ListTile(
                          onTap: (){
                          },
                          leading: const Text("Appointment: 03/21/2022", style: TextStyle(fontSize: 20.0)),
                          title: const Text("Color: light red", style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center,),
                          // trailing: const Text("New Client",style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center,),
                        ),
                        const Divider(
                          height: 0.6,
                          color: Colors.black87,
                        ),
                        ListTile(
                          onTap: (){
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(builder: (context) =>  const ExistingClient()));
                          },
                          leading: const Text("Appointment: 02/21/2022", style: TextStyle(fontSize: 20.0)),
                          title: const Text("Light Brown", style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center,),
                          // trailing: const Text("Existing Client",style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center,),
                        ),
                        const Divider(
                          height: 0.6,
                          color: Colors.black87,
                        ),
                        ListTile(
                          onTap: (){
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(builder: (context) =>  const NewClient()));
                          },
                          leading: const Text("Appointment: 03/21/2022", style: TextStyle(fontSize: 20.0)),
                          title: const Text("Blonde", style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center,),
                          // trailing: const Text("New Client",style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center,),
                        ),
                        const Divider(
                          height: 0.6,
                          color: Colors.black87,
                        ),
                        // ListTile(
                        //   onTap: (){
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(builder: (context) =>  const NewClient()));
                        //   },
                        //   leading: const Text("7:00 pm", style: TextStyle(fontSize: 20.0)),
                        //   title: const Text("Davile", style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center,),
                        //   trailing: const Text("New Client",style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center,),
                        // ),
                      ],
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


