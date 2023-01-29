import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_test_app/models/scooter.dart';

class ScootersMap extends StatefulWidget {
  const ScootersMap({required this.scooters, super.key});

  final List<Scooter> scooters;

  @override
  State<ScootersMap> createState() => _ScootersMapState();
}

class _ScootersMapState extends State<ScootersMap> {
  static const LatLng _kMapCenter = LatLng(41.6422800, 41.6339200);
  static const CameraPosition _kInitialPosition = CameraPosition(target: _kMapCenter, zoom: 13.0, tilt: 0, bearing: 0);
  GoogleMapController? _controller;
  int? _selectedId;

  @override
  void initState() {
    _addCustomMarkerIcon();
    super.initState();
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _controller = controller;
    String value = await DefaultAssetBundle.of(context).loadString('assets/map_style.json');
    _controller!.setMapStyle(value);
  }

  BitmapDescriptor _unSelectedMarkerIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor _selectedMarkerIcon = BitmapDescriptor.defaultMarker;

  Set<Marker> _createMarker(List<Scooter> scooters) {
    return {
      for (Scooter scooter in scooters)
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
      SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kInitialPosition,
          mapToolbarEnabled: false,
          onMapCreated: _onMapCreated,
          markers: _createMarker(widget.scooters),
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          onTap: (_) => setState(() => _selectedId = null),
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
