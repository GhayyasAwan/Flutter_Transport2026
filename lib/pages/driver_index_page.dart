import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_pos/helper_classes/toast.dart';
import '../core/api_manager.dart';
import '../core/api_routes.dart';
import '../core/api_service.dart';
import '../models/driver.dart';
import '../widgets/DriverForm.dart';
import '../widgets/entity_index_page.dart';

class DriverIndexPage extends StatefulWidget {
  const DriverIndexPage({super.key});

  @override
  State<DriverIndexPage> createState() => _DriverIndexPageState();
}

class _DriverIndexPageState extends State<DriverIndexPage> {
  // 1. Change dynamic to Driver for type safety
  List<Driver> _drivers = [];
  List<Driver> _filteredDrivers=[];
  bool _isLoading = true; // 2. Define at class level

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchDrivers();
    });
  }

  void searchDrivers(String keyword)
  {
List<Driver> results=[];
if(keyword.isEmpty)
  {
    results=_drivers;
  }
else
  {
    results = _drivers
        .where((driver) =>
    driver.driverName.toLowerCase().contains(keyword.toLowerCase()) ||
        driver.driverContact.contains(keyword) ||
        driver.driverCNIC.contains(keyword))
        .toList();
  }
  setState(() => _filteredDrivers=results) ;
  }
  Future<void> _handleSave(Map<String, dynamic> data) async {
    // Your C# route is "drivers/{id}"
    // If it's a new record, data['ID'] should be 0
    final int id = data['ID'] ?? 0;
    final String url = "${ApiRoutes.drivers}/$id";
    debugPrint("URL: $url");
    debugPrint("Data: $data");
    debugPrint("ID: $id");

    final result = await ApiManager.call<Map<String, dynamic>>(
      context,
      loadingMessage: "Saving to Xeon Server...",
      request: () => ApiService.put(url, data), // Always use PUT as per your C# attribute
    );

    if (result != null && result["Success"] == true)
    {
      _fetchDrivers(); // Refresh the list to show changes
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result["Message"] ?? "Record Saved!")),
      );
    } else
    {
      Toast.error(context, result?["Message"] ?? "Failed to save record");
      debugPrint(result?["Message"] ?? "Failed to save record");
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text(result?["Message"] ?? "Failed to save record"),
      //     backgroundColor: Colors.red,
      //   )
      //   ,
      // );
    }
  }
  Future<void> _fetchDrivers() async {
    setState(() => _isLoading = true); // Start loading

    final response = await ApiManager.call<dynamic>(
      context,
      loadingMessage: "Fetching Drivers...",
      request: () => ApiService.get(ApiRoutes.drivers),
    );

    if (response != null && response is List) {
      setState(() {
        // 3. Explicitly map to Driver objects
        var data=response.map((json) => Driver.fromJson(json)).toList();
        _drivers = data;
        _filteredDrivers=data;
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // 4. Explicitly tell the widget it is handling <Driver>
    return EntityIndexPage<Driver>(
      title: "Drivers",
      items: _filteredDrivers,
      isLoading: _isLoading,         // Added missing param
      onRefresh: _fetchDrivers,     // Added missing param
      onAddPressed: () => showDriverForm(
          context,
          onSave: (data) =>  (data, isEdit: false)
      ),
      onSearch: searchDrivers,
      itemBuilder: (Driver driver) { // Type the parameter here
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 2),
          child: ListTile(
            onTap:(){ Toast.success(context, "Driver Details");},
            leading: CircleAvatar(
              backgroundColor: driver.inActive ? Colors.grey : Colors.green,
              child: const Icon(Icons.person, color: Colors.white),
            ),
            title: Text(
              driver.driverName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("📞 ${driver.driverContact}"),
                Text("🆔 ${driver.driverCNIC}"),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
            IconButton(
            icon: const Icon(Icons.edit, color: Colors.blue),
            onPressed: () => showDriverForm(
                context,
                driver: driver,
                onSave: (data) => _handleSave(data)
            ),),
                IconButton(onPressed: () {print("Delete Driver");}, icon: const Icon(Icons.delete, color: Colors.red)),
              ],
            ),
          ),
        );
      },
    );
  }
}