import 'package:flutter/material.dart';
import 'package:sensor_pf/app/core/ui/widgets.dart';
import 'package:sensor_pf/app/modules/home/home_controller.dart';
import 'package:sensor_pf/app/modules/home/widgets/add_remove_sensor.dart';
import 'package:sensor_pf/app/modules/home/widgets/sensor_list/sensor_list.dart';
import 'package:sensor_pf/app/modules/login/login_page.dart';
import 'package:sensor_pf/app/modules/settings/settings_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with Widgets {
  HomeController controller = HomeController();
  PageController pageController;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: controller.getStream(),
      builder: (_, snapshot) {
        if (snapshot.hasError)
          return Center(child: Text("Erro, contatar o ADM"));
        if (snapshot.connectionState == ConnectionState.waiting)
          return waitingConnection();

        controller.buildListSensor(snapshot: snapshot);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leadingWidth: 100,
            leading: Center(
              child: GestureDetector(
                child: Text("Logout", style: TextStyle(fontSize: 25)),
                onTap: () async {
                  if (await controller.singOut()) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  }
                },
              ),
            ),
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
                                    sensor: controller.sensorSelected.value)));
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
                    : SensorList(controller: controller),
              ),
              AddRemoveSensor(
                controller: controller,
              )
            ],
          ),
        );
      },
    );
  }

  waitingConnection() {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 8),
            Text(
              "Carregando dados",
              style: Theme.of(context).textTheme.headline2,
            ),
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
}
