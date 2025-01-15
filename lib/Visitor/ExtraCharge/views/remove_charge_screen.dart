import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/Visitor/ExtraCharge/bloc/extra_charge_bloc.dart';
import 'package:test/Visitor/ExtraCharge/bloc/extra_charge_event.dart';

class RemoveChargeScreen extends StatefulWidget {
  @override
  _RemoveChargeScreenState createState() => _RemoveChargeScreenState();
}

class _RemoveChargeScreenState extends State<RemoveChargeScreen> {
  String? selectedFlat;
  String? selectedUser;

  final flats = ['A-101', 'B-202', 'C-303'];
  final users = ['John Doe', 'Jane Smith', 'Sam Wilson'];

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
              items: flats.map((String flat) {
                return DropdownMenuItem<String>(
                  value: flat,
                  child: Text(flat),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedFlat = value;
                });
              },
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Select User'),
              items: users.map((String user) {
                return DropdownMenuItem<String>(
                  value: user,
                  child: Text(user),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedUser = value;
                });
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (selectedFlat == null || selectedUser == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please select both flat and user.'),
                    ),
                  );
                  return;
                }

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
                          // Dispatch event
                          context.read<ExtraChargeBloc>().add(
                                RemoveCharge(
                                  flat: selectedFlat!,
                                  user: selectedUser!,
                                ),
                              );
                          Navigator.pop(context); // pop the screen
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
