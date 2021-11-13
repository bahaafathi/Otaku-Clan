import 'package:big_tip/big_tip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_request_bloc/widgets/request_builder.dart';
import 'package:myanime/cubits/upcoming.dart';
import 'package:myanime/models/category.dart';
import 'package:myanime/models/favorite.dart';
import 'package:myanime/ui/widgets/animecard.dart';
import 'package:myanime/ui/widgets/custom_page.dart';
import 'package:myanime/ui/widgets/header_swiper.dart';
import 'package:myanime/utils/dataBase/database.dart';
import 'package:myanime/utils/photos.dart';
import '../../utils/translate.dart';
import '../widgets/loading_view.dart';

class OvaTap extends StatefulWidget {
  @override
  _OvaTapState createState() => _OvaTapState();
}

List<FavoriteModel> items = [];

bool favorite = false;

class _OvaTapState extends State<OvaTap> {
  int page = 1;
  ScrollController controller = ScrollController();
  DataBasefavorite databaseHelper = DataBasefavorite();
  FavoriteModel noteList;
  void updateListView() async {
    var data = await databaseHelper.getAllUsers();

    setState(() {
      items = data;
      if (items.isEmpty) {
        favorite = false;
      } else {
        favorite = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    updateListView();

    return favorite
        ? Scaffold(
            body: SliverPage(
              title: "Favorite",
              children: [AnimeGridView()],
              header: SwiperHeader(
                  list: List.from(SpaceXPhotos.company)..shuffle()),
            ),
          )
        : BigTip(
            title: Text(
              context.translate(
                'no favorite',
              ),
              style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            subtitle: Text(
              context.translate(
                'add favorite to show it to you ',
              ),
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: Theme.of(context).textTheme.caption.color,
                  ),
            ),
            child: Icon(Icons.add_reaction_outlined),
          );
  }
}

class AnimeGridView extends StatefulWidget {
  const AnimeGridView({
    Key key,
  }) : super(key: key);

  @override
  _AnimeGridViewState createState() => _AnimeGridViewState();
}

class _AnimeGridViewState extends State<AnimeGridView> {
  @override
  Widget build(BuildContext context) {
    return RequestBuilder<UpcomingCubit, CategoryModel>(
      onLoading: (context, state, value) => LoadingSliverView(),
      onLoaded: (context, state, value) => SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 0.7),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return AnimeCard(
              cliced: true,
              title: items[index].name,
              id: items[index].id,
              imageUrl: items[index].imageUrl,
            );
          },
          childCount: items.length,
        ),
      ),
    );
  }
}
