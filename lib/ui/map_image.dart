import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class MapImage extends StatelessWidget {
  const MapImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TileLayer(
      urlTemplate:
          'https://www.google.com/maps/vt/pb=!1m4!1m3!1i{z}!2i{x}!3i{y}!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425',
      subdomains: const ['a'],
      userAgentPackageName: 'mishkov.test',
    );
  }
}
