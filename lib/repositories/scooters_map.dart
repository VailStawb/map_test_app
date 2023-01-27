// import 'package:flutter/cupertino.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// import '../models/scooter.dart';

// class ScootersGoogleMap extends StatefulWidget {
  
//   const ScootersGoogleMap({super.key});

//   @override
//   State<ScootersGoogleMap> createState() => _ScootersGoogleMapState();
// }

// class _ScootersGoogleMapState extends State<ScootersGoogleMap> {
//   static const LatLng _kMapCenter = LatLng(41.6422800, 41.6339200);
//   static const CameraPosition _kInitialPosition = CameraPosition(target: _kMapCenter, zoom: 13.0, tilt: 0, bearing: 0);

//   GoogleMapController? _controller;

//   Future<void> _onMapCreated(GoogleMapController controller) async {
//     _controller = controller;
//     String value = await DefaultAssetBundle.of(context).loadString('assets/map_style.json');
//     _controller!.setMapStyle(value);
//   }
  
//   Set<Marker> _createMarker(List<ScooterInfo> data) {
//     return {
//       for (ScooterInfo scooter in data)
//         Marker(
//           icon: _selectedId == scooter.id ? _selectedMarkerIcon : _unSelectedMarkerIcon,
//           markerId: MarkerId(scooter.id.toString()),
//           position: LatLng(scooter.lat.toDouble(), scooter.long.toDouble()),
//           infoWindow: InfoWindow(
//             title: scooter.model.brand,
//             snippet: "${scooter.fuel} % charge",
//           ),
//           onTap: () {
//             setState(() {
//               _selectedId = scooter.id;
//             });
//           },
//         ),
//     };
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     return GoogleMap(
//       initialCameraPosition: _kInitialPosition,
//                     mapToolbarEnabled: false,
//                     onMapCreated: _onMapCreated,
//                     markers: _createMarker(snapshot.data!),
//                     myLocationEnabled: true,
//                     zoomControlsEnabled: false,
//                     buildingsEnabled: true,
//                     onTap: (_) => setState(() => _selectedId = null)),
//     );
//   }
// }
