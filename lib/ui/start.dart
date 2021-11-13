import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myanime/ui/searchscrren.dart';
import 'package:myanime/ui/taps/manga.dart';

import 'package:myanime/ui/taps/ova.dart';
import 'package:myanime/ui/taps/top.dart';
import 'package:myanime/ui/taps/upcoming.dart';

import 'package:quick_actions/quick_actions.dart';

class StartScreen extends StatefulWidget {
  static const route = '/';
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  int _currentIndex = 0;
  bool autofocus = false;

  @override
  void initState() {
    super.initState();

    try {
      // Reading app shortcuts input
      final QuickActions quickActions = QuickActions();
      quickActions.initialize((type) {
        switch (type) {
          case 'Anime':
            setState(() => _currentIndex = 0);
            break;
          case 'search':
            setState(() {
              autofocus = true;
              _currentIndex = 3;
            });
            break;
          case 'Manga':
            setState(() => _currentIndex = 1);
            break;
          default:
            setState(() => _currentIndex = 0);
        }
      });

      Future.delayed(Duration.zero, () async {
        // Setting app shortcuts
        await quickActions.setShortcutItems(<ShortcutItem>[
          ShortcutItem(
            type: 'Anime',
            localizedTitle: "Anime",
            icon: 'baseline_play_arrow_black_24dp',
          ),
          ShortcutItem(
            type: 'search',
            localizedTitle: "search",
            icon: 'search',
          ),
          ShortcutItem(
            type: 'Manga',
            localizedTitle: "Manga",
            icon: 'manga',
          ),
        ]);
      });
    } catch (_) {
      debugPrint('could set quick actions');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          TopTap(),
          MangaTap(),
          UpcomingTap(),
          SearchScreen(autofocus: autofocus, Navigator: false),
          OvaTap(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).brightness == Brightness.light
            ? Theme.of(context).primaryColor
            : Theme.of(context).accentColor,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => _currentIndex != index
            ? setState(() => _currentIndex = index)
            : null,
        currentIndex: _currentIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'Anime',
            icon: Icon(Ionicons.play_outline),
          ),
          BottomNavigationBarItem(
            label: 'Manga',
            icon: Icon(Ionicons.book_outline),
          ),
          BottomNavigationBarItem(
            label: 'Upcoming',
            icon: Icon(Icons.access_time),
          ),
          BottomNavigationBarItem(
            label: 'Search',
            icon: Icon(Ionicons.search_outline),
          ),
          BottomNavigationBarItem(
            label: 'My List',
            icon: Icon(Ionicons.bookmark_outline),
          ),
        ],
      ),
    );
  }
}
