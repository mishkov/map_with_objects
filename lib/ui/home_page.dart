import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/markers_bloc.dart';
import 'map_builder.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MarkersCubit, MarkersState>(
        builder: (context, state) {
          return MapBuilder(state: state);
        },
      ),
    );
  }
}
