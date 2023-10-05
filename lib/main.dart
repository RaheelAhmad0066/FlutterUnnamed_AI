import 'dart:async';
import 'package:aichat/components/HideKeyboard.dart';

import 'package:aichat/stores/AIChatStore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:aichat/utils/Chatgpt.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'View/new_chat_form_screen/new_chat_form_screen.dart';
import 'View/walkthrough_screen/walkthrough_screen.dart';
import 'theme/theme_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.black,
  ));
  await dotenv.load(fileName: ".env");

  await GetStorage.init();
  await ChatGPT.initChatGPT();
  runApp(
    ChangeNotifierProvider(
      create: (context) => AIChatStore(),
      child: const MyApp(),
    ),
  );
  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return HideKeyboard(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: const NewChatFormScreen(),
        builder: EasyLoading.init(),
      ),
    );
  }
}

Future<void> configLoading() async {
  EasyLoading.instance
    ..maskType = EasyLoadingMaskType.none
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..displayDuration = const Duration(milliseconds: 1000)
    ..userInteractions = false;
}





// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomeScreen(),
//     );
//   }
// }

// String savedName = "";

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
  // TextEditingController nameController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   _loadName();
  // }

  // Future<void> _loadName() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     savedName = prefs.getString('name') ?? "";
  //   });
  // }

  // Future<void> _saveName() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('name', nameController.text);
  //   setState(() {
  //     savedName = nameController.text;
  //   });
  // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Home")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text("Saved Name: $savedName"),
//             TextField(
//               controller: nameController,
//               decoration: InputDecoration(labelText: 'Enter your name'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 _saveName();
//               },
//               child: Text("Save Name"),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => UserScreen(),
//                   ),
//                 );
//               },
//               child: Text("Go to User Screen"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class UserScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("User")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text("User Screen"),
//             Text("Saved Name: $savedName"),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text("Back to Home"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
