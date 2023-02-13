import 'package:flutter/material.dart';
import 'package:flutterchatapp/helper/helper_function.dart';
import 'package:flutterchatapp/pages/auth/login_page.dart';
import 'package:flutterchatapp/pages/home_page.dart';
import 'package:flutterchatapp/service/auth_service.dart';
import 'package:flutterchatapp/widgets/widgets.dart';
import 'package:flutter/gestures.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String fullName = "";
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      //App Name here
                      const Text(
                        "GroupChat",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // 2nd Text part here
                      const Text(
                        "Create an account now to chat and explore",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      // Image part here
                      const SizedBox(height: 20),
                      Image.asset(
                        "assets/register.png",
                      ),
                      const SizedBox(height: 10),
                      //Name part here
                      TextFormField(
                        validator: (val) {
                          return val!.isEmpty || val.length < 4
                              ? "Please enter a valid name"
                              : null;
                        },
                        decoration: textInputDecoration.copyWith(
                          labelText: "Full Name",
                          hintText: "Enter your full name",
                          prefixIcon: Icon(
                            Icons.person,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        onChanged: (val) {
                          setState(() {
                            fullName = val;
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      //Email part here
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                          labelText: "Email",
                          prefixIcon: Icon(
                            Icons.email,
                            color: Theme.of(context).primaryColor,
                          ),
                          hintText: "Enter your email",
                        ),
                        validator: (val) {
                          return RegExp(
                                      r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(val!)
                              ? null
                              : "Please provide a valid email"; // if the email is not valid
                        },
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),

                      // Password part here
                      const SizedBox(height: 10),
                      TextFormField(
                        obscureText: true,
                        decoration: textInputDecoration.copyWith(
                          labelText: "Password",
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Theme.of(context).primaryColor,
                          ),
                          suffixIcon: Icon(
                            Icons.visibility_off,
                            color: Theme.of(context).primaryColor,
                          ),
                          hintText: "Enter your password",
                        ),
                        validator: (val) {
                          return val!.length < 6
                              ? "Password must be at least 6 characters"
                              : null;
                        },
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                      ),

                      // Elevated Part here
                      const SizedBox(height: 10),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {
                            register();
                          },
                          child: const Text(
                            'Register',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      Text.rich(
                        TextSpan(
                          text: "Already have an account ? ",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                          children: [
                            TextSpan(
                              text: "Login now",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 15,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  nextScreen(context, const LoginPage());
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  register() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .registerUserWithEmailAndPassword(fullName, email, password)
          .then((value) async {
            if(value == true){
              // saving the shared preferences state
              await HelperFunction.saveUserLoggedInStatus(true);
              await HelperFunction.saveUserEmailSF(email);
              await HelperFunction.saveUserNameSF(fullName);
              // ignore: use_build_context_synchronously
              nextScreenReplace(context, const HomePage());

            }
            else{
              setState(() {
                showSnackbar(context, Colors.red, value);
                _isLoading = false;
              });
            }
      });
    }
  }
}
