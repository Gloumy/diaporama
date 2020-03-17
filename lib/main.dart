import 'package:diaporama/screens/home_screen.dart';
import 'package:diaporama/states/global_state.dart';
import 'package:diaporama/states/posts_state.dart';
import 'package:diaporama/states/subreddits_state.dart';
import 'package:diaporama/utils/base_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_links/uni_links.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GlobalState globalState = GlobalState();

  try {
    Uri initialLink = await getInitialUri();
    if (initialLink != null && initialLink.queryParameters["code"] != null) {
      await globalState.initApp(authCode: initialLink.queryParameters["code"]);
    } else {
      await globalState.initApp();
    }
  } catch (e) {
    throw (e);
  }
  runApp(MyApp(
    globalState: globalState,
  ));
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
      child: MaterialApp(
        title: 'Diaporama',
        darkTheme: darkTheme,
        themeMode: ThemeMode.dark,
        home: HomeScreen(),
      ),
    );
  }
}
