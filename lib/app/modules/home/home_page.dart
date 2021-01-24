import 'package:flutter/material.dart';
import 'package:sensor_pf/app/core/models/sensor.dart';
import 'package:sensor_pf/app/core/ui/widgets.dart';
import 'package:sensor_pf/app/modules/home/home_controller.dart';
import 'package:sensor_pf/app/modules/home/widgets/add_sensor/add_sensor_page.dart';
import 'package:sensor_pf/app/modules/settings/settings_page.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with Widgets {
  HomeController controller;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    controller = HomeController();
    return StreamBuilder(
      stream: controller.getStream(),
      builder: (_, snapshot) {
        if (snapshot.hasError)
          return Center(child: Text("Erro, contatar o ADM"));
        if (snapshot.connectionState == ConnectionState.waiting)
          return waitingConnection();

        controller.buildListSensor(snapshot: snapshot);
        // controller.listSensors.clear();

        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
                if (controller.listSensors.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        child: Icon(Icons.settings),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SettingsPage(
                                      sensor:
                                          controller.sensorSelected.value)));
                        },
                      ),
                    ),
                  )
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: controller.listSensors.isEmpty
                      ? widgetZeroSensors(context)
                      : widgetSensor(context),
                ),
                LayoutBuilder(
                  builder: (context, BoxConstraints constraints) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: constraints.maxWidth / 2,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddSensorPage(),
                                    ));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add),
                                  SizedBox(width: 8),
                                  Text("Adicionar Sensor",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: constraints.maxWidth / 2,
                            child: GestureDetector(
                              onTap: () {
                                if (controller.listSensors.isNotEmpty) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          actions: [
                                            FlatButton(
                                                onPressed: () {
                                                  Navigator.of(context,
                                                          rootNavigator: true)
                                                      .pop(false);
                                                },
                                                child: Text("Cancelar")),
                                            FlatButton(
                                                onPressed: () async {
                                                  if (await controller
                                                      .removeSensor()) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            snackBarSuccess(
                                                                text:
                                                                    "Sensor removido.",
                                                                context:
                                                                    context));
                                                    setState(() {});
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(snackBarError(
                                                            text:
                                                                "Sensor não removido.",
                                                            context: context));
                                                  }

                                                  Navigator.of(context,
                                                          rootNavigator: true)
                                                      .pop(true);
                                                },
                                                child: Text(
                                                  "Remover",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ))
                                          ],
                                          title: Text(
                                            "Remover sensor",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          content: RichText(
                                              text: TextSpan(
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  text:
                                                      "Confirma remoção do sensor ",
                                                  children: [
                                                TextSpan(
                                                    text:
                                                        "${controller.sensorSelected.value.name}",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                TextSpan(
                                                  text: "?",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                )
                                              ])),
                                        );
                                      });
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.delete_forever,
                                      color: controller.listSensors.isNotEmpty
                                          ? null
                                          : Colors.red),
                                  SizedBox(width: 8),
                                  Text("Remover Sensor",
                                      style: controller.listSensors.isNotEmpty
                                          ? Theme.of(context)
                                              .textTheme
                                              .headline5
                                          : TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.w100,
                                              fontSize: 20)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              ],
            ));
      },
    );
  }

  widgetSensor(context) {
    return ValueListenableBuilder(
        valueListenable: controller.sensorSelected,
        builder: (_, Sensor sensor, child) {
          return Container(
            padding: EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Container(
                  height: 25,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buttonChangeSensorBack(),
                      Expanded(
                        child: Center(
                          child: Tooltip(
                            message: sensor.name,
                            child: Text(
                              "${sensor.name}",
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
                    itemCount: controller.listSensors.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(3),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              height: 200,
                              width: 200,
                              child: CircularProgressIndicator(
                                strokeWidth: 5,
                                value: controller.calculatePercentToAlert(),
                              ),
                            ),
                            Text(
                              "${sensor.temperatures.real.toStringAsFixed(2)}º",
                              style: Theme.of(context).textTheme.headline4,
                            )
                          ],
                        ),
                      );
                    },
                    onPageChanged: (int index) {
                      controller.sensorSelected = controller.listSensors[index];
                      controller.indexPage = index;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      cardTemperatures(
                          text: "Mínima",
                          temperature: sensor.temperatures.minimum,
                          context: context),
                      cardTemperatures(
                          text: "Média",
                          temperature: sensor.temperatures.average,
                          context: context),
                      cardTemperatures(
                          text: "Máxima",
                          temperature: sensor.temperatures.maximum,
                          context: context),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  color: Theme.of(context).accentColor,
                  height: 60,
                  width: 220,
                  child: GestureDetector(
                    onTap: () async => controller.requestTemperatureUpdate(),
                    child: Text(
                      "Atualziar",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  waitingConnection() {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 8),
            Text("Carregando dados"),
          ],
        ),
      ),
    );
  }

  widgetZeroSensors(context) {
    return Center(
      child: Text(
        "Nenhum sensor cadastrado.",
        style: Theme.of(context).textTheme.headline2,
        textAlign: TextAlign.center,
      ),
    );
  }

  buttonChangeSensorBack() {
    return Container(
      margin: EdgeInsets.only(left: 25),
      width: 40,
      height: 40,
      child: controller.indexPage == 0
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
      child: controller.indexPage == (controller.listSensors.length - 1)
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

  cardTemperatures(
      {@required String text,
      @required double temperature,
      @required BuildContext context}) {
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
