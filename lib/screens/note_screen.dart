import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mytodoapp/blocs/note_bloc.dart';
import 'package:mytodoapp/models/appStateModifier.dart';
import 'package:mytodoapp/models/note.dart';
import 'package:mytodoapp/screens/create_note_screen.dart';
import 'package:mytodoapp/widgets/my_app_bar.dart';
import 'package:mytodoapp/widgets/my_grid_note.dart';
import 'package:provider/provider.dart';
import 'package:mytodoapp/widgets/my_floating_button.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key key}) : super(key: key);
  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  List<Note> selectedNote = [];
  NotesBloc _noteBloc = NotesBloc();

  @override
  void didChangeDependencies() {
    _noteBloc = NotesBloc();
    super.didChangeDependencies();
  }

  void addToSelect(Note note) {
    setState(() {
      selectedNote.add(note);
    });
  }

  void removeFromSelect(Note note) {
    setState(() {
      selectedNote.remove(note);
    });
  }

  void clearSelected() {
    selectedNote.forEach((note) {
      _noteBloc.deleteNote(note);
    });
    setState(() {
      selectedNote.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Mes notes",
        select: selectedNote,
        onDelete: clearSelected,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: StreamBuilder<List<Note>>(
          stream: _noteBloc.noteStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.count(
                crossAxisCount: 2,
                children: List.generate(
                  snapshot.data.length,
                  (index) {
                    final Note note = snapshot.data[index];
                    return MyGridNote(
                      key: Key(note.id.toString()),
                      addToSelect: (note) => addToSelect(note),
                      removeFromSelect: (note) => removeFromSelect(note),
                      note: note,
                    );
                  },
                ),
              );
            }
            return Center(
                child: SvgPicture.asset(
              'lib/assets/icon-idea.svg',
              width: 500.0,
              height: 500.0,
            ));
          },
        ),
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
              child: _myOpenContainer(context, _noteBloc)),
        ],
      ),
    );
  }
}

Widget _myOpenContainer(context, _noteBloc) {
  return OpenContainer(
    transitionType: ContainerTransitionType.fade,
    closedElevation: 5.0,
    closedShape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(35.0)),
    ),
    closedColor:
        Provider.of<AppStateNotifier>(context, listen: false).isDarkMode
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
    openColor: Provider.of<AppStateNotifier>(context, listen: false).isDarkMode
        ? Colors.black
        : Colors.white,
    openShape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(0.0)),
    ),
    openBuilder: (BuildContext context, _) => CreateNote(bloc: _noteBloc),
    tappable: false,
  );
}
