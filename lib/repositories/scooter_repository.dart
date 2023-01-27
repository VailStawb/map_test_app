import 'dart:convert';
import 'package:map_test_app/models/scooter.dart';
import 'package:http/http.dart' as http;

class ScooterRepository {
  final _httpScootersInfoUri = Uri.parse('https://georgia.togo-tech.cloud/api/v6/avaliableCars');

  Future<List<ScooterInfo>> getScootersInfo() async {
    final scootersResponse = await http.get(_httpScootersInfoUri);

    if (scootersResponse.statusCode != 200) {
      throw GetScooterException(
        statusCode: scootersResponse.statusCode,
      );
    }

    final scootersJson = json.decode(scootersResponse.body) as Map<String, dynamic>;

    final List<ScooterInfo> scootersList = [];
    final scootersJsonList = scootersJson["cars"] as List;
    for (var element in scootersJsonList) {
      scootersList.add(ScooterInfo.fromJson(element as Map<String, dynamic>));
    }
    return scootersList;
    
  }
   
}

class GetScooterException implements Exception {
  final int? statusCode;

  GetScooterException({
    this.statusCode,
  });
}

