import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sensor_pf/app/core/models/sensor.dart';
import 'package:sensor_pf/app/core/ui/widgets.dart';
import 'package:sensor_pf/app/core/validators/validators.dart';
import 'package:sensor_pf/app/modules/settings/settings_controller.dart';

class SettingsPage extends StatefulWidget {
  final SettingsController controller = SettingsController();
  final _formKey = GlobalKey<FormState>();
  final Sensor sensor;

  SettingsPage({@required this.sensor});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with Widgets {
  bool formChanged = false;
  @override
  void initState() {
    super.initState();
    widget.controller.nameController.text = widget.sensor.name;
    widget.controller.emailController.text = widget.sensor.settings.email;
    widget.controller.temperatureAlertController.text =
        widget.sensor.settings.temperatureAlert.toString();
    widget.controller.intervalToUpdateController.text =
        widget.sensor.settings.intervalToUpdate.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Form(
        onChanged: () {
          formChanged = true;
        },
        key: widget._formKey,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.of(context).pop(),
            ),
            centerTitle: true,
            title: Text(
              "Configuração",
              style: Theme.of(context).textTheme.headline6,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              padding: EdgeInsets.only(top: 80, left: 20, right: 20),
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(height: 30),
                  textField(
                      context: context,
                      controller: widget.controller.nameController,
                      text: 'Nome',
                      validation: Validators().validatorName),
                  SizedBox(height: 30),
                  textField(
                      context: context,
                      controller: widget.controller.emailController,
                      text: 'E-mail',
                      validation: Validators().validatorEmail),
                  SizedBox(height: 30),
                  textField(
                      context: context,
                      controller: widget.controller.temperatureAlertController,
                      text: 'Temperatura para alerta',
                      validation: Validators().validatorTemperatureAlert,
                      keyBoardType:
                          TextInputType.numberWithOptions(decimal: true)),
                  SizedBox(height: 30),
                  textField(
                      context: context,
                      controller: widget.controller.intervalToUpdateController,
                      text: 'Intervalo para atualizar temperatura (em minutos)',
                      validation:
                          Validators().validatorIntervalToAutoUpdateTemperature,
                      keyBoardType:
                          TextInputType.numberWithOptions(decimal: false)),
                  SizedBox(height: 50),
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 250,
                    color: Theme.of(context).accentColor,
                    child: GestureDetector(
                      onTap: () async {
                        if (formChanged) {
                          if (widget._formKey.currentState.validate()) {
                            if (await widget.controller
                                .updateSensor(widget.sensor)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  snackBarSuccess(
                                      text: "Atualizado com sucesso.",
                                      context: context));
                              formChanged = false;
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  snackBarError(
                                      text: "Erro ao atualizar.",
                                      context: context));
                            }
                          }
                        }
                      },
                      child: Text(
                        "Atualizar",
                        style:
                            TextStyle(fontSize: 25, color: Color(0xFF292929)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            height: 70,
            margin: EdgeInsets.all(16),
            child: LayoutBuilder(builder: (context, constraints) {
              return Column(
                children: [
                  Divider(
                    thickness: 2,
                    color: Theme.of(context).accentColor,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 40,
                        child: GestureDetector(
                          onTap: () {
                            Clipboard.setData(
                                ClipboardData(text: widget.sensor.id));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(showSnackBar());
                          },
                          child: Tooltip(
                            message: "Copiar",
                            child: RichText(
                              text: TextSpan(
                                  text: "Código sensor: \n",
                                  children: [TextSpan(text: widget.sensor.id)]),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  showSnackBar() {
    return SnackBar(
      content: Text(
        "Código copiado",
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
