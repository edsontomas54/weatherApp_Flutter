import 'package:flutter/material.dart';
import 'package:weatherapp_starter_project/controller/global_controller.dart';
import 'package:weatherapp_starter_project/widgets/header_widge.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({Key? key}) : super(key: key);
  

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Calling the controller
  final GloblalController globlalController = Get.put(GloblalController() , permanent: true);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: Obx(() =>
          globlalController.checkLoding().isTrue ? 
          const Center(
            child: CircularProgressIndicator(),
          ) : ListView(
            scrollDirection: Axis.vertical,
            children: const [
              SizedBox(
                height: 20,
              ),
              const HeaderWidget(),
            ],
          ))
      )
    );
  }
}