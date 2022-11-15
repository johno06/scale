import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scaleapplication/Page/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';

import 'login/loginservice.dart';
import 'login/user.dart';



void main() {
  runApp(MaterialApp(
      home: ExampleHomePage()
  ));
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Example',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home:
//       // MyHomePage(),
//       // ExampleHomePage(title: 'Passcode Lock Screen Example')
//       ExampleHomePage()
//     // const ScreenLock(
//       //   correctString: '1234',
//       // ),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   Future<void> localAuth(BuildContext context) async {
//     final localAuth = LocalAuthentication();
//     final didAuthenticate = await localAuth.authenticate(
//       localizedReason: 'Please authenticate',
//       biometricOnly: true,
//     );
//     if (didAuthenticate) {
//       // Navigator.pop(context);
//     }
//   }
//
//   bool circular = true;
//   // ProfileModel model = ProfileModel(lName: '', fName: '', id: '', contactNo: '', email: '');
//
//   UserFetch employeeval = UserFetch(email: '', name: '', id: '', security_key: '');
//   User employee = User('');
//   late SharedPreferences loginData;
//
//   Future login() async {
//
//     var res = await http.post(Uri.parse("http://localhost:8080/login"),
//         headers: <String, String>{
//           'Context-Type': 'application/json;charSet=UTF-8'
//         },
//         body: <String, String>{
//           'security_key': employee.security_key
//         });
//
//     final data = json.decode(res.body);
//     // print(data);
//
//     if (data['success'] == false) {
//     }else {
//       print(data);
//       // userval = UserFetch.fromJson(data['token']);
//       circular = false;
//       // checkLogin();
//       // loginData.setBool('login' ,true);
//       loginData.setString('_id',employeeval.id);
//       loginData.setString('email', employeeval.email);
//       loginData.setString('name', employeeval.name);
//       loginData.setString('security_key', employeeval.security_key);
//       print(employeeval.id);
//
//
//       // Navigator.pushAndRemoveUntil(
//       //     context,
//       //     MaterialPageRoute(builder: (BuildContext context){
//       //       return const HomePage();
//       //     },
//       //     ), (router) => false);
//
//       // Navigator.push(
//       //     context,
//       //      MaterialPageRoute(builder: (context) => const HomePage()));
//       // Fluttertoast.showToast(
//       //     msg: "Log in successfully",
//       //     toastLength: Toast.LENGTH_SHORT,
//       //     gravity: ToastGravity.BOTTOM,
//       //     backgroundColor: Colors.green,
//       //     textColor: Colors.white,
//       //     fontSize: 16.0
//       // );
//     }
//
//     if(data['success'] == false ){
//     }
//   }
//
//   String pass = "1234";
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Next Screen Lock'),
//       ),
//       body: SizedBox(
//         width: double.infinity,
//         child: Wrap(
//           spacing: 10,
//           alignment: WrapAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () => screenLock<void>(
//                 context: context,
//                 correctString: pass,
//                 // maxRetries: 2,
//                 // retryDelay: const Duration(seconds: 3),
//                 // delayChild: const Center(
//                 //   child: Text(
//                 //     'Cannot be entered temporarily because it failed the specified number of times.',
//                 //     softWrap: true,
//                 //   ),
//                 // ),
//                 // withBlur: false,
//                 // screenLockConfig: const ScreenLockConfig(
//                 //   /// If you don't want it to be transparent, override the config
//                 //   backgroundColor: Colors.black,
//                 // ),
//                 didUnlocked: () {
//                   Navigator.pop(context);
//                   NextPage.show(context);
//                 },
//               ),
//               child: const Text('Next page with unlock'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class NextPage extends StatelessWidget {
  const NextPage({Key? key}) : super(key: key);

  static show(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const NextPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Next Page'),
      ),
    );
  }
}



// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Passcode Lock Screen Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: ExampleHomePage(title: 'Passcode Lock Screen Example'),
//     );
//   }
// }

// const storedPasscode = '1234';


class ExampleHomePage extends StatefulWidget {
  // ExampleHomePage({Key? key, required this.title}) : super(key: key);
  // final String title;

  @override
  State<StatefulWidget> createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> {

  @override
  void initState() {
    super.initState();
    setState((){
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        openLockScreen();
      });
    });
  }

  bool circular = true;
  bool isValid = false;
  // ProfileModel model = ProfileModel(lName: '', fName: '', id: '', contactNo: '', email: '');

  UserFetch employeeval = UserFetch(email: '', name: '', id: '', security_key: '');
  User employee = User('');
  SharedPreferences? loginData;
  String passcode = '';
  late bool emp;

  void checkLogin() async {
    loginData = await SharedPreferences.getInstance();
    emp = (loginData?.getBool('login') ?? true);
  }

  Future login() async {

    var res = await http.post(Uri.parse("https://scaleapplication.herokuapp.com/login"),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          'security_key': employee.security_key
        });

    final data = json.decode(res.body);

    if (data['success'] == false) {
      isValid = false;
      _verificationNotifier.add(isValid);
    }else {
      loginData = await SharedPreferences.getInstance();
      print(data);
      employeeval = UserFetch.fromJson(data['token']);
      passcode = employeeval.security_key;
      // isValid = true;
      circular = false;
      checkLogin();
      loginData?.setBool('login' ,true);
      loginData?.setString('_id',employeeval.id);
      loginData?.setString('email', employeeval.email);
      loginData?.setString('name', employeeval.name);
      loginData?.setString('security_key', employeeval.security_key);
      print(employeeval.name);

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Dashboard(),
          ));
      // Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(builder: (BuildContext context){
      //       return const HomePage();
      //     },
      //     ), (router) => false);

      // Navigator.push(
      //     context,
      //      MaterialPageRoute(builder: (context) => const HomePage()));
      // Fluttertoast.showToast(
      //     msg: "Log in successfully",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     backgroundColor: Colors.green,
      //     textColor: Colors.white,
      //     fontSize: 16.0
      // );
    }

    if(data['success'] == false ){
    }
  }
  StreamController<bool> _verificationNotifier =
  StreamController<bool>.broadcast();

  bool isAuthenticated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
          onPressed: openLockScreen,
        ),
      ),
    );
    //   // appBar: AppBar(
    //   //   title: Text(widget.title),
    //   // ),
    //   body: Center(
    //     child:
    //     Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         Text('You are ${isAuthenticated ? '' : 'NOT'} authenticated'),
    //         _defaultLockScreenButton(context)
    //       ],
    //     ),
    //   ),
    // );
  }


  void openLockScreen(){
    _showLockScreen(
      context,
      opaque: false,
      cancelButton: Text(
        'Cancel',
        style: const TextStyle(fontSize: 16, color: Colors.white),
        semanticsLabel: 'Cancel',
      ),
    );
  }

    _defaultLockScreenButton(BuildContext context) => MaterialButton(
      onPressed: () {
      //login();
      _showLockScreen(
        context,
        opaque: true,
        cancelButton: Text(
          'Cancel',
          style: const TextStyle(fontSize: 16, color: Colors.white),
          semanticsLabel: 'Cancel',
        ),
      );
    },
  );

  _showLockScreen(
      BuildContext context, {
        required bool opaque,
        CircleUIConfig? circleUIConfig,
        KeyboardUIConfig? keyboardUIConfig,
        required Widget cancelButton,
        List<String>? digits,
      })
  {
    Navigator.push(
        context,
        PageRouteBuilder(
          opaque: opaque,
          pageBuilder: (context, animation, secondaryAnimation) =>
              PasscodeScreen(
                title: Text(
                  'Enter App Passcode',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 28),
                ),
                circleUIConfig: circleUIConfig,
                keyboardUIConfig: keyboardUIConfig,
                passwordEnteredCallback: _onPasscodeEntered,
                cancelButton: cancelButton,
                deleteButton: Text(
                  'Delete',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                  semanticsLabel: 'Delete',
                ),
                shouldTriggerVerification: _verificationNotifier.stream,
                backgroundColor: Colors.black.withOpacity(0.8),
                cancelCallback: _onPasscodeCancelled,
                digits: digits,
                passwordDigits: 4,
                bottomWidget: _buildPasscodeRestoreButton(),
              ),
        ));
  }


  _onPasscodeEntered(String enteredPasscode) {
    employee.security_key = enteredPasscode;
    // isValid = false;

    login();
    // bool isValid = passcode == enteredPasscode;
    // _verificationNotifier.add(isValid);
    // if (isValid == true) {
    //   // setState(() {
    //   //   this.isAuthenticated = isValid;
    //   // });
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => const Dashboard(),
    //       ));
    // }
  }

  _onPasscodeCancelled() {
    // Navigator.maybePop(context);
  }

  @override
  void dispose() {
    _verificationNotifier.close();
    super.dispose();
  }

  _buildPasscodeRestoreButton() => Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      margin: const EdgeInsets.only(bottom: 10.0, top: 20.0),
      child: TextButton(
        child: Text(
          "Reset passcode",
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w300),
        ),
        onPressed: _resetAppPassword,
        // splashColor: Colors.white.withOpacity(0.4),
        // highlightColor: Colors.white.withOpacity(0.2),
        // ),
      ),
    ),
  );

  _resetAppPassword() {
    Navigator.maybePop(context).then((result) {
      if (!result) {
        return;
      }
      _showRestoreDialog(() {
        Navigator.maybePop(context);
        //TODO: Clear your stored passcode here
      });
    });
  }

  _showRestoreDialog(VoidCallback onAccepted) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Reset passcode",
            style: const TextStyle(color: Colors.black87),
          ),
          content: Text(
            "Passcode reset is a non-secure operation!\n\nConsider removing all user data if this action performed.",
            style: const TextStyle(color: Colors.black87),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            TextButton(
              child: Text(
                "Cancel",
                style: const TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.maybePop(context);
              },
            ),
            TextButton(
              child: Text(
                "I understand",
                style: const TextStyle(fontSize: 18),
              ),
              onPressed: onAccepted,
            ),
          ],
        );
      },
    );
  }
}