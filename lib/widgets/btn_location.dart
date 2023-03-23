import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/bloc/location/location_bloc.dart';
import 'package:maps_app/bloc/map/map_bloc.dart';

import '../ui/custom_snackbar.dart';
class BtnCurrentLocation extends StatelessWidget {
  const BtnCurrentLocation({super.key});

  @override
  Widget build(BuildContext context) {
    final locationBloc = BlocProvider.of<LocationBloc>( context);
    final mapBloc = BlocProvider.of<MapBloc>(context );
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: const Icon(Icons.my_location_outlined, color: Colors.black),
          onPressed: (){
            final userLocation = locationBloc.state.lastKnowLocation;
            if(userLocation == null){
            final snack = CustomSnackbar(message: 'No hay ubicacion');
            ScaffoldMessenger.of(context).showSnackBar(snack);
            return;
            };
            // return;

            mapBloc.moveCamera(userLocation);
          },
          ),
          ),
    );
  }
}