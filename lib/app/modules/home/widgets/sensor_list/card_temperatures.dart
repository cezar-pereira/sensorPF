import 'package:flutter/material.dart';

class CardTemperatures extends StatelessWidget {
  final String text;
  final double temperature;

  CardTemperatures({@required this.text, @required this.temperature});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(text, style: Theme.of(context).textTheme.headline6),
          Row(
            children: [
              Text(
                "${temperature.toStringAsFixed(2)}",
                style: Theme.of(context).textTheme.headline2,
              ),
              Text("º",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w300,
                      color: Colors.white)),
            ],
          )
        ],
      ),
    );
  }
}
