// lib/models/driver.dart
class Driver {
  final int id;
  final String driverName;
  final String driverCNIC;
  final String driverContact;
  final bool inActive;

  Driver({required this.id, required this.driverName, required this.driverCNIC,
    required this.driverContact, required this.inActive});

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['ID'],
      driverName: json['DriverName'] ?? '',
      driverCNIC: json['DriverCNIC'] ?? '',
      driverContact: json['DriverContact'] ?? '',
      inActive: json['InActive'] ?? false,
    );
  }
}

// lib/models/vehicle_view_model.dart
class VehicleViewModel {
  final int id;
  final String vehicleTitle;
  final String driverName;
  final String registrationDate;
  final bool inActive;

  VehicleViewModel({required this.id, required this.vehicleTitle,
    required this.driverName, required this.registrationDate, required this.inActive});

  factory VehicleViewModel.fromJson(Map<String, dynamic> json) {
    return VehicleViewModel(
      id: json['ID'],
      vehicleTitle: json['VehicleTitle'] ?? '',
      driverName: json['DriverName'] ?? '',
      registrationDate: json['RegistrationDate'] ?? '',
      inActive: json['InActive'] ?? false,
    );
  }
}