import 'package:flutter/material.dart';
import 'package:sensor_pf/app/core/ui/widgets.dart';
import 'package:sensor_pf/app/core/validators/validators.dart';
import 'package:sensor_pf/app/modules/home/home_page.dart';
import 'package:sensor_pf/app/modules/home/widgets/add_sensor/add_sensor_controller.dart';

class AddSensorPage extends StatelessWidget with Widgets {
  final AddSensorController controller = AddSensorController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Form(
        key: _formKey,
        child: Scaffold(
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              padding: EdgeInsets.only(top: 80, left: 20, right: 20),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    "Adicionar Sensor",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  SizedBox(height: 50),
                  textField(
                      context: context,
                      controller: controller.nameController,
                      text: 'Nome',
                      validation: Validators().validatorName),
                  SizedBox(height: 30),
                  textField(
                      context: context,
                      controller: controller.emailController,
                      text: 'E-mail',
                      validation: Validators().validatorEmail),
                  SizedBox(height: 30),
                  textField(
                      context: context,
                      controller: controller.temperatureAlertController,
                      text: 'Temperatura para alerta',
                      validation: Validators().validatorTemperatureAlert,
                      keyBoardType:
                          TextInputType.numberWithOptions(decimal: true)),
                  SizedBox(height: 30),
                  textField(
                      context: context,
                      controller: controller.intervalToUpdateController,
                      text: 'Intervalo para atualizar temperatura (em minutos)',
                      validation:
                          Validators().validatorIntervalToAutoUpdateTemperature,
                      keyBoardType:
                          TextInputType.numberWithOptions(decimal: false)),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 150,
                        color: Theme.of(context).accentColor,
                        child: GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState.validate()) {
                              if (await controller.addSensor()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    snackBarSuccess(
                                        text: "Sensor adicionado.",
                                        context: context));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    snackBarError(
                                        text: "Sensor não adicionado.",
                                        context: context));
                              }
                              Navigator.pop(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => HomePage()));
                            }
                          },
                          child: Text(
                            "Adicionar",
                            style: TextStyle(
                                fontSize: 25, color: Color(0xFF292929)),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 150,
                        color: Color(0xFFFF5107),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context,
                                MaterialPageRoute(builder: (_) => HomePage()));
                          },
                          child: Text(
                            "Cancelar",
                            style: TextStyle(
                                fontSize: 25, color: Color(0xFF292929)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 70),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
