import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/bloc/blocs.dart';
import 'package:maps_app/themes/themes.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final LocationBloc locationBloc;
  GoogleMapController? _mapController;
  StreamSubscription<LocationState>? locationStateSubcription;

  MapBloc({required this.locationBloc}) : super( const MapState()) {
    on<OnMapInitialzedEvent>(_onInitMap );
    on<OnStartFollowingUserEvent>(_OnStartFollowingUser);
    on<OnStopFollowingUserEvent>((event, emit) => emit(state.copyWith(isFollowingUser: false)));
    on<UpdateUserPolylineEvent>(_OnPolylineNewPoint);
    on<OnToggleUserRoute>((event, emit) => emit(state.copyWith(ShowMyRoute: !state.ShowMyRoute)));

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
    final currentPolyline = Map<String,Polyline>.from(state.polyline);
    currentPolyline['myRoute'] = myRoute;

    emit (state.copyWith(polyline: currentPolyline));
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
