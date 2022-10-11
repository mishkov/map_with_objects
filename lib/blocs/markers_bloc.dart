import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:map_with_objects/models/map_marker.dart';
import 'package:map_with_objects/repositories/repository.dart';

class MarkersCubit extends Cubit<MarkersState> {
  final _repository = Repository();
  final mapController = MapController();
  StreamSubscription? _mapEventSubscription;

  MarkersCubit() : super(MarkersState()) {
    _init();
  }

  void _init() {
    _mapEventSubscription = mapController.mapEventStream.listen(
      _mapEventHandler,
      onError: (error, stackTrace) {
        log(error, stackTrace: stackTrace);
      },
    );
  }

  @override
  Future<void> close() {
    mapController.dispose();
    _mapEventSubscription?.cancel();
    return super.close();
  }

  void _mapEventHandler(MapEvent event) {
    fetchMarkers();
  }

  void fetchMarkers() {
    final topLeft = mapController.bounds?.northWest;
    final center = mapController.bounds?.center;
    if (topLeft != null && center != null) {
      _repository.getAllMarkers(topLeft, center).then((markers) {
        emit(MarkersState(markers: markers));
      }, onError: (error, stackTrace) {
        emit(MarkersState(error: error));
      });
    }
  }
}

class MarkersState {
  final List<MapMarker>? markers;
  final Object? error;

  MarkersState({
    this.markers,
    this.error,
  });
}
