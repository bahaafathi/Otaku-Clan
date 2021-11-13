import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

import 'package:myanime/ui/detailsscreen/details.dart';
import '../../ui/detailsscreen/details.dart';

class AnimeCard extends StatelessWidget {
  final String imageUrl;
  final int id;
  final String title;
  final bool cliced;
  const AnimeCard({
    @required this.imageUrl,
    @required this.id,
    @required this.title,
    @required this.cliced,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: cliced
          ? () {
              Navigator.pushNamed(
                context,
                DetailsPage.route,
                arguments: {
                  'imageUrl': imageUrl,
                  'id': id,
                  'title': title,
                },
              );
            }
          : null,
      child: new Container(
        margin: EdgeInsets.all(5),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
