import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'bottom_custom_painter.dart';
import 'top_custom_painter.dart';

class IconApp extends StatefulWidget {
  @override
  _IconAppState createState() => _IconAppState();
}

class _IconAppState extends State<IconApp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(top: 22),
            width: 60,
            height: 180,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  child: Column(
                    children: [
                      top(context),
                      SizedBox(
                        height: 14,
                      ),
                      side(context),
                    ],
                  ),
                ),
                center(context),
                bottom(context),
              ],
            ),
          ),
          Container(
            height: 180,
            width: 180,
            child: CircularProgressIndicator(
                strokeWidth: 4,
                value: 10,
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).iconTheme.color)),
          )
        ],
      ),
    );
  }

  top(context) {
    return CustomPaint(
      size: Size(30, 0),
      painter: TopCustomPainter(context),
    );
  }

  center(context) {
    return Positioned(
      top: 38,
      child: Container(
        height: 90,
        width: 40,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              bottom: 28,
              child: TweenAnimationBuilder(
                duration: Duration(seconds: 2),
                tween: Tween<double>(begin: 0, end: 50),
                builder: (context, value, child) {
                  return Container(
                    color: Theme.of(context).iconTheme.color,
                    width: 10,
                    height: value,
                  );
                },
              ),
            ),
            Positioned(
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Theme.of(context).iconTheme.color,
                    borderRadius: BorderRadius.circular(30)),
              ),
            )
          ],
        ),
      ),
    );
  }

  traceSide(context) {
    return Container(
      height: 4,
      width: 4,
      color: Theme.of(context).iconTheme.color,
    );
  }

  side(context) {
    return Container(
      width: 34,
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 80,
                width: 4,
                color: Theme.of(context).iconTheme.color,
              ),
              Container(
                height: 80,
                width: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 10,
                      width: 4,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    traceSide(context),
                    traceSide(context),
                    traceSide(context),
                    traceSide(context),
                    Container(
                      height: 15,
                      width: 4,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bottom(context) {
    return Positioned(
      top: 88,
      child: CustomPaint(
        size: Size(50, 0),
        painter: BottomCustomPainter(context),
      ),
    );
  }
}
