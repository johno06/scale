import 'package:flutter/material.dart';
import 'package:scaleapplication/Page/newrecipe_colorlist.dart';
import 'package:shared_preferences/shared_preferences.dart';


class NewClient extends StatefulWidget {
  const NewClient({Key? key}) : super(key: key);
  @override
  _NewClientState createState() => _NewClientState();
}


class _NewClientState extends State<NewClient> {

  SharedPreferences? loginData;
  SharedPreferences? clientData;
  String?  email, name;
  String? clientName, clientTime;

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
      clientName = clientData!.getString('clientName');
      clientTime = clientData!.getString('clientTime');
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Client'),
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
                  children: <Widget>[
                    SizedBox(height: 50),
                    Text('Appointment: $clientTime',
                        style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            // color: Color(0xFFf07590),
                              fontSize: 22
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
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child:  Text(
                    "Stylist: $name",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        // color: Color(0xFFf07590),
                        fontSize: 24
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "Client: $clientName",
                    style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      // color: Color(0xFFf07590),
                        fontSize: 20
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),

                // SizedBox(height: size.height * 0.03),

                // SizedBox(height: size.height * 0.03),

                const SizedBox(height: 30.0),

                Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.symmetric(horizontal: 50),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  const NewScanColor()));
                    },
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(80.0)),
                    // textColor: Colors.white,
                    // padding: const EdgeInsets.all(0),
                    child: Container(
                      alignment: Alignment.center,
                      height: 150.0,
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
                        "Create a New Recipe",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            fontSize: 50.0,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  child: ElevatedButton(
                    onPressed: () {
                    },
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(80.0)),
                    // textColor: Colors.white,
                    // padding: const EdgeInsets.all(0),
                    child: Container(
                      alignment: Alignment.center,
                      height: 150.0,
                      decoration: const BoxDecoration(
                        // borderRadius: BorderRadius.circular(80.0),
                          gradient:  LinearGradient(
                              colors: [
//                              Color.fromARGB(255, 255, 136, 34),
//                              Color.fromARGB(255, 255, 177, 41)
//                              Color(0xFFff0066),
//                              Color(0xFFff99cc)
                                Color(0xffEF716B),
                                Color(0xffff9999),
                              ]
                          )
                      ),
                      padding: const EdgeInsets.all(0),
                      child: const Text(
                        "Manage Recipes",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            fontSize: 50.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      // ),
    );
  }}

