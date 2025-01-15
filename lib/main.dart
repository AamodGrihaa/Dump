import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Replace with your actual package name, assuming it's just "test":
import 'package:test/Visitor/visitor_details/visitor_bloc.dart';
import 'package:test/Visitor/visitor_details/visitor_event.dart';
import 'package:test/Visitor/visitor_details/visitor_home_page_views.dart';
import 'package:test/Visitor/ExtraCharge/bloc/extra_charge_bloc.dart';
import 'package:test/Visitor/ExtraCharge/bloc/extra_charge_event.dart';

void main() {
  runApp(VisitorApp());
}

class VisitorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Provide VisitorBloc
        BlocProvider<VisitorBloc>(
          create: (context) => VisitorBloc()..add(LoadVisitors()),
        ),
        // Provide ExtraChargeBloc
        BlocProvider<ExtraChargeBloc>(
          create: (context) => ExtraChargeBloc()..add(LoadChargeList()),
        ),
      ],
      child: MaterialApp(
        title: 'Visitor Management',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // Home: the visitor tabbed page
        home: VisitorHomePage(),
      ),
    );
  }
}
