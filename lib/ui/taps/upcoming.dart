import 'package:big_tip/big_tip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_request_bloc/widgets/request_builder.dart';
import 'package:myanime/cubits/top.dart';
import 'package:myanime/cubits/upcoming.dart';
import 'package:myanime/models/category.dart';
import 'package:myanime/ui/widgets/animecard.dart';
import 'package:myanime/ui/widgets/custom_page.dart';
import 'package:myanime/ui/widgets/header_swiper.dart';
import 'package:myanime/ui/widgets/vehicle_cell.dart';
import 'package:myanime/utils/menu.dart';
import 'package:myanime/utils/photos.dart';
import 'package:search_page/search_page.dart';
import '../../utils/translate.dart';
import '../searchscrren.dart';
import '../widgets/loading_view.dart';

class UpcomingTap extends StatefulWidget {
  @override
  _UpcomingTapState createState() => _UpcomingTapState();
}

List items = [];

class _UpcomingTapState extends State<UpcomingTap> {
  int page = 1;
  ScrollController controller = ScrollController();
  @override
  void initState() {
    controller.addListener(() async {
      if (controller.position.pixels == controller.position.maxScrollExtent &&
          page < 7) {
        page++;
        List<dynamic> addlist =
            await BlocProvider.of<UpcomingCubit>(context).loadData(page: page);
        items.addAll(addlist);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RequestSliverPage<UpcomingCubit, CategoryModel>(
        controller: controller,
        popupMenu: Menu.home,
        isTaped: false,
        title: 'Upcoming Animes',
        headerBuilder: (context, state, value) =>
            SwiperHeader(list: List.from(SpaceXPhotos.company)..shuffle()),
        childrenBuilder: (context, state, value) => [
          AnimeGridView(
            value: value,
          )
        ],
      ),
      floatingActionButton: RequestBuilder<TopCubit, CategoryModel>(
        onLoaded: (context, state, value) => FloatingActionButton(
          heroTag: null,
          tooltip: context.translate(
            'spacex.other.tooltip.search',
          ),
          onPressed: () => Navigator.pushNamed(context, SearchScreen.route),
          child: Icon(Icons.search),
        ),
      ),
    );
  }
}

class AnimeGridView extends StatefulWidget {
  final value;

  const AnimeGridView({
    Key key,
    @required this.value,
  }) : super(key: key);

  @override
  _AnimeGridViewState createState() => _AnimeGridViewState();
}

class _AnimeGridViewState extends State<AnimeGridView> {
  @override
  void initState() {
    items.addAll(widget.value.top);

    super.initState();
  }

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
              title: items[index].title,
              id: items[index].malId,
              imageUrl: items[index].imageUrl,
            );
          },
          childCount: items.length,
        ),
      ),
    );
  }
}
