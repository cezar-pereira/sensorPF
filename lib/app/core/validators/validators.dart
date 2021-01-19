class Validators {
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
