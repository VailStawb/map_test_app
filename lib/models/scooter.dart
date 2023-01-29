class Scooter {
  final List<int> tariffs;
  final num lat;
  final num long;
  final String gosnomer;
  final int id;
  final int fuel;
  final int cruisingRange;
  final int cruisingTime;
  final bool alerting;
  final int companyId;
  final ScooterModel model;

  Scooter({
    required this.tariffs,
    required this.lat,
    required this.long,
    required this.gosnomer,
    required this.id,
    required this.fuel,
    required this.cruisingRange,
    required this.cruisingTime,
    required this.alerting,
    required this.companyId,
    required this.model,
  });

  factory Scooter.fromJson(Map<String, dynamic> json) {
    return Scooter(
      tariffs: (json["tariffs"] as List).cast<int>(),
      lat: json["lat"] as num,
      long: json["lon"] as num,
      gosnomer: json["gosnomer"] as String,
      id: json["id"] as int,
      fuel: json["fuel"] as int,
      cruisingRange: json["cruising_range"] as int,
      cruisingTime: json["cruising_time"] as int,
      alerting: json["alerting"] as bool,
      companyId: json["company_id"] as int,
      model: ScooterModel.fromJson(json["model"]),
    );
  }
}

class ScooterModel {
  final int id;
  final String brand;
  final String model;

  ScooterModel({
    required this.id,
    required this.brand,
    required this.model,
  });

  factory ScooterModel.fromJson(Map<String, dynamic> json) {
    return ScooterModel(
      id: json["id"] as int,
      brand: json["brand"] as String,
      model: json["model"] as String,
    );
  }
}
