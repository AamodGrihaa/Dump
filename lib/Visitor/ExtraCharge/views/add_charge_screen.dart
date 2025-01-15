import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/Visitor/ExtraCharge/bloc/extra_charge_bloc.dart';
import 'package:test/Visitor/ExtraCharge/bloc/extra_charge_event.dart';

class AddChargeScreen extends StatefulWidget {
  @override
  _AddChargeScreenState createState() => _AddChargeScreenState();
}

class _AddChargeScreenState extends State<AddChargeScreen> {
  String? selectedFlat;
  String? selectedVisitor;
  final TextEditingController _descriptionController = TextEditingController();

  final flats = ['A-101', 'B-202', 'C-303'];
  final visitors = ['John Doe', 'Jane Smith', 'Sam Wilson'];

  // Define the new color palette
  final Color blueSky = Color(0xFF87CEEB);
  final Color lightBlue = Color(0xFFB0E0E6);
  final Color lightPink = Color(0xFFFDB6B6);
  final Color lightYellow = Color(0xFFFFFACD);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Extra Charge'),
        backgroundColor: blueSky,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Select Flat',
                filled: true,
                fillColor: lightBlue,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
              ),
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
              decoration: InputDecoration(
                labelText: 'Select Visitor',
                filled: true,
                fillColor: lightPink,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
              ),
              items: visitors.map((String visitor) {
                return DropdownMenuItem<String>(
                  value: visitor,
                  child: Text(visitor),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedVisitor = value;
                });
              },
            ),
            SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Charge Description',
                filled: true,
                fillColor: lightYellow,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (selectedFlat == null ||
                    selectedVisitor == null ||
                    _descriptionController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please fill all fields.'),
                      backgroundColor: lightPink,
                    ),
                  );
                  return;
                }

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
                          // Dispatch BLoC event
                          context.read<ExtraChargeBloc>().add(
                                AddNewCharge(
                                  flat: selectedFlat!,
                                  visitor: selectedVisitor!,
                                  description: _descriptionController.text,
                                ),
                              );
                          Navigator.pop(context); // pop the AddChargeScreen
                        },
                        child: Text('Yes'),
                      ),
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: blueSky,
                foregroundColor: Colors.white,
              ),
              child: Text('Add Charge'),
            ),
          ],
        ),
      ),
    );
  }
}
