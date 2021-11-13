import 'package:big_tip/big_tip.dart';
import 'package:cherry_components/cherry_components.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_request_bloc/widgets/request_builder.dart';
import 'package:myanime/cubits/characterstuff.dart';
import 'package:myanime/cubits/details.dart';
import 'package:myanime/cubits/episodes.dart';
import 'package:myanime/cubits/news.dart';
import 'package:myanime/cubits/overview.dart';
import 'package:myanime/cubits/pictures.dart';
import 'package:myanime/cubits/recommendation.dart';
import 'package:myanime/cubits/review.dart';
import 'package:myanime/models/characters.dart';
import 'package:myanime/models/details.dart';
import 'package:myanime/models/episode.dart';
import 'package:myanime/models/favorite.dart';
import 'package:myanime/models/news.dart';
import 'package:myanime/models/pictures.dart';
import 'package:myanime/models/recommendation.dart';
import 'package:myanime/models/review.dart';
import 'package:myanime/ui/widgets/animecard.dart';
import 'package:myanime/ui/widgets/custom_page.dart';
import 'package:myanime/ui/widgets/header_swiper.dart';
import 'package:myanime/ui/widgets/loading_view.dart';
import 'package:myanime/ui/widgets/profile_image.dart';
import 'package:myanime/utils/browser.dart';
import 'package:myanime/utils/dataBase/database.dart';
import 'package:myanime/utils/menu.dart';
import 'package:row_collection/row_collection.dart';
import 'package:row_item/row_item.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../utils/translate.dart';

class DetailsPage extends StatefulWidget {
  final int id;
  final String title;
  final String imageUrl;
  DetailsPage({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
  });

  static const route = 'detailsPage';

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with TickerProviderStateMixin {
  TabController _controller;
  DataBasefavorite databaseHelper = DataBasefavorite();
  bool add = false;
  FavoriteModel favoriteModel;

  void insss() async {
    Map<String, dynamic> map = {
      "id": widget.id,
      "name": widget.title.toString(),
      "imageUrl": widget.imageUrl.toString(),
    };

    FavoriteModel nddd = FavoriteModel.fromJson(map);
    favoriteModel = nddd;
    await databaseHelper.savefavorite(nddd);
  }

  List<FavoriteModel> item = [];
  void updateListView() async {
    var database = await databaseHelper.getAllUsers();

    item = database;
    if (item.isNotEmpty) {
      for (int i = 0; i < item.length; i++) {
        if (item[i].id == widget.id) {
          setState(() {
            add = true;
          });
        }
      }
    }
  }

  @override
  void initState() {
    _controller = new TabController(length: 5, vsync: this);

    BlocProvider.of<PicturesCubit>(context).loadData(id: widget.id);

    BlocProvider.of<OverViewCubit>(context).loadData(id: widget.id);
    BlocProvider.of<EpisodesCubit>(context).loadData(id: widget.id);
    BlocProvider.of<ReviewCubit>(context).loadData(id: widget.id);
    BlocProvider.of<RecommendationCubit>(context).loadData(id: widget.id);
    BlocProvider.of<CharacterCubit>(context).loadData(id: widget.id);
    BlocProvider.of<NewsCubit>(context).loadData(id: widget.id);
    updateListView();

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        tooltip: "Add to favourites",
        backgroundColor: add ? Colors.red : Colors.white,
        focusColor: Colors.black,
        mouseCursor: MouseCursor.defer,
        autofocus: true,
        isExtended: true,
        child: Icon(
          Icons.add,
          size: 40,
        ),
        onPressed: () {
          setState(() {
            insss();
            if (add == true) {
              add = false;
              databaseHelper.deletfavorite(favoriteModel);
            } else {
              add = true;
            }
          });
        },
      ),
      body: DefaultTabController(
        length: 6,
        child: RequestSliverPage<PicturesCubit, AnimePictures>(
          isTaped: true,
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Overview'),
              Tab(text: 'Episodes'),
              Tab(text: 'Reviews'),
              Tab(text: 'Recommendations'),
              Tab(text: 'Characters Staff'),
              Tab(text: 'News'),
            ],
          ),
          popupMenu: Menu.home,
          title: widget.title,
          headerBuilder: (context, state, value) {
            final photos = [for (final anime in value.pictures) anime.large];

            return SwiperHeader(list: photos);
          },
          childrenBuilder: (context, state, value) => [],
          tabbarBody: TabBarView(
            // controller: _controller,
            children: [
              OverViewCard(id: widget.id),
              EpisodeCard(id: widget.id),
              ReviewsCard(id: widget.id),
              Recommendations(widget.id),
              CharacterStaff(widget.id),
              NewsCard(
                id: widget.id,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class EpisodeCard extends StatelessWidget {
  final int id;
  const EpisodeCard({
    Key key,
    this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RequestBuilder<EpisodesCubit, Episode>(
      onLoaded: (context, state, value) => ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        primary: true,
        itemBuilder: (context, index) => EpisodeCell(
          episode: value.episodes[index],
        ),
        itemCount: value.episodes.length,
      ),
      onLoading: (context, state, value) => LoadingView(),
      onError: (context, state, errorMessage) => BigTip(
        subtitle: Text(
          context.translate('spacex.other.loading_error.message'),
          style: Theme.of(context).textTheme.subtitle1,
        ),
        action: Text(
          context.translate('spacex.other.loading_error.reload'),
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold,
              ),
        ),
        actionCallback: () => context.read<EpisodesCubit>().loadData(id: id),
        child: Icon(Icons.cloud_off),
      ),
    );
  }
}

class ReviewsCard extends StatelessWidget {
  final int id;
  const ReviewsCard({
    Key key,
    this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RequestBuilder<ReviewCubit, Review>(
      onLoaded: (context, state, value) => ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        primary: true,
        itemBuilder: (context, index) => ReviewCell(
          index: index + 1,
          review: value.reviews[index],
        ),
        itemCount: value.reviews.length,
      ),
      onError: (context, state, errorMessage) => BigTip(
        subtitle: Text(
          context.translate('spacex.other.loading_error.message'),
          style: Theme.of(context).textTheme.subtitle1,
        ),
        action: Text(
          context.translate('spacex.other.loading_error.reload'),
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold,
              ),
        ),
        actionCallback: () => context.read<ReviewCubit>().loadData(id: id),
        child: Icon(Icons.cloud_off),
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final int id;
  const NewsCard({
    Key key,
    this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RequestBuilder<NewsCubit, News>(
      onLoaded: (context, state, value) => ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        primary: true,
        itemBuilder: (context, index) => NewsCell(
          news: value.articles[index],
        ),
        itemCount: value.articles.length,
      ),
      onError: (context, state, errorMessage) => BigTip(
        subtitle: Text(
          context.translate('spacex.other.loading_error.message'),
          style: Theme.of(context).textTheme.subtitle1,
        ),
        action: Text(
          context.translate('spacex.other.loading_error.reload'),
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold,
              ),
        ),
        actionCallback: () => context.read<NewsCubit>().loadData(id: id),
        child: Icon(Icons.cloud_off),
      ),
      onLoading: (context, state, value) => LoadingView(),
    );
  }
}

class OverViewCard extends StatelessWidget {
  final int id;
  const OverViewCard({
    Key key,
    this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RequestBuilder<OverViewCubit, Details>(
      onLoaded: (context, state, value) => Container(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            RowLayout.cards(
              children: <Widget>[
                rocketCard(value, context),
                value.hasVideo ? videoCard(value, context) : SizedBox(),
                epCard(value, context),
              ],
            ),
          ],
        ),
      ),
      onInit: (context, state) => Text('Iniiit'),
      onLoading: (context, state, value) => LoadingView(),
      onError: (context, state, errorMessage) => BigTip(
        subtitle: Text(
          context.translate('spacex.other.loading_error.message'),
          style: Theme.of(context).textTheme.subtitle1,
        ),
        action: Text(
          context.translate('spacex.other.loading_error.reload'),
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold,
              ),
        ),
        actionCallback: () => context.read<OverViewCubit>().loadData(id: id),
        child: Icon(Icons.cloud_off),
      ),
    );
  }

  Widget videoCard(Details details, BuildContext context) {
    //final RocketVehicle _rocket = context.watch<VehiclesCubit>().getVehicle(id);
    return CardCell(
      child: YoutubePlayer(
        controller: YoutubePlayerController(
          initialVideoId: YoutubePlayer.convertUrlToId(details.trailerUrl),
          flags: YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
            hideControls: true,
          ),
        ),
        liveUIColor: Colors.amber,
        showVideoProgressIndicator: true,
        progressColors: ProgressBarColors(playedColor: Colors.red),
      ),
    );
  }

  Widget epCard(Details details, BuildContext context) {
    //final RocketVehicle _rocket = context.watch<VehiclesCubit>().getVehicle(id);
    return CardCell.body(
      context,
      title: 'Test',

      //title: details.titleEnglish,
      child: RowLayout(children: <Widget>[
        RowItem.text(
          'Source',
          details.source,
        ),
        RowItem.text(
          'Episodes',
          details.episodes != null ? details.episodes.toString() : 'N/A',
        ),
        RowItem.text(
          'Duration per ep',
          details.duration,
        ),
        RowItem.text(
          'String',
          details.aired.string,
        ),
        // RowItem.text(
        //   'From',
        //   details.aired.from,
        // ),
        RowItem.text(
          'To',
          details.aired.to ?? 'N/A',
        ),

        Separator.divider(),
        Container(
          height: 70,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => CardCell(
              padding: EdgeInsets.all(7),
              child: InkWell(
                onTap: () => context.openUrl(details.genres[index].url),
                child: Center(
                  child: Text(details.genres[index].name),
                ),
              ),
            ),
            itemCount: details.genres.length,
          ),
        ),
        //ExpandText(details.synopsis ?? 'Null From Api')
      ]),
    );
  }

  Widget rocketCard(Details details, BuildContext context) {
    //final RocketVehicle _rocket = context.watch<VehiclesCubit>().getVehicle(id);
    return CardCell.body(
      context,
      title: details.title,
      child: RowLayout(children: <Widget>[
        RowItem.text(
          'Type',
          details.type,
        ),
        RowItem.text(
          'Rank',
          details.rank.toString(),
        ),
        RowItem.text(
          'Score',
          details.score.toString(),
        ),
        RowItem.text(
          'Rating',
          details.rating,
        ),
        RowItem.boolean(
          'Airing',
          details.airing,
        ),
        Separator.divider(),
        ExpandText(details.synopsis ?? 'Null From Api')
      ]),
    );
  }
}

class EpisodeCell extends StatelessWidget {
  final Episodes episode;
  final int index;

  const EpisodeCell({
    Key key,
    this.episode,
    this.index,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DetailsCell(
            leading: episode.episodeId.toString(),
            title: episode.title,
            subtitle: episode.filler ? 'Filler' : null,
            // body: episode.titleJapanese,
            onTap: () => context.openUrl(episode.forumUrl)),
        Separator.divider(indent: 16),
      ],
    );
  }
}

class ReviewCell extends StatelessWidget {
  final Reviews review;
  final int index;

  const ReviewCell({
    Key key,
    this.review,
    this.index,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DetailsCell(
            leading: index.toString(),
            title: review.reviewer.username,
            subtitle: review.date,
            body: review.content,
            onTap: () => context.openUrl(review.reviewer.url)),
        Separator.divider(indent: 16),
      ],
    );
  }
}

class NewsCell extends StatelessWidget {
  final Articles news;

  const NewsCell({this.news, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      ListCell(
        leading: ProfileImage.small(news.imageUrl),
        title: news.title,
        subtitle: news.date,
        trailing: TrailingText(news.comments.toString()),
        onTap: () => context.openUrl(news.url),
      ),
      Separator.divider(indent: 72)
    ]);
  }
}

class Recommendations extends StatelessWidget {
  final int id;
  const Recommendations(this.id);

  @override
  Widget build(BuildContext context) {
    return RequestBuilder<RecommendationCubit, Recommendation>(
      onLoading: (context, state, value) => LoadingView(),
      onLoaded: (context, state, value) => GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) => AnimeCard(
            cliced: true,
            imageUrl: value.recommendations[index].imageUrl,
            id: value.recommendations[index].malId,
            title: value.recommendations[index].title),
        itemCount: value.recommendations.length,
      ),
      onError: (context, state, errorMessage) => BigTip(
        subtitle: Text(
          context.translate('spacex.other.loading_error.message'),
          style: Theme.of(context).textTheme.subtitle1,
        ),
        action: Text(
          context.translate('spacex.other.loading_error.reload'),
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold,
              ),
        ),
        actionCallback: () =>
            context.read<RecommendationCubit>().loadData(id: id),
        child: Icon(Icons.cloud_off),
      ),
    );
  }
}

class CharacterStaff extends StatelessWidget {
  final int id;
  const CharacterStaff(this.id);

  @override
  Widget build(BuildContext context) {
    return RequestBuilder<CharacterCubit, Character>(
      onLoading: (context, state, value) => LoadingView(),
      onLoaded: (context, state, value) => GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) => AnimeCard(
          cliced: false,
          imageUrl: value.characters[index].imageUrl,
          id: value.characters[index].malId,
          title: value.characters[index].name,
        ),
        itemCount: value.characters.length,
      ),
      onError: (context, state, errorMessage) => BigTip(
        subtitle: Text(
          context.translate('spacex.other.loading_error.message'),
          style: Theme.of(context).textTheme.subtitle1,
        ),
        action: Text(
          context.translate('spacex.other.loading_error.reload'),
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold,
              ),
        ),
        actionCallback: () => context.read<CharacterCubit>().loadData(id: id),
        child: Icon(Icons.cloud_off),
      ),
    );
  }
}
