import 'package:flutter/material.dart';
import 'package:myanime/ui/detailsscreen/details.dart';
import 'package:myanime/ui/general/about.dart';
import 'package:myanime/ui/general/changelog.dart';
import 'package:myanime/ui/general/error.dart';
import 'package:myanime/ui/general/settings.dart';
import 'package:myanime/ui/searchscrren.dart';
import 'package:myanime/ui/start.dart';
import 'package:myanime/ui/widgets/responsive_page.dart';

/// Class that holds both route names & generate methods.
/// Used by the Flutter routing system
class Routes {
  /// Methods that generate all routes
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    try {
      final Map<String, dynamic> args = routeSettings.arguments;

      switch (routeSettings.name) {
        case StartScreen.route:
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => StartScreen(),
          );

        case SearchScreen.route:
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => SearchScreen(Navigator: true, autofocus: true),
          );

        case AboutScreen.route:
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => AboutScreen(),
          );

        case ChangelogScreen.route:
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => ChangelogScreen(),
          );

        case SettingsScreen.route:
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => SettingsScreen(),
          );
        case DetailsPage.route:
          final id = args['id'] as int;
          final title = args['title'] as String;
          final imageUrl = args['imageUrl'] as String;

          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => DetailsPage(
              title: title,
              id: id,
              imageUrl: imageUrl,
            ),
          );

        default:
          return errorRoute(routeSettings);
      }
    } catch (_) {
      return errorRoute(routeSettings);
    }
  }

  /// Method that calles the error screen when neccesary
  static Route<dynamic> errorRoute(RouteSettings routeSettings) {
    return MaterialPageRoute(
      settings: routeSettings,
      builder: (_) => ErrorScreen(),
    );
  }
}

class ResponsivePageRoute extends PageRouteBuilder {
  ResponsivePageRoute({
    RouteSettings settings,
    @required WidgetBuilder builder,
    Color barrierColor = const Color(0x80000000),
    Duration transitionDuration = const Duration(milliseconds: 200),
    Curve transitionCurve = Curves.linear,
  }) : super(
          settings: settings,
          pageBuilder: (context, animation, _) => FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: transitionCurve,
            ),
            child: ResponsivePage(child: builder(context)),
          ),
          transitionDuration: transitionDuration,
          reverseTransitionDuration: transitionDuration,
          opaque: false,
          barrierDismissible: true,
          barrierColor: barrierColor,
          fullscreenDialog: true,
        );
}
