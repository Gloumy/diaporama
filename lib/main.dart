import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:diaporama/screens/home_screen.dart';
import 'package:diaporama/services/hive_service.dart';
import 'package:diaporama/states/global_state.dart';
import 'package:diaporama/states/posts_state.dart';
import 'package:diaporama/states/subreddits_state.dart';
import 'package:diaporama/utils/base_theme.dart';
import 'package:diaporama/utils/secrets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sentry/sentry.dart';
import 'package:uni_links/uni_links.dart';

final SentryClient _sentry = new SentryClient(dsn: sentryDSN);

/// Reports [error] along with its [stackTrace] to Sentry.io.
Future<Null> _reportError(dynamic error, dynamic stackTrace) async {
  print('Caught error: $error');

  // Errors thrown in development mode are unlikely to be interesting. You can
  // check if you are running in dev mode using an assertion and omit sending
  // the report.
  if (isInDebugMode) {
    print(stackTrace);
    print('In dev mode. Not sending report to Sentry.io.');
    return;
  }

  print('Reporting to Sentry.io...');

  final SentryResponse response = await _sentry.captureException(
    exception: error,
    stackTrace: stackTrace,
  );

  if (response.isSuccessful) {
    print('Success! Event ID: ${response.eventId}');
  } else {
    print('Failed to report to Sentry.io: ${response.error}');
  }
}

Future<Null> main() async {
  FlutterError.onError = (FlutterErrorDetails details) async {
    if (isInDebugMode) {
      // In development mode simply print to console.
      FlutterError.dumpErrorToConsole(details);
    } else {
      // In production mode report to the application zone to report to
      // Sentry.
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };

  WidgetsFlutterBinding.ensureInitialized();

  GlobalState globalState = GlobalState();

  await HiveService.initHive();

  try {
    Uri initialLink = await getInitialUri();
    if (initialLink != null && initialLink.queryParameters["code"] != null) {
      await globalState.initApp(authCode: initialLink.queryParameters["code"]);
    } else {
      await globalState.initApp();
    }
    await globalState.subredditsState.retrieveSources();
  } catch (e) {
    throw (e);
  }

  runZoned<Future<Null>>(() async {
    runApp(MyApp(
      globalState: globalState,
    ));
  }, onError: (error, stackTrace) async {
    await _reportError(error, stackTrace);
  });
}

class MyApp extends StatelessWidget {
  final GlobalState globalState;

  const MyApp({Key key, this.globalState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GlobalState>.value(
          value: globalState,
        ),
        ChangeNotifierProvider<PostsState>.value(
          value: globalState.postsState,
        ),
        ChangeNotifierProvider<SubredditsState>.value(
          value: globalState.subredditsState,
        ),
      ],
      child: BotToastInit(
        child: MaterialApp(
          title: 'Diaporama',
          darkTheme: darkTheme,
          themeMode: ThemeMode.dark,
          home: HomeScreen(),
          navigatorObservers: [BotToastNavigatorObserver()],
        ),
      ),
    );
  }
}
