import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';

import '../blocs/markers_bloc.dart';
import 'map_image.dart';

class LoadingMarkersView extends StatelessWidget {
  const LoadingMarkersView({
    Key? key,
    required this.mapOptions,
  }) : super(key: key);

  final MapOptions mapOptions;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MarkersCubit>();
    
    return FlutterMap(
      mapController: cubit.mapController,
      options: mapOptions,
      children: const [
        MapImage(),
        Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ],
    );
  }
}
