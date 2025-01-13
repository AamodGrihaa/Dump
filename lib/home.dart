import 'package:flutter/material.dart';

void main() {
  runApp(VisitorApp());
}

class VisitorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Visitor Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: VisitorHomePage(),
    );
  }
}

class VisitorHomePage extends StatefulWidget {
  @override
  _VisitorHomePageState createState() => _VisitorHomePageState();
}

class _VisitorHomePageState extends State<VisitorHomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visitor Management'),
        actions: [
          IconButton(
            icon: Icon(Icons.attach_money),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ExtraChargeScreen(),
              ),
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Upcoming'),
            Tab(text: 'Canceled'),
            Tab(text: 'Completed'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          VisitorListScreen(title: 'Upcoming Visitors', type: 'upcoming'),
          VisitorListScreen(title: 'Canceled Visitors', type: 'canceled'),
          VisitorListScreen(title: 'Completed Visitors', type: 'completed'),
        ],
      ),
    );
  }
}

class VisitorListScreen extends StatelessWidget {
  final String title;
  final String type;

  VisitorListScreen({required this.title, required this.type});

  final List<Map<String, dynamic>> visitors = [
    {'name': 'John Doe', 'fromDate': '2025-01-15', 'toDate': '2025-01-16', 'flat': 'A-101', 'photo': null},
    {'name': 'Jane Smith', 'fromDate': '2025-01-17', 'toDate': '2025-01-18', 'flat': 'B-202', 'photo': 'https://via.placeholder.com/150'},
    {'name': 'Sam Wilson', 'fromDate': '2025-01-19', 'toDate': '2025-01-20', 'flat': 'C-303', 'photo': null},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: visitors.length,
          itemBuilder: (context, index) {
            final visitor = visitors[index];
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  backgroundImage: visitor['photo'] != null
                      ? NetworkImage(visitor['photo'])
                      : null,
                  child: visitor['photo'] == null
                      ? Text(
                          visitor['name']![0],
                          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                        )
                      : null,
                ),
                title: Text(visitor['name'] ?? ''),
                subtitle: Text('From: ${visitor['fromDate']} To: ${visitor['toDate']}\nFlat: ${visitor['flat']}'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VisitorDetailScreen(
                      name: visitor['name'] ?? '',
                      fromDate: visitor['fromDate'] ?? '',
                      toDate: visitor['toDate'] ?? '',
                      flat: visitor['flat'] ?? '',
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class VisitorDetailScreen extends StatelessWidget {
  final String name;
  final String fromDate;
  final String toDate;
  final String flat;

  VisitorDetailScreen({required this.name, required this.fromDate, required this.toDate, required this.flat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visitor Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: $name', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('Visit Duration: $fromDate to $toDate', style: TextStyle(fontSize: 16)),
                SizedBox(height: 8),
                Text('Flat to Visit: $flat', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ExtraChargeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Extra Charges'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Card(
              child: ListTile(
                title: Text('Add Extra Charge'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddChargeScreen(),
                  ),
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Remove Extra Charge'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RemoveChargeScreen(),
                  ),
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Charge List'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChargeListScreen(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddChargeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Extra Charge'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Select Flat'),
              items: ['A-101', 'B-202', 'C-303'].map((String flat) {
                return DropdownMenuItem<String>(
                  value: flat,
                  child: Text(flat),
                );
              }).toList(),
              onChanged: (value) {},
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Select Visitor'),
              items: ['John Doe', 'Jane Smith', 'Sam Wilson'].map((String visitor) {
                return DropdownMenuItem<String>(
                  value: visitor,
                  child: Text(visitor),
                );
              }).toList(),
              onChanged: (value) {},
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(labelText: 'Charge Description'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Confirm'),
                    content: Text('Are you sure to add the charge?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('No'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          // Add charge logic
                        },
                        child: Text('Yes'),
                      ),
                    ],
                  ),
                );
              },
              child: Text('Add Charge'),
            ),
          ],
        ),
      ),
    );
  }
}

class RemoveChargeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Remove Extra Charge'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Select Flat'),
              items: ['A-101', 'B-202', 'C-303'].map((String flat) {
                return DropdownMenuItem<String>(
                  value: flat,
                  child: Text(flat),
                );
              }).toList(),
              onChanged: (value) {},
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Select User'),
              items: ['John Doe', 'Jane Smith', 'Sam Wilson'].map((String user) {
                return DropdownMenuItem<String>(
                  value: user,
                  child: Text(user),
                );
              }).toList(),
              onChanged: (value) {},
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Confirm'),
                    content: Text('Are you sure to remove the charge?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('No'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          // Remove charge logic
                        },
                        child: Text('Yes'),
                      ),
                    ],
                  ),
                );
              },
              child: Text('Remove Charge'),
            ),
          ],
        ),
      ),
    );
  }
}

class ChargeListScreen extends StatelessWidget {
  final List<Map<String, String>> charges = [
    {'user': 'John Doe', 'flat': 'A-101', 'charge': 'Parking Fee'},
    {'user': 'Jane Smith', 'flat': 'B-202', 'charge': 'Maintenance Fee'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Charge List'),
      ),
      body: ListView.builder(
        itemCount: charges.length,
        itemBuilder: (context, index) {
          final charge = charges[index];
          return Card(
            child: ListTile(
              title: Text('${charge['user']} (${charge['flat']})'),
              subtitle: Text('Charge: ${charge['charge']}'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Cancel Charge'),
                    content: Text('Are you sure to cancel this charge?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('No'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          // Cancel charge logic
                        },
                        child: Text('Yes'),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
