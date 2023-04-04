import 'package:cashier_app/configs/language_config.dart';
import 'package:cashier_app/controllers/user_controller.dart';
import 'package:cashier_app/views/pages/dashboard/dasboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isObsecure = true;
  bool check = false;
  late PageController pageController;
  final int _pageIndex = 0;

  // final authC = Get.find<AuthController>();
  final emailC = TextEditingController();
  final passwordC = TextEditingController();

  final UserController _userCon = Get.find<UserController>();

  @override
  void initState() {
    pageController = PageController(initialPage: _pageIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _loginContainer(),
      ),
    );
  }

  Widget _loginContainer() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 3,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: Text(lang().loginTitle,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(
            height: 11,
          ),
          Expanded(
            child: Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(children: [
                  TextFormField(
                    controller: emailC,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: lang().email),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: passwordC,
                    obscureText: _isObsecure,
                    decoration: InputDecoration(
                      labelText: lang().password,
                      suffixIcon: IconButton(
                        icon: Icon(_isObsecure ? Icons.visibility_off_outlined : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _isObsecure = !_isObsecure;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CheckboxListTile(
                    title: Text(lang().rememberOption),
                    controlAffinity: ListTileControlAffinity.leading,
                    value: check,
                    onChanged: (value) => setState(
                      () {
                        check = !check;
                      },
                    ),
                    activeColor: Colors.indigo,
                    checkColor: Colors.white,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: "Belum memiliki akun? Segera ",
                      style: Get.textTheme.labelMedium,
                    ),
                    TextSpan(
                        text: "Daftar disini",
                        style: Get.textTheme.labelLarge!.copyWith(color: Get.theme.primaryColor))
                  ])),
                  ElevatedButton(
                    onPressed: () {
                      _userCon.loginUser(emailC.text, passwordC.text);
                      // Get.to(() => const MainDashboard());
                    },
                    child: Text(
                      lang().login,
                      style: Get.textTheme.labelLarge,
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ignore: unused_element
}
