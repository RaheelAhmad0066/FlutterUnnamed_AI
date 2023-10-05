import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/utils/size_utils.dart';
import '../../core/utils/validation_functions.dart';
import '../../page/HomePage.dart';
import '../../theme/app_decoration.dart';
import '../../theme/custom_text_style.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'controller/new_chat_form_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

String UserName = "";
String UserInfo = "";
String AIName = "";
String SomeInfo = "";

class NewChatFormScreen extends StatefulWidget {
  const NewChatFormScreen({super.key});

  @override
  State<NewChatFormScreen> createState() => _NewChatFormScreenState();
}

class _NewChatFormScreenState extends State<NewChatFormScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController InfoControler = TextEditingController();
  TextEditingController AINameControler = TextEditingController();
  TextEditingController SomeInfoControler = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadName();
  }

  Future<void> _loadName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      UserName = prefs.getString('name') ?? "";
      UserInfo = prefs.getString('userinfo') ?? "";
      AIName = prefs.getString('ai') ?? "";
      SomeInfo = prefs.getString('some') ?? "";
    });
  }

  Future<void> _saveName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', nameController.text);
    prefs.setString('userinfo', InfoControler.text);
    prefs.setString('ai', AINameControler.text);
    prefs.setString('some', SomeInfoControler.text);
    setState(() {
      UserName = nameController.text;
      UserInfo = InfoControler.text;
      AIName = AINameControler.text;
      SomeInfo = SomeInfoControler.text;
    });
  }

  // void userfirebase() {
  //   colection.add({
  //     "Name": UserName,
  //     "Info": UserInfo,
  //     "AiName": AIName,
  //     "SomeInfo": SomeInfo,
  //   });

  //   // Clear the text fields
  // }

  final controler = Get.put(userdata());
  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          // padding: EdgeInsets.symmetric(vertical: 34.v),
          child: Column(
            children: [
              SizedBox(height: 327.v),
              Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.h,
                    vertical: 7.v,
                  ),
                  decoration: AppDecoration.fillWhiteA.copyWith(
                    borderRadius: BorderRadiusStyle.customBorderTL20,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 35.v),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Lets setup a chat!",
                          style: theme.textTheme.headlineMedium,
                        ),
                      ),
                      Container(
                        width: 247.h,
                        margin: EdgeInsets.only(
                          top: 2.v,
                          right: 87.h,
                        ),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "We need a few details to get started.\n"
                                    .tr,
                                style: CustomTextStyles
                                    .bodyLargePrimaryContainer17_1,
                              ),
                              TextSpan(
                                text: "(you can change this at any time)".tr,
                                style: theme.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(height: 15.v),
                      CustomTextFormField(
                        controller: nameController,
                        hintText: "Enter your name/alias".tr,
                        validator: (value) {
                          if (!isText(value)) {
                            return "Please enter valid text";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15.v),
                      CustomTextFormField(
                        // controller: controller.timeController,
                        controller: InfoControler,

                        hintText: "Enter some information about yourself.".tr,
                        validator: (value) {
                          if (!isText(value)) {
                            return "Please enter valid text";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15.v),
                      SizedBox(height: 15.v),
                      SizedBox(height: 15.v),
                      CustomTextFormField(
                        // controller: controller.timeController,
                        controller: AINameControler,

                        hintText: "Enter the name of  “Your Ai”.".tr,
                        validator: (value) {
                          if (!isText(value)) {
                            return "Please enter valid text";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15.v),
                      CustomTextFormField(
                        // controller: controller.timeController,
                        controller: SomeInfoControler,

                        hintText: "Enter some information about yourself.".tr,
                        validator: (value) {
                          if (!isText(value)) {
                            return "Please enter valid text";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15.v),
                      // Obx(
                      //   () => controler.isloading.value
                      //       ? CircularProgressIndicator()
                      //       :
                      Text(UserName),
                      CustomElevatedButton(
                        onTap: () {
                          _saveName();

                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: ((context) => jk())),
                              (route) => false);
                        },
                        text: "Start Chat".tr,
                      ),
                      //),
                      SizedBox(height: 15.v),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class jk extends StatelessWidget {
  const jk({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '  $UserName,$UserInfo',
        style: TextStyle(fontSize: 40, color: Colors.red),
      ),
    );
  }
}
