import 'package:flutter/material.dart';
import 'package:sensor_pf/app/core/ui/widgets.dart';
import 'package:sensor_pf/app/core/validators/validators.dart';
import 'package:sensor_pf/app/modules/home/home_page.dart';
import 'package:sensor_pf/app/modules/login/login_controller.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget with Widgets {
  final LoginController _controller = LoginController();
  final _formKey = GlobalKey<FormState>();
  bool _formChanged = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          onChanged: () {
            _formChanged = true;
          },
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 250, left: 20, right: 20),
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
                textField(
                    context: context,
                    controller: _controller.passwordController,
                    text: 'Senha',
                    validation: Validators().validatorPassword,
                    keyBoardType: TextInputType.visiblePassword,
                    obscureText: true),
                SizedBox(height: 30),
                Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 250,
                  color: Theme.of(context).accentColor,
                  child: GestureDetector(
                    onTap: () async {
                      if (_formChanged) {
                        if (_formKey.currentState.validate()) {
                          if (await _controller.signInWithEmailAndPassword()) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                snackBarError(
                                    text: "Falha no login", context: context));
                          }
                          _formChanged = false;
                        }
                      }
                    },
                    child: Text(
                      "Entrar",
                      style: TextStyle(fontSize: 25, color: Color(0xFF292929)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
