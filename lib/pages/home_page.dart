import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_pos/core/api_manager.dart';
import 'package:my_pos/helper_classes/toast.dart';
import 'package:my_pos/pages/vehicle_index_page.dart';
import '../actionButton.dart';
import '../controllers/dashboard_controller.dart';
import '../helper_classes/notify.dart';
import '../widgets/AppBar.dart';
import '../widgets/dashboardCard.dart';
import '../widgets/gridCard.dart';
import 'driver_index_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<DashboardStat> _stats = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_)
    {
      _fetchStats(); _isLoading=false;
    });
   //  // Initial load
  }

  // This handles both the FAB click and the Pull-to-Refresh
  Future<void> _fetchStats() async {
    setState(() => _isLoading = true);
    final data = await ApiManager.call(context,
        request: DashboardController.getStats,
        loadingMessage: "Fetching Stats..."
    );

    if (mounted && data != null) { // Add null check
      setState(() {
        _stats = data; // Remove the !
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
    }
  }

  final List<Color> _cardColors = [
    Colors.green,
    Colors.red,
    Colors.indigo,
    Colors.purpleAccent,
    Colors.orange,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShimmerAppBar(title: widget.title),
      // 1. Wrap with RefreshIndicator
      body: RefreshIndicator(
        onRefresh: _fetchStats,
        color: Colors.green,
        child: SingleChildScrollView(
          // 2. physics: AlwaysScrollableScrollPhysics ensures pull-to-refresh
          // works even if the content is shorter than the screen.
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // 3. Dynamic Dashboard Cards Section
              _isLoading && _stats.isEmpty
                  ? const Center(child: Padding(
                padding: EdgeInsets.all(20.0),
                child: CircularProgressIndicator(),
              ))
                  : Wrap(
                alignment: WrapAlignment.center,
                spacing: 20, // Reduced spacing for better fit
                runSpacing: 20,
                children: _stats.asMap().entries.map((entry) {
                  int idx = entry.key;
                  var stat = entry.value;
                  return DashboardCard(
                    title: stat.title,
                    initialValue: stat.value,
                    accentColor: _cardColors[idx % _cardColors.length],
                  );
                }).toList(),
              ),

              const SizedBox(height: 10),

              // Divider Line
              Container(
                width: double.infinity,
                height: 1.0,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
              ),

              // Action Buttons Section
              ActionGridCard(children: [
                GlobalIconButton(
                  buttonText: "Drivers",
                  icon: Icons.person_3,
                  color: Colors.blueAccent,
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const DriverIndexPage()))
                ),
                GlobalIconButton(
                  buttonText: "Vehicles",
                  icon: Icons.bus_alert,
                  color: Colors.blue,
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const VehicleIndexPage()))
                ),
                // ... Add your other buttons here
              ]),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        alignment: Alignment.center,
        child: const Text(
          'Developed By Ali g Essential Pvt. Ltd. Multan',
          style: TextStyle(color: Colors.black38, fontSize: 12),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchStats,
        tooltip: 'Refresh',
        backgroundColor: Colors.green,
        child: const Icon(Icons.refresh), // Changed to refresh icon
      ),
    );
  }
}