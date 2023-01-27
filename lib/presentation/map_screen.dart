import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_test_app/repositories/scooter_repository.dart';
import '../models/scooter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.title});

  final String title;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const LatLng _kMapCenter = LatLng(41.6422800, 41.6339200);
  static const CameraPosition _kInitialPosition = CameraPosition(target: _kMapCenter, zoom: 13.0, tilt: 0, bearing: 0);

  GoogleMapController? _controller;
  Future<List<ScooterInfo>>? _scootersInfoFuture;
  final _scooterRepository = ScooterRepository();

  int? _selectedId;

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _controller = controller;
    String value = await DefaultAssetBundle.of(context).loadString('assets/map_style.json');
    _controller!.setMapStyle(value);
  }

  BitmapDescriptor _unSelectedMarkerIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor _selectedMarkerIcon = BitmapDescriptor.defaultMarker;

  Set<Marker> _createMarker(List<ScooterInfo> data) {
    return {
      for (ScooterInfo scooter in data)
        Marker(
          icon: _selectedId == scooter.id ? _selectedMarkerIcon : _unSelectedMarkerIcon,
          markerId: MarkerId(scooter.id.toString()),
          position: LatLng(scooter.lat.toDouble(), scooter.long.toDouble()),
          infoWindow: InfoWindow(
            title: scooter.model.brand,
            snippet: "${scooter.fuel} % charge",
          ),
          onTap: () {
            setState(() {
              _selectedId = scooter.id;
            });
          },
        ),
    };
  }

  @override
  void initState() {
    _addCustomMarkerIcon();
    super.initState();
    _scootersInfoFuture = _scooterRepository.getScootersInfo();
  }

  void _addCustomMarkerIcon() async {
    _unSelectedMarkerIcon =
        await BitmapDescriptor.fromAssetImage(const ImageConfiguration(size: Size(2.0, 2.0)), "assets/marker_icon.png");

    setState(() {});

    _selectedMarkerIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(20.0, 20.0)), "assets/selected_marker_icon.png");

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        body: FutureBuilder(
          future: _scootersInfoFuture,
          builder: (BuildContext context, AsyncSnapshot<List<ScooterInfo>> snapshot) {
            if (snapshot.hasError) {
              return const Text('Error');
            } else if (snapshot.hasData) {
              return SafeArea(
                child: GoogleMap(
                    initialCameraPosition: _kInitialPosition,
                    mapToolbarEnabled: false,
                    onMapCreated: _onMapCreated,
                    markers: _createMarker(snapshot.data!),
                    myLocationEnabled: true,
                    zoomControlsEnabled: false,
                    buildingsEnabled: true,
                    onTap: (_) => setState(() => _selectedId = null)),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      Positioned(
        right: 190,
        left: 20,
        top: 90,
        child: Image.asset('assets/logo.png'),
      ),
    ]);
  }
}
