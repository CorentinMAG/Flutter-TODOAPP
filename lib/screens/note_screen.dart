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
  String currentTheme = 'jour';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: DropdownButton(
              items: <String>[
                currentTheme == 'jour' ? 'Mode nuit' : 'Mode jour'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String newValue) {
                setState(() {
                  currentTheme = newValue == 'Mode nuit' ? 'nuit' : 'jour';
                });
                Provider.of<AppStateNotifier>(context, listen: false)
                    .updateTheme(
                        !Provider.of<AppStateNotifier>(context, listen: false)
                            .isDarkMode);
              },
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
            ),
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
              closedColor: Colors.white,
              transitionDuration: Duration(milliseconds: 500),
              closedBuilder: (BuildContext context, VoidCallback action) =>
                  MyFloatingButton(
                icon: Icons.add,
                color: Colors.white,
                onPressed: () => action(),
              ),
              openElevation: 5.0,
              openShape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(33.0)),
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
