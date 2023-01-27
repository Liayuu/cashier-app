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
              // child: Lottie.asset('assets/gif-book.json')
              // decoration: const BoxDecoration(
              //   image: DecorationImage(
              //     image: AssetImage('assets/logo.png'),
              //   ),
              // ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: Text("Login to Your Account",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                    decoration: const InputDecoration(labelText: "Email"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: passwordC,
                    obscureText: _isObsecure,
                    decoration: InputDecoration(
                      labelText: "Password",
                      suffixIcon: IconButton(
                        icon: Icon(_isObsecure
                            ? Icons.visibility_off_outlined
                            : Icons.visibility),
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
                    title: const Text("Remember me"),
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

                  ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      "Login",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

                  // authC.login(emailC.text, passwordC.text),
                  //   ),
                  // ),
                  // const SizedBox(height: 45),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an accoun't ? ",
                        style: TextStyle(fontSize: 18),
                      ),
                      GestureDetector(
                        child: const Text(
                          'Register',
                          style: TextStyle(
                              color: Colors.indigo,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                        onTap: () {
                          Get.back();
                        },
                      )
                    ],
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
