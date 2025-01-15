import 'package:flutter/material.dart';
import 'package:test/Visitor/ExtraCharge/views/add_charge_screen.dart';
import 'package:test/Visitor/ExtraCharge/views/remove_charge_screen.dart';
import 'package:test/Visitor/ExtraCharge/views/charge_list_screen.dart';

class ExtraChargeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> charges = [
    {
      'title': 'Add Extra Charge',
      'icon': Icons.add,
    },
    {
      'title': 'Remove Extra Charge',
      'icon': Icons.remove,
    },
    {
      'title': 'Charge List',
      'icon': Icons.list,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Extra Charges'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.0,
          ),
          itemCount: charges.length,
          itemBuilder: (context, index) {
            var charge = charges[index];
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: InkWell(
                onTap: () {
                  switch (charge['title']) {
                    case 'Add Extra Charge':
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddChargeScreen()));
                      break;
                    case 'Remove Extra Charge':
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RemoveChargeScreen()));
                      break;
                    case 'Charge List':
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChargeListScreen()));
                      break;
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(charge['icon'], size: 40),
                    SizedBox(height: 8),
                    Text(charge['title'], textAlign: TextAlign.center),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
