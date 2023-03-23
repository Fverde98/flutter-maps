import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/bloc/gps/gps_bloc.dart';


class GpsAccesScreen extends StatelessWidget {
  const GpsAccesScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:  BlocBuilder<GpsBloc,GpsState>(
          builder: (context,state){
            return 
              !state.isGpsEnabled
              ? const _EnableGpsMessage()
              : const _AccesButton();

          },)
        //_AccesButton(),
     ),
   );
  }
}

class _AccesButton extends StatelessWidget {
  const _AccesButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Es necesario el acceso al gps'),
        MaterialButton(
          child: const Text('Solicitar Acceso', style: TextStyle(color:  Colors.white)),
          color: Colors.black,
          shape: const StadiumBorder(),
          elevation: 0,
          splashColor: Colors.transparent,
          onPressed:  () {
          
            final gpsBloc = BlocProvider.of<GpsBloc>(context );
            gpsBloc.askGpsAccess();
          }
          )
      ],
    );
  }
}

class _EnableGpsMessage extends StatelessWidget {
  const _EnableGpsMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text('Debe de habilitar el GPS',
    style: TextStyle(fontSize: 25,fontWeight: FontWeight.w300),);
    
  }
}