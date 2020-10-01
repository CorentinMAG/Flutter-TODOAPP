import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mytodoapp/data/mycolors.dart';
import 'package:mytodoapp/models/colors.dart';
import 'package:mytodoapp/models/database.dart';
import 'package:mytodoapp/models/note.dart';

class CreateNote extends StatefulWidget {
  @override
  _CreateNoteState createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  final InputTitleController = TextEditingController();
  final InputContentController = TextEditingController();
  Color mycolor = Colors.white38;
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    InputTitleController.dispose();
    InputContentController.dispose();
    super.dispose();
  }

  Future<bool> _popscreen() async {
    if (InputContentController.text != '') {
      final note = Note(
          title: InputTitleController.text == ''
              ? null
              : InputTitleController.text,
          content: InputContentController.text,
          isArchived: 0,
          color: mycolor.value,
          isImportant: 0);
      DBProvider.db.newNote(note);
    }
    Navigator.pop(context);
  }

  //permet d'éviter le bug avec le keyboard et l'openContainer
  Future _getFutureBool() {
    return Future.delayed(Duration(milliseconds: 50)).then(
      (_) {
        if (InputContentController.text != '') {
          final note = Note(
              title: InputTitleController.text == ''
                  ? null
                  : InputTitleController.text,
              content: InputContentController.text,
              color: mycolor.value,
              isArchived: 0,
              isImportant: 0);
          DBProvider.db.newNote(note);
        }
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _popscreen,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Créer une note'),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                FocusScope.of(context).unfocus();
                _getFutureBool();
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
              onPressed: () => print('deleted'),
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
                  child: _TitleInput(context, InputTitleController, mycolor),
                ),
                SliverToBoxAdapter(
                  child:
                      _ContentInput(context, InputContentController, mycolor),
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
