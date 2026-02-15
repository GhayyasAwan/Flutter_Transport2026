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