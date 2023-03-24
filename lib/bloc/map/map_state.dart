part of 'map_bloc.dart';

 class MapState extends Equatable {
  final bool isMapInitialized;
  final bool isFollowingUser;
  final bool ShowMyRoute;
  final Map<String , Polyline> polyline;

  const MapState({
    this.ShowMyRoute= true, 
    this.isMapInitialized = false, 
    this.isFollowingUser= true,
    Map<String , Polyline>? polyline
 }):polyline = polyline ?? const {};
  
   MapState copyWith({
    bool? isMapInitialized,
    bool? isFollowingUser,
    bool? ShowMyRoute,
    Map<String , Polyline>? polyline
   })=> MapState(
    isMapInitialized: isMapInitialized ?? this.isMapInitialized,
    isFollowingUser: isFollowingUser ?? this.isFollowingUser,
    ShowMyRoute: ShowMyRoute ?? this.ShowMyRoute,
    polyline: polyline ?? this.polyline
   );


  @override
  List<Object> get props => [isMapInitialized,isFollowingUser,polyline,ShowMyRoute];
}


