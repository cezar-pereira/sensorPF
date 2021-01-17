import 'package:flutter/material.dart';

class Widgets {
  textField(
      {@required TextEditingController controller,
      @required String text,
      @required Function validation,
      keyBoardType = TextInputType.text,
      @required context}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$text",
          style: Theme.of(context).textTheme.headline5,
        ),
        TextFormField(
          style: TextStyle(color: Colors.white.withOpacity(0.6)),
          controller: controller,
          keyboardType: keyBoardType,
          validator: (value) {
            return validation(value);
          },
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).accentColor, width: 2)),
            focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).accentColor, width: 2)),
          ),
        ),
      ],
    );
  }
}
