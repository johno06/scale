import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:scaleapplication/Page/new_client.dart';
import 'package:scaleapplication/main.dart';
import 'package:scaleapplication/models/getData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../constant.dart';
import '../models/client.dart';
import 'existing_client.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);
  @override
  _DashboardState createState() => _DashboardState();
}





class _DashboardState extends State<Dashboard> {
  int? H;
  int? h;
  int? m;
  int? s;

  SharedPreferences? loginData;
  SharedPreferences? clientData;

  ClientFetch clientVal = ClientFetch(time: '', name: '', id: '');
  String? clientName, clientTime;


  String?  email, name, security_key, id;

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
      fetchClients();
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

  // getClientsData() async {
  //   var response = await http.get(Uri.https('scaleapplication.herokuapp.com', 'getClients'));
  //   var jsonData = jsonDecode(response.body);
  //   List<Client> clients = [];
  //
  //   for(var c in jsonData){
  //     // Client client = Client(c["_id"], c["name"], c["time"], c["stylist_id"], c["verified"]);
  //     // clients.add(client);
  //   }
  //   print(clients.length);
  //   return clients;
  // }
  //diezmozjecamill

  Future<List<Client>> getClientsDatas() async {
    const url = 'https://scaleapplication.herokuapp.com/getClients';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      final todos = json.map((e) {
        return Client(
          id: e['id'],
          name: e['name'],
          time: e['time'],
          stylist_id: e['stylist_id'],
          verified: e['verified'],
        );
      }).toList();
      return todos;
    }
    return [];
    // throw "Something went wrong";
  }

  List<dynamic> clients = [];

  void fetchClients() async {
    const url = 'https://scaleapplication.herokuapp.com/getClients';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);

    clientData = await SharedPreferences.getInstance();

    print('clicked');
    setState(() {
      clients = json;
    });
    print('fetchclients completed');
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Dashboard'),
      //   automaticallyImplyLeading: false,
      // ),
      appBar: AppBar(
        title: Text("Dashboard"),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.clear();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => ExampleHomePage()));
                },
                child: Icon(
                    Icons.logout
                ),
              )
          ),
        ],
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
                'Welcome: $name',
                style: stylistNameStyle,
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 5.0),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: const Text(
                "Clients Today",
                style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    // color: Color(0xFFf07590),
                    fontSize: 20
                ),
                textAlign: TextAlign.left,
              ),
            ),

            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: ElevatedButton(
                child: const Text(
                  'See All', style: TextStyle(fontSize: 20.0),),
                // color: Colors.blueAccent,
                // textColor: Colors.white,
                onPressed: () {
                  fetchClients();
                },
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
                            itemCount: clients.length,
                            separatorBuilder: (_ , __ ) => Divider(height: 0.6,
                              color: Colors.black87,),
                            itemBuilder: (context, index) {
                              final client = clients[index];
                              final stylist_id = client['stylist_id'];
                              if(stylist_id == id){
                                final name = client['name'];
                                final time = client['time'];
                                clientData?.setString('clientName', name);
                                clientData?.setString('clientTime', time);
                                final verified = client['verified'];
                                return ListTile(
                                  onTap: () {
                                    if(verified == "New Client"){
                                      final name = client['name'];
                                      final time = client['time'];
                                      clientData?.setString('clientName', name);
                                      clientData?.setString('clientTime', time);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => const NewClient()));
                                    }else{
                                      final clientId = client['_id'];
                                      final name = client['name'];
                                      final time = client['time'];
                                      final prev_rec = client['previous_recipe'];
                                      for(int i = 0; i<prev_rec.length; i++){
                                        print(prev_rec[i]);
                                      }
                                      // print(prev_rec);
                                      clientData?.setString('clientId', clientId);
                                      clientData?.setString('clientName', name);
                                      clientData?.setString('clientTime', time);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (
                                              context) => const ExistingClient()));
                                    }
                                  },
                                  leading: Text(time,
                                    style: TextStyle(fontSize: 20.0),),
                                  title: Text(name,
                                    style: TextStyle(fontSize: 20.0),
                                    textAlign: TextAlign.center,),
                                  trailing: Text(verified,
                                    style: TextStyle(fontSize: 20.0),
                                    textAlign: TextAlign.center,),
                                );
                              }else{
                                return Container();
                              }
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
              ]),

          // ],
        ),
      );
      // ),
    // );
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





