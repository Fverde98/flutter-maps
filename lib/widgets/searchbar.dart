

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/bloc/location/location_bloc.dart';
import 'package:maps_app/bloc/map/map_bloc.dart';
import 'package:maps_app/bloc/search/search_bloc.dart';
import 'package:maps_app/models/search_result.dart';

import '../delegates/delegates.dart';
class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc,SearchState>(
      builder: (context,state){
        return state.displayManualMarker
        ? const SizedBox()
        : FadeInDown(
          duration: Duration(milliseconds: 300),
          child: const _SearchBarBody());
      });
  }
}
class _SearchBarBody extends StatelessWidget {
  const _SearchBarBody({super.key});

void OnSearchResult(BuildContext context,  SearchResult result)async{
  
  final searchBloc= BlocProvider.of<SearchBloc>(context);
  final mapBloc = BlocProvider.of<MapBloc>(context);
  final locationBloc = BlocProvider.of<LocationBloc>(context);
  if(result.manual == true){
    searchBloc.add(OnActivateManualMarkerEvent());
    return;
  }
  if(result.position != null){
    final destination = await searchBloc.getCoorsStartToEnd(locationBloc.state.lastKnowLocation!, result.position!);
    await mapBloc.drawRoutePolyline(destination);
  }
}


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
        child: GestureDetector(
          onTap: () async{
           final result= await showSearch(context: context, delegate: SearchDestinationDelegate());
           if(result == null) return;
           OnSearchResult(context ,result);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 13),
            child: const Text('Donde quieres ir' , style: TextStyle(color: Color.fromARGB(221, 142, 141, 141))),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
                boxShadow: const [BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0,5)
                )]
                ),
                
          ),
         
          
          ),
      ),
    );
  }
}