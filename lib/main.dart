import 'package:flutter/material.dart';
import 'package:mytodoapp/models/appStateModifier.dart';
import 'package:mytodoapp/screens/note_screen.dart';
import 'package:mytodoapp/screens/tasks_screen.dart';
import 'package:mytodoapp/themes/appTheme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider<AppStateNotifier>(
    create: (context) => AppStateNotifier(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateNotifier>(builder: (context, appState, child) {
      return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: appState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        home: MyViewPager(),
      );
    });
  }
}

class MyViewPager extends StatefulWidget {
  @override
  _MyViewPagerState createState() => _MyViewPagerState();
}

class _MyViewPagerState extends State<MyViewPager> {
  PageController _controller = PageController(initialPage: 0);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      children: [
        NoteScreen(
          title: 'Mes notes',
        ),
        TaskScreen(
          title: 'Mes tâches du jour',
        ),
      ],
    );
  }
}
