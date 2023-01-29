import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_test_app/models/scooter.dart';

class ScooterClusterItem with ClusterItem {
  ScooterClusterItem({
    required this.scooter,
  });

  final Scooter scooter;
  

  @override
  LatLng get location => LatLng(scooter.lat.toDouble(), scooter.long.toDouble());
}
