import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:vegi/providers/address_provider.dart';

class SetLocation extends StatefulWidget {
  const SetLocation({Key? key}) : super(key: key);

  @override
  State<SetLocation> createState() => _SetLocationState();
}

class _SetLocationState extends State<SetLocation> {
  LatLng _intialcameraposition = LatLng(20.5937, 78.9629);
  GoogleMapController? controller;
  Location _location = Location();
  _onMapcreated(GoogleMapController _value) {
    controller = _value;
    _location.onLocationChanged.listen((event) {
      controller!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(event.latitude!, event.longitude!), zoom: 15)));
    });
  }

  @override
  Widget build(BuildContext context) {
    AddressProvider addressProvider=Provider.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Set Loction"),
          backgroundColor: Colors.green,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _intialcameraposition,
                ),
                mapType: MapType.normal,
                onMapCreated: _onMapcreated,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
              ),
              Positioned(
                left: 0,
                  right: 0,
                  bottom: 0,
                  child:Padding(
                    padding: const EdgeInsets.only(left: 10,bottom: 35,right: 80,top: 10),
                    child: MaterialButton(
                      onPressed: ()async{
                        await _location.getLocation().then((value){
                          setState(() {
                            addressProvider.setLoaction=value;
                          });
                        });
                        Navigator.of(context).pop();
                      },
                      child: Text("Set Location",style: TextStyle(color: Colors.white),),
                      height: 50,
                      shape: StadiumBorder(),
                      color: Colors.green,
                    ),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
