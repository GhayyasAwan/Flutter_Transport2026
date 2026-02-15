import 'package:flutter/material.dart';

class EntityIndexPage<T> extends StatefulWidget {
  final String title;
  final List<T> items;
  final Widget Function(T item) itemBuilder;
  final Function(String) onSearch;
  final VoidCallback onAddPressed;
  final VoidCallback? onRefresh; // Added for pull-to-refresh logic
  final bool isLoading;         // Added to show a loading state

  const EntityIndexPage({
    super.key,
    required this.title,
    required this.items,
    required this.itemBuilder,
    required this.onSearch,
    required this.onAddPressed,
    this.onRefresh,
    this.isLoading = false, // Defaults to false
  });

  @override
  State<EntityIndexPage<T>> createState() => _EntityIndexPageState();
}

class _EntityIndexPageState<T> extends State<EntityIndexPage<T>> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 1. Search Bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              onChanged: widget.onSearch,
              decoration: InputDecoration(
                hintText: "Search ${widget.title}...",
                prefixIcon: const Icon(Icons.search, color: Colors.green),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),

          // 2. Main Content Area
          Expanded(
            child: widget.isLoading
                ? const Center(child: CircularProgressIndicator(color: Colors.green))
                : widget.items.isEmpty
                ? _buildEmptyState()
                : RefreshIndicator(
              onRefresh: () async => widget.onRefresh?.call(),
              child: ListView.separated(
                // Added bottom padding (80) so FAB doesn't block the last item
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 80),
                itemCount: widget.items.length,
                separatorBuilder: (context, index) => const SizedBox(height: 4),
                itemBuilder: (context, index) {
                  return widget.itemBuilder(widget.items[index]);
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: widget.onAddPressed,
        backgroundColor: Colors.green,
        elevation: 4,
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }

  // Professional Empty State Widget
  Widget _buildEmptyState() {
    return Center(
      child: SingleChildScrollView( // Allows "Pull to refresh" on empty screen
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inventory_2_outlined, size: 100, color: Colors.grey[300]),
            const SizedBox(height: 20),
            Text(
              "No ${widget.title} Found",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54),
            ),
            const SizedBox(height: 8),
            const Text("Try changing your search or add a new record."),
            if (widget.onRefresh != null)
              TextButton.icon(
                onPressed: widget.onRefresh,
                icon: const Icon(Icons.refresh, color: Colors.green),
                label: const Text("Refresh Now", style: TextStyle(color: Colors.green)),
              )
          ],
        ),
      ),
    );
  }
}