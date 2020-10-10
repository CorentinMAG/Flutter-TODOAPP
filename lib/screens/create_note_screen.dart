import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mytodoapp/blocs/note_bloc.dart';
import 'package:mytodoapp/data/mycolors.dart';
import 'package:mytodoapp/models/colors.dart';
import 'package:mytodoapp/models/note.dart';

class CreateNote extends StatefulWidget {
  final NotesBloc bloc;
  final Note note;

  const CreateNote({Key key, this.bloc, this.note}) : super(key: key);

  @override
  _CreateNoteState createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  TextEditingController _inputTitleController;
  TextEditingController _inputContentController;
  Color mycolor = Colors.white38;
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _inputTitleController = TextEditingController(
        text: widget.note != null ? widget.note.title : null);
    _inputContentController = TextEditingController(
        text: widget.note != null ? widget.note.content : null);
    if (widget.note != null) {
      mycolor = Color(widget.note.color);
    }
    super.initState();
  }

  @override
  void dispose() {
    _inputTitleController.dispose();
    _inputContentController.dispose();
    super.dispose();
  }

  void _popscreen() {
    if (_inputContentController.text != '') {
      final note = Note(
          title: _inputTitleController.text == ''
              ? null
              : _inputTitleController.text,
          content: _inputContentController.text,
          isArchived: 0,
          color: mycolor.value,
          isImportant: 0);
      widget.bloc.addNote(note);
    }
    Navigator.pop(context);
  }

  _delete() {
    if (widget.note == null) {
      FocusScope.of(context).unfocus();
      Future.delayed(Duration(milliseconds: 50)).then(
        (value) => Navigator.pop(context),
      );
    } else {
      final note = Note(
          id: widget.note.id,
          title: _inputTitleController.text == ''
              ? null
              : _inputTitleController.text,
          content: _inputContentController.text,
          color: mycolor.value,
          isArchived: 0,
          isImportant: 0);
      widget.bloc.deleteNote(note);
      Navigator.pop(context);
    }
  }

  //permet d'éviter le bug avec le keyboard et l'openContainer
  Future _getFutureBool() {
    return Future.delayed(Duration(milliseconds: 50)).then(
      (_) {
        if (_inputContentController.text != '') {
          final note = Note(
              title: _inputTitleController.text == ''
                  ? null
                  : _inputTitleController.text,
              content: _inputContentController.text,
              color: mycolor.value,
              isArchived: 0,
              isImportant: 0);
          widget.bloc.addNote(note);
        }
        Navigator.pop(context);
      },
    );
  }

  void _updateNote() {
    final updatenote = Note(
        id: widget.note.id,
        title: _inputTitleController.text == ''
            ? null
            : _inputTitleController.text,
        content: _inputContentController.text,
        color: mycolor.value,
        isArchived: 0,
        isImportant: 0);
    widget.bloc.updateNote(updatenote);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (widget.note == null)
          _popscreen();
        else
          _updateNote();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Créer une note'),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                FocusScope.of(context).unfocus();
                if (widget.note == null)
                  _getFutureBool();
                else
                  _updateNote();
              }),
          actions: [
            IconButton(
              icon: Icon(
                Icons.archive,
                color: Colors.white,
              ),
              onPressed: () => {print('archived')},
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onPressed: () => _delete(),
            ),
          ],
        ),
        body: _AddNoteForm(),
      ),
    );
  }

  Widget _TitleInput(context, controller, color) {
    return TextField(
      controller: controller,
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.text,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).textTheme.headline6.color),
      decoration: InputDecoration(
        fillColor: color,
        hintText: 'Titre...',
        hintStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.headline6.color),
        filled: true,
        border: InputBorder.none,
      ),
    );
  }

  Widget _ContentInput(context, controller, color) {
    return TextField(
      controller: controller,
      autofocus: true,
      maxLines: 30,
      style: TextStyle(color: Theme.of(context).textTheme.headline6.color),
      decoration: InputDecoration(
        fillColor: color,
        hintText: 'Contenu...',
        hintStyle:
            TextStyle(color: Theme.of(context).textTheme.headline6.color),
        filled: true,
        border: InputBorder.none,
      ),
    );
  }

  Widget _ListChoiceColor(List<NoteColor> items) {
    return Container(
      height: 105.0,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            final NoteColor color = items[index];
            return GestureDetector(
              onTap: () {
                setState(() {
                  mycolor = color.color;
                });
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    height: 30.0,
                    width: 30.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color.color,
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  Widget _AddNoteForm() {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: _TitleInput(context, _inputTitleController, mycolor),
                ),
                SliverToBoxAdapter(
                  child:
                      _ContentInput(context, _inputContentController, mycolor),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 30.0,
            child: _ListChoiceColor(availableColors),
            color: Color.fromRGBO(245, 245, 245, 0.4),
          )
        ],
      ),
    );
  }
}
