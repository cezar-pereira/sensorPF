import 'package:flutter/material.dart';
import 'package:sensor_pf/app/core/ui/widgets.dart';
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
                      validation: validatorName),
                  SizedBox(height: 30),
                  textField(
                      context: context,
                      controller: controller.emailController,
                      text: 'E-mail',
                      validation: validatorEmail),
                  SizedBox(height: 30),
                  textField(
                      context: context,
                      controller: controller.temperatureAlertController,
                      text: 'Temperatura para alerta',
                      validation: validatorTemperatureAlert,
                      keyBoardType:
                          TextInputType.numberWithOptions(decimal: true)),
                  SizedBox(height: 30),
                  textField(
                      context: context,
                      controller: controller.intervalToUpdateController,
                      text: 'Intervalo para atualizar temperatura (em minutos)',
                      validation: validatorIntervalToAutoUpdateTemperature,
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

  validatorName(String value) {
    int minCaracters = 5;
    int maxCaracters = 80;

    if (value.length < minCaracters || value.length > maxCaracters)
      return "Nome deve conter entre $minCaracters e $maxCaracters caracteres.";
    else
      return null;
  }

  validatorEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);

    if (regex.hasMatch(value))
      return null;
    else
      return "Digite um email válido.";
  }

  validatorTemperatureAlert(String value) {
    Pattern pattern = r"^[+-]?[0-9]*\.?[0-9]*$";
    RegExp regex = RegExp(pattern);

    if (regex.hasMatch(value) && value.isNotEmpty)
      return null;
    else
      return "Digite uma temperatura válida, utilize . (ponto) para decimal.";
  }

  validatorIntervalToAutoUpdateTemperature(value) {
    int minInterval = 1;
    int maxInterval = 30;
    Pattern pattern = r"^[1-9][0-9]*$";
    RegExp regex = RegExp(pattern);

    if (regex.hasMatch(value)) {
      if (int.parse(value) > maxInterval)
        return "Digite um intervalo entre $minInterval e $maxInterval.";
      else
        return null;
    } else
      return "Digite um intervalo entre $minInterval e $maxInterval.";
  }
}
