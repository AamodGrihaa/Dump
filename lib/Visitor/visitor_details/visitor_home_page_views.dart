import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/Visitor/visitor_details/visitor_bloc.dart';
import 'package:test/Visitor/visitor_details/visitor_state.dart';
import 'package:test/Visitor/ExtraCharge/views/extra_charge_screen.dart';

class VisitorHomePage extends StatefulWidget {
  @override
  _VisitorHomePageState createState() => _VisitorHomePageState();
}

class _VisitorHomePageState extends State<VisitorHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Define the new color palette
  final Color primaryColor = Color(0xFF6A5ACD); // Dark blue for primary UI
  final Color secondaryColor = Color(0xFF7B68EE); // Light blue for accents
  final Color backgroundColor = Color(0xFFF8F9FA); // Light gray for background

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
        backgroundColor: primaryColor,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: secondaryColor,
          tabs: const [
            Tab(text: 'Upcoming'),
            Tab(text: 'Canceled'),
            Tab(text: 'Completed'),
          ],
        ),
      ),
      body: Container(
        color: backgroundColor,
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildVisitorList('upcoming'),
            _buildVisitorList('canceled'),
            _buildVisitorList('completed'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExtraChargeScreen(),
          ),
        ),
        child: Icon(Icons.add),
        backgroundColor: primaryColor,
      ),
    );
  }

  Widget _buildVisitorList(String type) {
    return BlocBuilder<VisitorBloc, VisitorState>(
      builder: (context, state) {
        if (state is VisitorLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is VisitorError) {
          return Center(
            child: Text(
              state.message,
              style: TextStyle(color: Colors.red, fontSize: 16),
            ),
          );
        } else if (state is VisitorLoaded) {
          List<Map<String, dynamic>> visitors;
          if (type == 'upcoming') {
            visitors = state.upcomingVisitors;
          } else if (type == 'canceled') {
            visitors = state.canceledVisitors;
          } else {
            visitors = state.completedVisitors;
          }
          return VisitorListScreen(type: type, visitors: visitors);
        } else {
          return const Center(
            child: Text('No data to display.', style: TextStyle(fontSize: 16)),
          );
        }
      },
    );
  }
}

class VisitorListScreen extends StatelessWidget {
  final String type;
  final List<Map<String, dynamic>> visitors;

  VisitorListScreen({
    required this.type,
    required this.visitors,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(12.0),
      itemCount: visitors.length,
      itemBuilder: (context, index) {
        final visitor = visitors[index];
        return Card(
          margin: EdgeInsets.only(bottom: 12),
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            tileColor: Colors.white,
            leading: CircleAvatar(
              backgroundColor: Color(0xFF7B68EE),
              backgroundImage: (visitor['photo'] != null)
                  ? NetworkImage(visitor['photo'])
                  : null,
              child: (visitor['photo'] == null)
                  ? Text(
                      (visitor['name']?[0] ?? ''),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : null,
            ),
            title: Text(
              visitor['name'] ?? '',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              'From: ${visitor['fromDate']} To: ${visitor['toDate']}\nFlat: ${visitor['flat']}',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            onTap: () => showDetailsPopup(context, visitor),
          ),
        );
      },
    );
  }

  void showDetailsPopup(BuildContext context, Map<String, dynamic> visitor) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 60,
                    height: 5,
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Text(
                  visitor['name'] ?? 'N/A',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Description: ${visitor['description'] ?? 'No additional details provided.'}',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                Text(
                  'Flat: ${visitor['flat'] ?? 'Unknown'}',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                Text(
                  'Preferred Date: ${visitor['fromDate'] ?? 'Unknown'}',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                Text(
                  'Preferred Time: ${visitor['toDate'] ?? 'Unknown'}',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF6A5ACD),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                  ),
                  onPressed: () {
                    Navigator.pop(context); // Close the modal when done
                  },
                  child: Center(
                    child: Text('Close Details', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
