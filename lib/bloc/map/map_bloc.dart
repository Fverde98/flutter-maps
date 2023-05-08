import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/bloc/blocs.dart';
import 'package:maps_app/models/models.dart';
import 'package:maps_app/themes/themes.dart';
import 'package:maps_app/helpers/helpers.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final LocationBloc locationBloc;
  GoogleMapController? _mapController;
  LatLng? mapCenter;
  StreamSubscription<LocationState>? locationStateSubcription;

  MapBloc({required this.locationBloc}) : super( const MapState()) {
    on<OnMapInitialzedEvent>(_onInitMap );
    on<OnStartFollowingUserEvent>(_OnStartFollowingUser);
    on<OnStopFollowingUserEvent>((event, emit) => emit(state.copyWith(isFollowingUser: false)));
    on<UpdateUserPolylineEvent>(_OnPolylineNewPoint);
    on<OnToggleUserRoute>((event, emit) => emit(state.copyWith(showMyRoute: !state.showMyRoute)));
    on<DisplayPolylineEvent>((event, emit) => emit(state.copyWith(polylines: event.polylines, markers: event.markers)));
    locationBloc.stream.listen((locationState) {

      if(locationState.lastKnowLocation!= null){
        add(UpdateUserPolylineEvent(locationState.myLocationHistory));
      }


      if(!state.isFollowingUser) return;
      if(locationState.lastKnowLocation == null) return;
      moveCamera(locationState.lastKnowLocation!);
    });
  }
  void _onInitMap(OnMapInitialzedEvent event,Emitter<MapState>emit){
    _mapController = event.controller;
    _mapController!.setMapStyle(jsonEncode(uberMapTheme));
    emit(state.copyWith(isMapInitialized: true));
  }

  void _OnStartFollowingUser(OnStartFollowingUserEvent event, Emitter<MapState>emit){

    emit(state.copyWith(isFollowingUser: true));
    if(locationBloc.state.lastKnowLocation == null) return;
    moveCamera(locationBloc.state.lastKnowLocation!);
  }
void _OnPolylineNewPoint(UpdateUserPolylineEvent event, Emitter<MapState>emit){
  final myRoute = Polyline(
    polylineId: const PolylineId('myRoute'),
    color: Colors.black,
    width: 5,
    startCap: Cap.roundCap,
    endCap: Cap.roundCap,
    points: event.userLocations
    );
    final currentPolyline = Map<String,Polyline>.from(state.polylines);
    currentPolyline['myRoute'] = myRoute;

    emit (state.copyWith(polylines: currentPolyline));
}

Future drawRoutePolyline(RouteDestination destination) async{
  final myRoute = Polyline(
    polylineId: const PolylineId('route'),
      color: Colors.black,
      width: 5,
      points: destination.points,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
    );

    double  kms = destination.distance/1000;
    kms = (kms/100).floorToDouble();
    kms /= 100;

     int tripDuration = (destination.duration/60).floorToDouble().toInt();

     final startMaker = await getStartCustomMarker(tripDuration,"Mi ubicacion");
       final endMaker = await getEndCustomMarker(kms.toInt(), destination.endPlace.text); 

    final startMarker = Marker(
      anchor: const Offset(0.1, 1),
      markerId: const  MarkerId('start'),
      position: destination.points.first,
      icon: startMaker,
      // infoWindow: const InfoWindow(
      //   title: 'Inicio',
      //   snippet:'Kms : $kms, duration $tripDuration', )
      );

    
    final endMarker = Marker(
      markerId: MarkerId('end'),
      position: destination.points.last,
      icon: endMaker,
      anchor: const Offset(0, 0),
      //  infoWindow: const InfoWindow(
      //   title: destination.endPlace.text,
      //   snippet: destination.endPlace.placeName)
      );
    final currentPolylines = Map<String, Polyline>.from(state.polylines);
    currentPolylines['route'] = myRoute;

    final currentMarkers = Map<String,Marker>.from(state.markers);
    currentMarkers['start'] = startMarker;
    currentMarkers['end'] = endMarker;
    add(DisplayPolylineEvent(currentPolylines,currentMarkers));

    // await Future.delayed(const Duration(milliseconds: 300));
     //_mapController?.showMarkerInfoWindow(const  MarkerId('start'));
}


  void moveCamera( LatLng newLocation){
    final cameraUpdate = CameraUpdate.newLatLng(newLocation);
    _mapController?.animateCamera(cameraUpdate);
  }
  @override
  Future<void> close() {
    locationStateSubcription?.cancel();
    return super.close();
  }
}
