import 'package:flutter/material.dart';
import 'package:sensor_pf/app/core/ui/widgets.dart';
import 'package:sensor_pf/app/core/validators/validators.dart';
import 'package:sensor_pf/app/modules/home/home_page.dart';
import 'package:sensor_pf/app/modules/login/login_controller.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with Widgets {
  LoginController _controller;

  GlobalKey<FormState> _formKey;

  bool _formChanged = false;

  bool _isObscurePassword = true;

  changeObscurePassword() {
    setState(() {
      _isObscurePassword = !_isObscurePassword;
    });
  }

  @override
  void initState() {
    _controller = LoginController();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.checkAuthentication() != null
        ? HomePage()
        : Scaffold(
            body: Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Form(
                  key: _formKey,
                  onChanged: () {
                    _formChanged = true;
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        textField(
                            context: context,
                            controller: _controller.emailController,
                            text: 'E-mail',
                            validation: Validators().validatorEmail,
                            keyBoardType: TextInputType.emailAddress),
                        SizedBox(height: 30),
                        Stack(children: [
                          textField(
                              context: context,
                              controller: _controller.passwordController,
                              text: 'Senha',
                              validation: Validators().validatorPassword,
                              keyBoardType: TextInputType.visiblePassword,
                              isPassword: true,
                              obscureText: _isObscurePassword),
                          Positioned(
                              top: 43,
                              right: 9,
                              child: GestureDetector(
                                onTap: () {
                                  changeObscurePassword();
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  height: 30,
                                  width: 30,
                                ),
                              ))
                        ]),
                        SizedBox(height: 30),
                        GestureDetector(
                          onTap: () async {
                            if (_formChanged) {
                              if (_formKey.currentState.validate()) {
                                if (await _controller
                                    .signInWithEmailAndPassword()) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      snackBarError(
                                          text: "Falha no login",
                                          context: context));
                                }
                                _formChanged = false;
                              }
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.white.withOpacity(0.2),
                                      blurRadius: 5,
                                      offset: Offset(0, 3.5))
                                ],
                                color: Theme.of(context).accentColor,
                                borderRadius: BorderRadius.circular(40)),
                            alignment: Alignment.center,
                            height: 56,
                            child: Text(
                              "Entrar",
                              style: Theme.of(context).textTheme.button,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
