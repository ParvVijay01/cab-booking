import 'package:cab_booking/global/global.dart';
import 'package:cab_booking/splashScreen/splash_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CarInfoScreen extends StatefulWidget {
  const CarInfoScreen({super.key});

  @override
  State<CarInfoScreen> createState() => _CarInfoScreenState();
}

class _CarInfoScreenState extends State<CarInfoScreen> {
  TextEditingController carModelTextEditingController = TextEditingController();
  TextEditingController carNumberTextEditingController =
      TextEditingController();
  TextEditingController carColorEditingController = TextEditingController();
  List<String> carTypeList = ["uber-x", "uber-go", "bike"];
  String? selectedCarType;

  saveCarInfo() {
    Map driverCarInfoMap = {
      "car_color": carColorEditingController.text.trim(),
      "car_number": carNumberTextEditingController.text.trim(),
      "car_model": carModelTextEditingController.text.trim(),
      "type": selectedCarType
    };

    DatabaseReference driverRef =
        FirebaseDatabase.instance.ref().child("drivers");
    driverRef
        .child(currentFirebaseUser!.uid)
        .child("car_details")
        .set(driverCarInfoMap);

    Fluttertoast.showToast(msg: "Car details has been saved successfully");

    Navigator.push(
        context, MaterialPageRoute(builder: (c) => const MySplashScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Image.asset("assets/logo1.png"),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Car Details",
                style: TextStyle(
                    fontSize: 26,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: carModelTextEditingController,
                style: const TextStyle(color: Colors.grey),
                decoration: const InputDecoration(
                  labelText: "Car Model",
                  hintText: "Car Model",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),
              TextField(
                controller: carNumberTextEditingController,
                style: const TextStyle(color: Colors.grey),
                decoration: const InputDecoration(
                  labelText: "Car Number",
                  hintText: "Car Number",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),
              TextField(
                controller: carColorEditingController,
                style: const TextStyle(color: Colors.grey),
                decoration: const InputDecoration(
                  labelText: "Car Color",
                  hintText: "Car Color",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              DropdownButton(
                iconSize: 25,
                dropdownColor: Colors.black,
                hint: const Text(
                  "Please choose car Type",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                value: selectedCarType,
                onChanged: (newValue) {
                  setState(
                    () {
                      selectedCarType = newValue.toString();
                    },
                  );
                },
                items: carTypeList.map(
                  (car) {
                    return DropdownMenuItem(
                      value: car,
                      child: Text(
                        car,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    );
                  },
                ).toList(),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  if (carColorEditingController.text.isNotEmpty &&
                      carNumberTextEditingController.text.isNotEmpty &&
                      carModelTextEditingController.text.isNotEmpty &&
                      selectedCarType != null) {
                    saveCarInfo();
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreenAccent),
                child: const Text(
                  "Save Car Info",
                  style: TextStyle(color: Colors.black54, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
