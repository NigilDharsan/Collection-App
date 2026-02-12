import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../../utils/styles.dart';
import '../controller/auth_controller.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isChecked = true; // Initially hide the password
  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  void _loadSavedCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isChecked = prefs.getBool('rememberMe') ?? false;
      if (_isChecked) {
        Get.find<CollectionAuthController>().signInEmailController.text =
            prefs.getString('username') ?? "";
        Get.find<CollectionAuthController>().signInPasswordController.text =
            prefs.getString('password') ?? "";
      }
    });
  }

  void _saveCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_isChecked) {
      await prefs.setString('username',
          Get.find<CollectionAuthController>().signInEmailController.value.text);
      await prefs.setString('password',
          Get.find<CollectionAuthController>().signInPasswordController.value.text);
      await prefs.setBool('rememberMe', true);
    } else {
      await prefs.remove('phoneNumber');
      await prefs.remove('password');
      await prefs.setBool('rememberMe', false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: GetBuilder<CollectionAuthController>(builder: (controller) {
            return SingleChildScrollView(
              child: Form(
                key: controller.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(Images.logoPng, height: 100),
                    const SizedBox(height: 20),
                    const Text(
                      'SIGN IN',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: brandGreyColor),
                    ),
                    const SizedBox(height: 30),
                    _buildTextField(
                        'Enter your text here',
                        'LOGIN/USER NAME/EMAIL',
                        controller.signInEmailController,
                        false,
                        controller),
                    const SizedBox(height: 20),
                    _buildTextField('Enter your text here', 'PASSWORD',
                        controller.signInPasswordController, true, controller),
                    SizedBox(height: 7),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CheckBoxes(context, value: _isChecked,
                            onChanged: (value) {
                          setState(() {
                            setState(() => _isChecked = !_isChecked);
                          });
                          _saveCredentials();
                        }, onTap: () {
                          _saveCredentials();
                        }, checkBoxText: 'Remember me', width: null),
                      ],
                    ),
                    const SizedBox(height: 30),
                    _buildSignInButton(controller),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String hintName,
      String label,
      TextEditingController textController,
      bool isPassword,
      CollectionAuthController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: brandGreyColor),
        ),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: TextFormField(
              controller: textController,
              obscureText: isPassword ? controller.obscurePassword : false,
              decoration: InputDecoration(
                hintText: hintName,
                hintStyle: const TextStyle(color: brandGreySoftColor),
                filled: true,
                fillColor: brandGoldLightColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: isPassword
                    ? IconButton(
                        icon: Icon(
                          controller.obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          if (controller.obscurePassword) {
                            controller.obscurePassword = false;
                          } else {
                            controller.obscurePassword = true;
                          }
                          controller.update();
                        },
                      )
                    : null,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return isPassword ? 'Enter Password' : 'Enter Email/Username';
                }
                return null;
              },
            ),
          ),
        ),
        const SizedBox(height: 5),
      ],
    );
  }

  Widget _buildSignInButton(CollectionAuthController controller) {
    return Container(
      width: 235,
      height: 50,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF8D3D5B),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          if (controller.formKey.currentState!.validate()) {
            _saveCredentials();
            controller.login();
          }
        },
        child: const Text(
          'SIGN IN',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}

Widget CheckBoxes(context,
    {required bool? value,
    required void Function(bool?)? onChanged,
    required String checkBoxText,
    void Function()? onTap,
    required double? width}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: value,
          activeColor: brandGreyColor,
          onChanged: onChanged,
          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        InkWell(onTap: onTap, child: RemberText(checkBoxText, width: width)),
      ],
    ),
  );
}

Widget RemberText(String txt, {required double? width}) {
  return Padding(
    padding: const EdgeInsets.only(left: 5, top: 3),
    child: Container(
      width: width,
      child: Text(
        txt,
        style: remberText,
        maxLines: 2,
      ),
    ),
  );
}
