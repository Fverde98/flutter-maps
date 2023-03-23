import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/bloc/blocs.dart';
import 'package:maps_app/bloc/gps/gps_bloc.dart';
import 'package:maps_app/screens/gps_acces_screen.dart';
import 'package:maps_app/screens/loading_screen.dart';
import 'package:maps_app/screens/map_screen.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => GpsBloc()),
      BlocProvider(create: (context) => LocationBloc()),
      BlocProvider(create: (context) => MapBloc()),
    ],
    child: const MapsApp(),
  ));
}

class MapsApp extends StatelessWidget {
  const MapsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Maps App',
      home:  LoadingScreen()
      );
  }
}