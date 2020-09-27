import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mytodoapp/models/appStateModifier.dart';
import 'package:mytodoapp/screens/create_note_screen.dart';
import 'package:provider/provider.dart';
import 'package:mytodoapp/widgets/my_floating_button.dart';

class NoteScreen extends StatefulWidget {
  final String title;
  NoteScreen({Key key, this.title}) : super(key: key);

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(
                Provider.of<AppStateNotifier>(context, listen: false).isDarkMode
                    ? Icons.brightness_high
                    : Icons.brightness_low),
            color: Colors.white,
            onPressed: () {
              Provider.of<AppStateNotifier>(context, listen: false).updateTheme(
                  !Provider.of<AppStateNotifier>(context, listen: false)
                      .isDarkMode);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: Container(
              width: 300.0,
              height: 300.0,
              child: SvgPicture.asset('lib/assets/icon-idea.svg'),
            ),
          ),
        ],
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
              bottom: 120.0,
              right: 0,
              child: MyFloatingButton(
                icon: Icons.mic,
                onPressed: () => print('Voice'),
                color: Colors.white,
              )),
          Positioned(
            bottom: 20.0,
            right: 0,
            child: OpenContainer(
              transitionType: ContainerTransitionType.fade,
              closedElevation: 5.0,
              closedShape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(35.0)),
              ),
              closedColor: Provider.of<AppStateNotifier>(context, listen: false)
                      .isDarkMode
                  ? Colors.black
                  : Colors.white,
              transitionDuration: Duration(milliseconds: 500),
              closedBuilder: (BuildContext context, VoidCallback action) =>
                  MyFloatingButton(
                icon: Icons.add,
                color: Colors.white,
                onPressed: () => action(),
              ),
              openElevation: 5.0,
              openColor: Provider.of<AppStateNotifier>(context, listen: false)
                      .isDarkMode
                  ? Colors.black
                  : Colors.white,
              openShape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(0.0)),
              ),
              openBuilder: (BuildContext context, _) => CreateNote(),
              tappable: false,
            ),
          ),
        ],
      ),
    );
  }
}
