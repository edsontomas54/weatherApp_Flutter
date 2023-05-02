import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp_starter_project/controller/global_controller.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {

  String city ="";
  String date = DateFormat("yMMMMd").format(DateTime.now());

  @override
  void initState(){
     //Calling the controller to get the lat and log
  final GloblalController globlalController = Get.put(GloblalController() , permanent: true);

    getAddress(globlalController.getLatitude().value, globlalController.getLongitude().value);

    super.initState();
  }

  //Get address

  getAddress(lat , lon) async {
    List<Placemark> placemark = await placemarkFromCoordinates(lat, lon);

    Placemark place = placemark[0];

    //will set the place here
    setState(() {
      city = place.locality!;
    });
  }


@override
Widget build(BuildContext context) {
  return Column(
    children: [
      Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        alignment: Alignment.topLeft,
        child: Text(
          city,
          style: const TextStyle(
            fontSize: 35,
            height: 2,
          ),
        ),
      ),
       Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        alignment: Alignment.topLeft,
        child: Text(
          date,
          style: const TextStyle( fontSize: 14, color: Colors.grey,height: 1.5),
        ),
      ),
    ],
  );
}
}