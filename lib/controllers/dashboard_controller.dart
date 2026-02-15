import 'package:http/http.dart';
import 'package:my_pos/core/api_routes.dart';
import '../core/api_service.dart';

class DashboardStat {
  final String title;
  final String value;
  DashboardStat(this.title,this.value);
}

class DashboardController {
  // Static titles in the order your C# API sends them
  static const List<String> _statTitles = [
    "Total Income",
    "Total Trips",
    "Vehicles",
    "Drivers"
  ];

  static Future<List<DashboardStat>> getStats() async {
    // We use a simple GET request here
    final response = await ApiService.get(ApiRoutes.dashboardStats);

    List<DashboardStat> stats = [];

    if (response is List) {
      for (int i = 0; i < response.length; i++) {
        // Use the title from our static list if it exists, otherwise "Other"
        String title = i < _statTitles.length ? _statTitles[i] : "Stat ${i + 1}";
        stats.add(DashboardStat(title, response[i].toString()));
      }
    }
    return stats;
  }
}