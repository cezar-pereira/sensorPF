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
