import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_test_app/presentation/scooters_map.dart';
import 'package:map_test_app/repositories/scooter_repository.dart';
import '../models/scooter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.title});

  final String title;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Set<Marker> markers = {};
  Future<List<Scooter>>? _scootersInfoFuture;
  final _scooterRepository = ScooterRepository();

  @override
  void initState() {
    super.initState();
    _scootersInfoFuture = _scooterRepository.getScootersInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _scootersInfoFuture,
        builder: (BuildContext context, AsyncSnapshot<List<Scooter>> snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          } else if (snapshot.hasData) {
            return ScootersMap(scooters: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
