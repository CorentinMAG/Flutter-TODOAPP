import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mytodoapp/blocs/note_bloc.dart';
import 'package:mytodoapp/models/note.dart';
import 'package:mytodoapp/screens/create_note_screen.dart';
import 'package:mytodoapp/widgets/floatting_buttons.dart';
import 'package:mytodoapp/widgets/my_app_bar.dart';
import 'package:mytodoapp/widgets/my_grid_note.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key key}) : super(key: key);
  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen>
    with AutomaticKeepAliveClientMixin<NoteScreen> {
  List<Note> selectedNote = [];
  NotesBloc _noteBloc = NotesBloc();
  ScrollController _gridController = ScrollController();

  @override
  void didChangeDependencies() {
    _noteBloc = NotesBloc();
    super.didChangeDependencies();
  }

  void goNext() {
    Timer(Duration(milliseconds: 300),
        () => _gridController.jumpTo(_gridController.position.maxScrollExtent));
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
                controller: _gridController,
                crossAxisSpacing: 8.0,
                children: List.generate(
                  snapshot.data.length,
                  (index) {
                    final Note note = snapshot.data[index];
                    goNext();
                    return MyGridNote(
                      key: Key(note.id.toString()),
                      addToSelect: (note) => addToSelect(note),
                      removeFromSelect: (note) => removeFromSelect(note),
                      note: note,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateNote(
                            note: note,
                            bloc: _noteBloc,
                          ),
                        ),
                      ),
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
      floatingActionButton: FloattingButtons(noteBloc: _noteBloc, isNote: true),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
