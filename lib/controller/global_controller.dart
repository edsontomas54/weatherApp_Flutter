import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';


class GloblalController extends GetxController{
  
  //create various variables====

  final RxBool _isLoading = true.obs;
  final RxDouble _lattitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;

  // instance for them to be called
  RxBool checkLoding() => _isLoading;
  RxDouble getLongitude() => _lattitude;
  RxDouble getLatitude() => _longitude;

  @override
  void init() {
    if(_isLoading.isTrue){
      getLocation();
    }

    super.onInit();
  }


    getLocation () async {
      bool isServiceEnabled;

      //Get permision
      LocationPermission locationPermission;

      isServiceEnabled = await Geolocator.isLocationServiceEnabled();

      //return if service is not enabled

      if(!isServiceEnabled ){
        return Future.error("Location not enabled");
      }

      //status of permission

      locationPermission = await Geolocator.checkPermission();

      if(locationPermission == LocationPermission.deniedForever){
        return Future.error("Permission denied forever");
      }else if(locationPermission==LocationPermission.denied){
        // request permission

        locationPermission = await Geolocator.requestPermission();

          if(locationPermission==LocationPermission.denied){
                return Future.error("Location Permission denied");
          }
      }

      // getting the currentposition

      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
      ).then((value) =>{
        //Update the lat and long
        _lattitude.value = value.latitude,
        _longitude.value = value.longitude,
        _isLoading.value = false,
      });
    }

}