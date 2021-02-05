import 'package:flutter/material.dart';

class Widgets {
  textField(
      {@required TextEditingController controller,
      @required String text,
      @required Function validation,
      keyBoardType = TextInputType.text,
      obscureText = false,
      isPassword = false,
      @required context}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$text",
          style: Theme.of(context).textTheme.headline5,
        ),
        Container(
          margin: EdgeInsets.only(top: 8),
          child: TextFormField(
            obscureText: obscureText,
            style: TextStyle(color: Colors.white, fontSize: 20),
            controller: controller,
            keyboardType: keyBoardType,
            validator: (value) {
              return validation(value);
            },
            cursorColor: Colors.white,
            decoration: InputDecoration(
              suffixIcon: isPassword
                  ? obscureText
                      ? Icon(Icons.visibility,
                          color: Theme.of(context).iconTheme.color)
                      : Icon(Icons.visibility_off,
                          color: Theme.of(context).iconTheme.color)
                  : null,
              filled: true,
              hoverColor: Color(0xFF3D3D3E),
              focusColor: Color(0xFF3D3D3E),
              fillColor: Color(0xFF3D3D3E),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }

  snackBarError({@required String text, @required BuildContext context}) {
    return SnackBar(
        content: Row(
      children: [
        Icon(
          Icons.close,
          color: Colors.red,
          size: Theme.of(context).textTheme.headline1.fontSize,
        ),
        SizedBox(width: 15),
        Text(
          text,
          style: Theme.of(context).textTheme.headline6,
        ),
      ],
    ));
  }

  snackBarSuccess({@required String text, @required BuildContext context}) {
    return SnackBar(
        content: Row(
      children: [
        Icon(
          Icons.done,
          color: Theme.of(context).accentColor,
          size: Theme.of(context).textTheme.headline1.fontSize,
        ),
        SizedBox(width: 15),
        Text(
          text,
          style: Theme.of(context).textTheme.headline6,
        ),
      ],
    ));
  }
}
