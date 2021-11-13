import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_request_bloc/widgets/request_builder.dart';
import 'package:myanime/cubits/manga.dart';

import 'package:myanime/models/manga.dart';
import 'package:myanime/ui/widgets/animecard.dart';
import 'package:myanime/ui/widgets/custom_page.dart';
import 'package:myanime/ui/widgets/header_swiper.dart';
import 'package:myanime/ui/widgets/loading_view.dart';
import 'package:myanime/utils/menu.dart';
import 'package:myanime/utils/photos.dart';

class MangaTap extends StatefulWidget {
  @override
  _MangaTapState createState() => _MangaTapState();
}

class _MangaTapState extends State<MangaTap> {
  int page = 1;
  ScrollController controller = ScrollController();
  @override
  void initState() {
    controller.addListener(() async {
      if (controller.position.pixels == controller.position.maxScrollExtent &&
          page < 7) {
        page++;
        List<dynamic> addlist =
            await BlocProvider.of<Mangacubit>(context).loadData(page: page);
        items.addAll(addlist);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RequestSliverPage<Mangacubit, Manga>(
        controller: controller,
        isTaped: false,
        popupMenu: Menu.home,
        title: 'Manga',
        headerBuilder: (context, state, value) =>
            SwiperHeader(list: List.from(SpaceXPhotos.company)..shuffle()),
        childrenBuilder: (context, state, value) => [AnimeGridView()],
      ),
    );
  }
}

List items = [];

class AnimeGridView extends StatelessWidget {
  const AnimeGridView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RequestBuilder<Mangacubit, Manga>(
      onLoading: (context, state, value) => LoadingSliverView(),
      onLoaded: (context, state, value) => AnimeGridViewLoaded(
        value: value,
      ),
    );
  }
}

class AnimeGridViewLoaded extends StatefulWidget {
  final value;

  const AnimeGridViewLoaded({
    Key key,
    this.value,
  }) : super(key: key);

  @override
  _AnimeGridViewLoadedState createState() => _AnimeGridViewLoadedState();
}

class _AnimeGridViewLoadedState extends State<AnimeGridViewLoaded> {
  @override
  void initState() {
    items.addAll(widget.value.top);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.7,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return AnimeCard(
            cliced: true,
            title: items[index].title,
            id: items[index].malId,
            imageUrl: items[index].imageUrl,
          );
        },
        childCount: items.length,
      ),
    );
  }
}
