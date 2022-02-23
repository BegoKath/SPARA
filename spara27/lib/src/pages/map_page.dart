import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  late GoogleMapController mapController;

  String currentLocation = "";
  Position position = Position(
      longitude: 0,
      latitude: 0,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0);
  final Set<Marker> _markers = {};
  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        children: const [
          Image(
            image: NetworkImage(
                "https://res.cloudinary.com/dvpl8qsgd/image/upload/v1639900999/SPARA/Property_1_Default_iuphlt.png"),
            fit: BoxFit.contain,
            height: 50,
          ),
        ],
      )),
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text("Puntos para Depositos",
                style: GoogleFonts.robotoSlab(
                    color: Colors.white,
                    textStyle: Theme.of(context).textTheme.headline5)),
          ),
          Stack(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(10),
                height: 360,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.cyan,
                      width: 5,
                    ),
                    color: Theme.of(context).secondaryHeaderColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    )),
                child: GoogleMap(
                  markers: _markers,
                  myLocationEnabled: true,
                  mapType: MapType.normal,
                  onMapCreated: onMapCreated,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(position.latitude, position.longitude),
                      zoom: 3.0),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  onTap: () {
                    _goTienda(-0.107621, -78.470619, "Tienda 1");
                  },
                  leading: const Icon(Icons.home, color: Colors.white),
                  title: Text("Tienda 1",
                      style: GoogleFonts.robotoSlab(
                          color: Colors.white,
                          textStyle: Theme.of(context).textTheme.bodyText1)),
                  trailing:
                      const Icon(Icons.arrow_forward_ios, color: Colors.cyan),
                ),
                ListTile(
                  onTap: () {
                    _goTienda(-0.104488, -78.469374, "Tienda 2");
                  },
                  leading: const Icon(Icons.home, color: Colors.white),
                  title: Text("Tienda 2",
                      style: GoogleFonts.robotoSlab(
                          color: Colors.white,
                          textStyle: Theme.of(context).textTheme.bodyText1)),
                  trailing:
                      const Icon(Icons.arrow_forward_ios, color: Colors.cyan),
                ),
                ListTile(
                  onTap: () {
                    _goTienda(-0.107546, -78.475296, "Tienda 3");
                  },
                  leading: const Icon(Icons.home, color: Colors.white),
                  title: Text("Tienda 3",
                      style: GoogleFonts.robotoSlab(
                          color: Colors.white,
                          textStyle: Theme.of(context).textTheme.bodyText1)),
                  trailing:
                      const Icon(Icons.arrow_forward_ios, color: Colors.cyan),
                ),
                ListTile(
                  onTap: () {
                    _goTienda(-0.104413, -78.479931, "Tienda 4");
                  },
                  leading: const Icon(Icons.home, color: Colors.white),
                  title: Text("Tienda 4",
                      style: GoogleFonts.robotoSlab(
                          color: Colors.white,
                          textStyle: Theme.of(context).textTheme.bodyText1)),
                  trailing:
                      const Icon(Icons.arrow_forward_ios, color: Colors.cyan),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }

  Future<Position> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          currentLocation = "Permission Denied";
        });
      } else {
        var position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        setState(() {
          currentLocation =
              "latitude: ${position.latitude} Logitude: ${position.longitude}";
        });
      }
    } else {
      var position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        currentLocation =
            "latitude: ${position.latitude} Logitude: ${position.longitude}";
      });
    }
    return position;
  }

  Future<void> _goTienda(double lat, double long, String lugar) async {
    mapController
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), 15));
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(lugar),
          position: LatLng(lat, long),
        ),
      );
    });
  }
}
