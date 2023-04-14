part of 'map_bloc.dart';

 class MapState extends Equatable {
  final bool isMapInitialized;
  final bool isFollowingUser;
  final bool ShowMyRoute;
  final Map<String , Polyline> polylines;

  const MapState({
    this.ShowMyRoute= true, 
    this.isMapInitialized = false, 
    this.isFollowingUser= true,
    Map<String , Polyline>? polylines
 }):polylines = polylines ?? const {};
  
   MapState copyWith({
    bool? isMapInitialized,
    bool? isFollowingUser,
    bool? ShowMyRoute,
    Map<String , Polyline>? polylines
   })=> MapState(
    isMapInitialized: isMapInitialized ?? this.isMapInitialized,
    isFollowingUser: isFollowingUser ?? this.isFollowingUser,
    ShowMyRoute: ShowMyRoute ?? this.ShowMyRoute,
    polylines: polylines ?? this.polylines
   );


  @override
  List<Object> get props => [isMapInitialized,isFollowingUser,polylines,ShowMyRoute];
}


