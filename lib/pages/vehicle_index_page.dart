import 'package:flutter/material.dart';
import '../core/api_manager.dart';
import '../core/api_routes.dart';
import '../core/api_service.dart';
import '../models/driver.dart';
import '../widgets/entity_index_page.dart';

class VehicleIndexPage extends StatefulWidget {
  const VehicleIndexPage({super.key});

  @override
  State<VehicleIndexPage> createState() => _VehicleIndexPageState();
}

class _VehicleIndexPageState extends State<VehicleIndexPage> {
  List<dynamic> _vehicles = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchVehicles();
    });
  }

  Future<void> _fetchVehicles() async {
    final response = await ApiManager.call<dynamic>(
      context,
      loadingMessage: "Fetching Vehicles...",
      request: () => ApiService.get(ApiRoutes.vehicles), // Define this route
    );

    if (response != null && response is List) {
      setState(() {
        _vehicles = response.map((json) => VehicleViewModel.fromJson(json)).toList();
        var _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return EntityIndexPage(
      title: "Vehicles",
      items: _vehicles,
      onRefresh: _fetchVehicles,
      onAddPressed: () => print("Add Vehicle"),
      onSearch: (val) => print("Searching: $val"),
      itemBuilder: (vehicle) {
        return Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Icon(
                  Icons.local_shipping,
                  size: 40,
                  color: vehicle.inActive ? Colors.red : Colors.green
              ),
              title: Text(
                vehicle.vehicleTitle,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.person_outline, size: 16),
                      const SizedBox(width: 4),
                      Text(vehicle.driverName),
                    ],
                  ),
                  Text("📅 Reg: ${vehicle.registrationDate}"),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(onPressed: () {}, icon: const Icon(Icons.edit, color: Colors.blue)),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.delete, color: Colors.red)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}