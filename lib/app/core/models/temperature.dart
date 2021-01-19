class Temperatures {
  double average;
  double maximum;
  double minimum;
  double real;

  Temperatures({
    this.average = 0,
    this.maximum = 0,
    this.minimum = 0,
    this.real = 0,
  });

  factory Temperatures.fromJson(Map<dynamic, dynamic> json) => Temperatures(
        average: json["average"].toDouble(),
        maximum: json["maximum"].toDouble(),
        minimum: json["minimum"].toDouble(),
        real: json["real"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "average": average,
        "maximum": maximum,
        "minimum": minimum,
        "real": real,
      };
}
