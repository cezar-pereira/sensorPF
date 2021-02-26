import 'package:flutter/material.dart';
import 'package:sensor_pf/app/core/ui/widgets.dart';
import 'package:sensor_pf/app/modules/add_sensor/add_sensor_page.dart';
import 'package:sensor_pf/app/modules/home/home_controller.dart';

class AddRemoveSensor extends StatelessWidget with Widgets {
  final HomeController controller;
  AddRemoveSensor({@required this.controller});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
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
                          style: Theme.of(context).textTheme.headline5),
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
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop(false);
                                  },
                                  child: Text(
                                    "Cancelar",
                                    style: TextStyle(
                                        color: Theme.of(context).canvasColor),
                                  ),
                                ),
                                TextButton(
                                    onPressed: () async {
                                      //retornar para primeira página do pageView
                                      controller.indexPage = 0;
                                      if (await controller.removeSensor()) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBarSuccess(
                                                text: "Sensor removido.",
                                                context: context));
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBarError(
                                                text: "Sensor não removido.",
                                                context: context));
                                      }

                                      Navigator.of(context, rootNavigator: true)
                                          .pop(true);
                                    },
                                    child: Text(
                                      "Remover",
                                      style: TextStyle(
                                          color: Colors.red.withOpacity(0.5)),
                                    ))
                              ],
                              title: Text(
                                "Remover sensor",
                                style: TextStyle(color: Colors.black),
                              ),
                              content: RichText(
                                  text: TextSpan(
                                      style: TextStyle(color: Colors.black),
                                      text: "Confirma remoção do sensor ",
                                      children: [
                                    TextSpan(
                                        text:
                                            "${controller.sensorSelected.value.name}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                      text: "?",
                                      style: TextStyle(color: Colors.black),
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
                              ? Theme.of(context).textTheme.headline5
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
    );
  }
}
