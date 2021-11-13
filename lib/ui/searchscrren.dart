import 'package:big_tip/big_tip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_request_bloc/widgets/request_builder.dart';
import 'package:myanime/cubits/search.dart';
import 'package:myanime/models/search.dart';
import 'package:myanime/ui/widgets/loading_view.dart';
import 'package:myanime/ui/widgets/vehicle_cell.dart';
import '../utils/translate.dart';

class SearchScreen extends StatefulWidget {
  static const route = 'search';
  bool auto;
  bool navigator;
  SearchScreen({autofocus, Navigator}) {
    navigator = Navigator;
    auto = autofocus;
  }

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: widget.auto,
          enabled: true,
          decoration:
              InputDecoration(border: InputBorder.none, hintText: 'Search'),
          controller: controller,
          onChanged: (value) => value.length >= 3
              ? context.read<SearchCubit>().loadData(query: value)
              : null,
        ),
        leading: IconButton(
          onPressed: () {
            _clearSearch();
            if (widget.navigator == true) {
              Navigator.pop(context);
            }
            widget.auto = false;
          },
          icon: Icon(Icons.clear, color: Colors.white),
        ),
      ),
      body: RequestBuilder<SearchCubit, Search>(
        onInit: (context, state) => BigTip(
          title: Text(
            context.translate(
              'spacex.vehicle.title',
            ),
            style: Theme.of(context).textTheme.headline6.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          subtitle: Text(
            context.translate(
              'spacex.search.suggestion.vehicle',
            ),
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: Theme.of(context).textTheme.caption.color,
                ),
          ),
          child: Icon(Icons.search),
        ),
        onError: (context, state, errorMessage) => BigTip(
          title: Text(
            context.translate(
              'spacex.vehicle.title',
            ),
            style: Theme.of(context).textTheme.headline6.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          subtitle: Text(
            context.translate(
              'spacex.search.failure',
            ),
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: Theme.of(context).textTheme.caption.color,
                ),
          ),
          child: Icon(Icons.sentiment_dissatisfied),
        ),
        onLoaded: (context, state, value) => ListView.builder(
          itemCount: value.results.length,
          itemBuilder: (context, index) => AnimeCell(value.results[index]),
        ),
        onLoading: (context, state, value) => LoadingView(),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _clearSearch() {
    setState(() {
      controller.clear();
    });
  }
}
