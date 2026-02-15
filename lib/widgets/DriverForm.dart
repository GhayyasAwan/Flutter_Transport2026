import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/driver.dart';
import 'buliTextField.dart';

void showDriverForm(BuildContext context, {
  Driver? driver,
  required Function(Map<String, dynamic> data) onSave // Changed to a single save function
}) {
  final nameController = TextEditingController(text: driver?.driverName ?? '');
  final cnicController = TextEditingController(text: driver?.driverCNIC ?? '');
  final contactController = TextEditingController(text: driver?.driverContact ?? '');

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20, right: 20, top: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(driver == null ? "Add New Driver" : "Edit Driver",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

          CustomTextField(controller: nameController, label: "Name", icon: Icons.person),
          CustomTextField(controller: cnicController, label: "CNIC", icon: Icons.badge),
          CustomTextField(controller: contactController, label: "Contact", icon: Icons.phone, isPhone: true),

          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                // Create the Map to send to API
                final Map<String, dynamic> driverData = {
                  "ID": driver?.id ?? 0, // 0 for new records
                  "DriverName": nameController.text,
                  "DriverCNIC": cnicController.text,
                  "DriverContact": contactController.text,
                  "InActive": driver?.inActive ?? false,
                };

                onSave(driverData); // Send data back to the Page
                Navigator.pop(context);
              },
              child: Text(driver == null ? "Save Driver" : "Update Driver",
                  style: const TextStyle(color: Colors.white)),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    ),
  );
}