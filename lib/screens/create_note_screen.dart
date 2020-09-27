import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mytodoapp/models/colors.dart';
import 'package:mytodoapp/models/note.dart';

class CreateNote extends StatefulWidget {
  @override
  _CreateNoteState createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  final InputTitleController = TextEditingController();
  final InputContentController = TextEditingController();

  @override
  void dispose() {
    InputTitleController.dispose();
    InputContentController.dispose();
    super.dispose();
  }

  Future<bool> _popscreen() {
    final note = Note(
        title:
            InputTitleController.text == '' ? null : InputTitleController.text,
        content: InputContentController.text,
        isArchived: false,
        isImportant: false);
    print(DateTime.now());
    print(note.toString());
    Navigator.pop(context);
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
                final note = Note(
                    title: InputTitleController.text == ''
                        ? null
                        : InputTitleController.text,
                    content: InputContentController.text,
                    isArchived: false,
                    isImportant: false);
                print(DateTime.now());
                print(note.toString());

                Navigator.pop(context);
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
        body: AddNoteForm(
            titleController: InputTitleController,
            contentController: InputContentController),
      ),
    );
  }
}

Widget _TitleInput(context, controller) {
  return TextField(
    controller: controller,
    textCapitalization: TextCapitalization.sentences,
    keyboardType: TextInputType.text,
    style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).textTheme.headline6.color),
    decoration: InputDecoration(
      hintText: 'Titre...',
      hintStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).textTheme.headline6.color),
      filled: true,
      border: InputBorder.none,
    ),
  );
}

Widget _ContentInput(context, controller) {
  return TextField(
    controller: controller,
    autofocus: true,
    maxLines: 30,
    style: TextStyle(color: Theme.of(context).textTheme.headline6.color),
    decoration: InputDecoration(
      hintText: 'Contenu...',
      hintStyle: TextStyle(color: Theme.of(context).textTheme.headline6.color),
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
            onTap: () => print(color.name),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  height: 60.0,
                  width: 60.0,
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

class AddNoteForm extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController contentController;

  const AddNoteForm({Key key, this.titleController, this.contentController})
      : super(key: key);
  @override
  _AddNoteFormState createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<AddNoteForm> {
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: _TitleInput(context, widget.titleController),
          ),
          SliverToBoxAdapter(
            child: _ContentInput(context, widget.contentController),
          ),
          // SliverToBoxAdapter(
          //   child: _ListChoiceColor(availableColors),
          // )
        ],
      ),
    );
  }
}
