import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../../utils/widgets/custom_text_field.dart';
import '../controller/auth_controller.dart';

class RegisterScreen extends StatefulWidget {
  final String? mobile;

  const RegisterScreen({super.key, required this.mobile});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  void initState() {
    super.initState();
    if (widget.mobile != null && widget.mobile!.isNotEmpty) {
      final controller = Get.find<CollectionAuthController>();
      controller.mobileController.text = widget.mobile!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: GetBuilder<CollectionAuthController>(
        builder: (controller) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                // SizedBox(height: 50),
                // Image.asset(Images.logoPng, height: 100),
                SizedBox(height: 50),
                Text(
                  "Create Customer",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 30),
                Form(
                  key: controller.formKeySignUP,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildInputField(
                        'Enter Your Name',
                        "First Name *",
                        controller.nameController,
                        "Please enter your name",
                      ),
                      SizedBox(height: 20),
                      buildInputField(
                        'Enter Your Mobile Number',
                        "Mobile No *",
                        controller.mobileController,
                        "Please enter a valid mobile number",
                        isPhone: true,
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: Container(
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
                              backgroundColor: brandPrimaryColor,
                              padding: EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 50,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () async {
                              if (controller.formKeySignUP.currentState!
                                  .validate()) {
                                if (controller.passwordController.text !=
                                    controller.confirmPasswordController.text) {
                                  Get.snackbar(
                                    "Error",
                                    "Passwords do not match",
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white,
                                  );
                                  return;
                                }
                                final result = await controller
                                    .signupVerification();
                                // if (result != null) {
                                //   Navigator.pop(context);
                                //
                                //   Navigator.pushReplacement(
                                //       context,
                                //       MaterialPageRoute(
                                //           builder: (builder) =>
                                //               EstimateScreen()));
                                //   Get.find<EstimateController>()
                                //           .selectedCustomerMobile =
                                //       result['mobile'];
                                //   Get.find<EstimateController>()
                                //           .selectedCustomerId =
                                //       result['customerId'];
                                //
                                //   Get.find<EstimateController>()
                                //           .selectedCustomerName =
                                //       result['firstname'];
                                // }
                              }
                            },
                            child: Text(
                              'SUBMIT',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
