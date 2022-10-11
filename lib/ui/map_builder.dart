import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../blocs/markers_bloc.dart';
import '../models/map_marker.dart';
import 'loading_markers_view.dart';
import 'map_error_view.dart';
import 'map_image.dart';

class MapBuilder extends StatelessWidget {
  const MapBuilder({
    Key? key,
    required this.state,
  }) : super(key: key);

  final MarkersState state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MarkersCubit>();
    final minskPoint = LatLng(53.9006, 27.5590);

    final mapOptions = MapOptions(
      onMapReady: cubit.fetchMarkers,
      center: minskPoint,
      zoom: 10.0,
      minZoom: 2.0,
      maxZoom: 18,
      interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
    );

    if (state.error != null) {
      return const MapErrorView();
    } else if (state.markers != null) {
      final markers = state.markers!.map((e) => _mapMarkerToMarker(e)).toList();

      return FlutterMap(
        mapController: cubit.mapController,
        options: mapOptions,
        children: [
          const MapImage(),
          MarkerLayer(
            markers: markers,
          ),
        ],
      );
    } else {
      return LoadingMarkersView(mapOptions: mapOptions);
    }
  }

  Marker _mapMarkerToMarker(MapMarker marker) {
    const pointSize = 40.0;

    return Marker(
      width: pointSize,
      height: pointSize * 2,
      point: LatLng(
        marker.latitude,
        marker.longitude,
      ),
      builder: (context) {
        return const Padding(
          padding: EdgeInsets.only(bottom: pointSize / 2),
          child: Icon(
            Icons.location_pin,
            color: Colors.red,
            size: pointSize,
          ),
        );
      },
    );
  }
}
