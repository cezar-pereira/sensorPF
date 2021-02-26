import 'package:flutter/material.dart';
import 'package:sensor_pf/app/modules/home/home_controller.dart';

import 'card_temperatures.dart';

class SensorList extends StatefulWidget {
  final HomeController controller;
  SensorList({@required this.controller});
  @override
  _SensorListState createState() => _SensorListState();
}

class _SensorListState extends State<SensorList> {
  PageController pageController;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SensorList oldWidget) {
    if (widget.controller.indexPage == 0) pageController.jumpToPage(0);

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: widget.controller,
        builder: (_, __) {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              padding: EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Container(
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buttonChangeSensorBack(),
                        Expanded(
                          child: Center(
                            child: Tooltip(
                              message: widget.controller.sensorSelected.name,
                              child: Text(
                                "${widget.controller.sensorSelected.name}",
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.headline6,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        buttonChangeSensorForward(),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 30),
                      child: Text(
                        "Temperatura atual",
                        style: Theme.of(context).textTheme.headline1,
                      )),
                  Container(
                    height: 200,
                    width: double.infinity,
                    child: PageView.builder(
                      physics: BouncingScrollPhysics(),
                      controller: pageController,
                      itemCount: widget.controller.listSensors.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(3),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                height: 200,
                                width: 200,
                                child: TweenAnimationBuilder(
                                  key: ValueKey<double>(widget.controller
                                      .sensorSelected.temperatures.real),
                                  curve: Curves.bounceOut,
                                  duration: const Duration(seconds: 3),
                                  tween: Tween<double>(
                                      begin: 0,
                                      end: widget.controller
                                          .calculatePercentToAlert()),
                                  builder: (_, value, child) {
                                    return CircularProgressIndicator(
                                      value: value,
                                      strokeWidth: 5,
                                    );
                                  },
                                ),
                              ),
                              AnimatedSwitcher(
                                duration: const Duration(seconds: 1),
                                transitionBuilder:
                                    (child, Animation<double> animation) {
                                  return ScaleTransition(
                                      child: child, scale: animation);
                                },
                                child: Text(
                                  "${widget.controller.sensorSelected.temperatures.real.toStringAsFixed(2)}º",
                                  style: Theme.of(context).textTheme.headline4,
                                  key: ValueKey<double>(widget.controller
                                      .sensorSelected.temperatures.real),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      onPageChanged: (int index) {
                        widget.controller.sensorSelected =
                            widget.controller.listSensors[index];
                        widget.controller.indexPage = index;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CardTemperatures(
                            text: "Mínima",
                            temperature: widget.controller.sensorSelected
                                .temperatures.minimum),
                        CardTemperatures(
                            text: "Média",
                            temperature: widget.controller.sensorSelected
                                .temperatures.average),
                        CardTemperatures(
                            text: "Máxima",
                            temperature: widget.controller.sensorSelected
                                .temperatures.maximum),
                      ],
                    ),
                  ),
                  AnimatedBuilder(
                    animation: widget.controller,
                    builder: (_, __) {
                      return GestureDetector(
                        onTap: () async {
                          if (widget.controller.timerRequestTemperature == 0) {
                            widget.controller.requestTemperatureUpdate();
                            widget.controller.progressBar();
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
                          height: 60,
                          width: 220,
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Text(
                                "Atualizar",
                                style: Theme.of(context).textTheme.button,
                              ),
                              Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 6,
                                  child: LinearProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.black),
                                    backgroundColor: Colors.transparent,
                                    value: widget
                                        .controller.timerRequestTemperature,
                                  ))
                            ],
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  buttonChangeSensorBack() {
    return Container(
      margin: EdgeInsets.only(left: 25),
      width: 40,
      height: 40,
      child: widget.controller.indexPage == 0
          ? Container()
          : GestureDetector(
              child: Icon(Icons.arrow_back_ios),
              onTap: () {
                pageController.previousPage(
                    curve: Curves.ease, duration: Duration(microseconds: 1));
              },
            ),
    );
  }

  buttonChangeSensorForward() {
    return Container(
      margin: EdgeInsets.only(right: 25),
      width: 40,
      height: 40,
      child: widget.controller.indexPage ==
              (widget.controller.listSensors.length - 1)
          ? Container()
          : GestureDetector(
              child: Icon(Icons.arrow_forward_ios),
              onTap: () {
                pageController.nextPage(
                    curve: Curves.ease, duration: Duration(microseconds: 1));
              },
            ),
    );
  }
}
