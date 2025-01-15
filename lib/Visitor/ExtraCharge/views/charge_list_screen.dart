import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/Visitor/ExtraCharge/bloc/extra_charge_bloc.dart';
import 'package:test/Visitor/ExtraCharge/bloc/extra_charge_event.dart';
import 'package:test/Visitor/ExtraCharge/bloc/extra_charge_state.dart';

class ChargeListScreen extends StatelessWidget {
  // Define the colors
  final Color blueSky = Color(0xFF87CEEB);
  final Color lightBlue = Color(0xFFB0E0E6);
  final Color lightPink = Color(0xFFFDB6B6);
  final Color lightYellow = Color(0xFFFFFACD);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Charge List'),
        backgroundColor: blueSky,
      ),
      body: BlocBuilder<ExtraChargeBloc, ExtraChargeState>(
        builder: (context, state) {
          if (state is ExtraChargeLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ExtraChargeError) {
            return Center(child: Text(state.message));
          } else if (state is ExtraChargeLoaded) {
            final charges = state.charges;
            if (charges.isEmpty) {
              return Center(child: Text('No extra charges found.'));
            }
            return ListView.builder(
              itemCount: charges.length,
              itemBuilder: (context, index) {
                final charge = charges[index];
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    tileColor: lightBlue,
                    title: Text('${charge['user']} (${charge['flat']})', style: TextStyle(color: Colors.black87)),
                    subtitle: Text('Charge: ${charge['charge']}', style: TextStyle(color: Colors.black54)),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: lightYellow,
                          title: Text('Cancel Charge', style: TextStyle(color: Colors.black)),
                          content: Text(
                            'Are you sure to cancel this charge?\n\n'
                            'User: ${charge['user']}\n'
                            'Flat: ${charge['flat']}\n'
                            'Charge: ${charge['charge']}',
                            style: TextStyle(color: Colors.black),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('No', style: TextStyle(color: lightPink)),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                // Dispatch event
                                context.read<ExtraChargeBloc>().add(
                                      CancelCharge(
                                        user: charge['user'] ?? '',
                                        flat: charge['flat'] ?? '',
                                        charge: charge['charge'] ?? '',
                                      ),
                                    );
                              },
                              child: Text('Yes', style: TextStyle(color: blueSky)),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
          return Center(child: Text('No data to display.'));
        },
      ),
    );
  }
}
