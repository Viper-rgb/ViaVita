import 'package:flutter/material.dart';
import 'package:workers_app/screens/apply_task_success_dialog.dart';
import 'package:workers_app/screens/profile_screen.dart';
import 'package:workers_app/screens/requirements_dialog.dart';

class MyTasksScreen extends StatefulWidget {
  const MyTasksScreen({super.key});

  @override
  State<MyTasksScreen> createState() => _MyTasksScreenState();
}

class _MyTasksScreenState extends State<MyTasksScreen> {
  int _selectedTab = 0; // 0: Accepted Task, 1: In Progress, 2: Completed
  final int _currentIndex = 2;

  final List<String> _tabs = ['Accepted Task', 'In Progress', 'Completed'];

  final List<Map<String, String>> _allTasks = [
    {
      'title': 'Masonry',
      'price': '₹12,000/-',
      'location': '123 Street, TVM',
      'description': 'Carpenter is currently building and assembling the wardrobe and shelves...',
      'status': 'Accepted Task',
    },
    {
      'title': 'Electrical Work',
      'price': '₹21,000/-',
      'location': '123 Street, TVM',
      'description': 'Living room rewiring and installation of ceiling fans and lights needed...',
      'status': 'Accepted Task',
    },
    {
      'title': 'Appliance Repair',
      'price': '₹35,000/-',
      'location': '123 Street, TVM',
      'description': 'Technician is checking the AC unit and repairing parts...',
      'status': 'Accepted Task',
    },
    {
      'title': 'Plumbing Services',
      'price': '₹8,500/-',
      'location': '456 Avenue, TVM',
      'description': 'Fixing water pipeline leaks and replacing bathroom fittings...',
      'status': 'In Progress',
    },
    {
      'title': 'Wall Painting',
      'price': '₹18,000/-',
      'location': '789 Main Rd, TVM',
      'description': 'Interior wall double-coat primer and emulsion finish completed...',
      'status': 'Completed',
    },
  ];

  List<Map<String, String>> get _filteredTasks {
    final currentStatus = _tabs[_selectedTab];
    return _allTasks.where((task) => task['status'] == currentStatus).toList();
  }

  void _onBottomNavTapped(int index) {
    if (index == _currentIndex) return;

    if (index == 0) {
      Navigator.popUntil(context, (route) => route.isFirst);
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Tasks",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              children: [
                // Tabs Row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: List.generate(_tabs.length, (index) {
                      final isSelected = _selectedTab == index;
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedTab = index;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: isSelected ? const Color(0xFFFFF7F2) : Colors.transparent,
                                border: isSelected
                                    ? Border.all(color: const Color(0xFFFFE5D8), width: 1)
                                    : null,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  _tabs[index],
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                    color: isSelected ? const Color(0xFFD32F2F) : Colors.grey.shade600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 10),

                // Task Cards List
                Expanded(
                  child: _filteredTasks.isEmpty
                      ? Center(
                          child: Text(
                            "No tasks in ${_tabs[_selectedTab]}",
                            style: const TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          itemCount: _filteredTasks.length,
                          itemBuilder: (context, index) {
                            final task = _filteredTasks[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF7F2),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: const Color(0xFFFFE5D8), width: 1),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                    onTap: () async {
                                      final result = await showDialog<String>(
                                        context: context,
                                        builder: (dialogContext) => const RequirementsDialog(),
                                      );
                                      if (result != null) {
                                        if (!context.mounted) return;
                                        showDialog(
                                          context: context,
                                          builder: (dialogContext) => const ApplyTaskSuccessDialog(),
                                        );
                                      }
                                    },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            task['title']!,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          Text(
                                            task['price']!,
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey.shade700,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on_outlined,
                                            size: 14,
                                            color: Colors.grey.shade600,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            task['location']!,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              task['description']!,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey.shade700,
                                                height: 1.3,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Icon(
                                            Icons.chevron_right,
                                            color: Colors.grey.shade500,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Center(
        heightFactor: 1.0,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: _onBottomNavTapped,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: const Color(0xFFFB8C00),
            unselectedItemColor: Colors.grey,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            unselectedLabelStyle: const TextStyle(fontSize: 12),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.assignment_outlined),
                label: 'Tasks',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_book_outlined),
                activeIcon: Icon(Icons.menu_book),
                label: 'My Tasks',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
