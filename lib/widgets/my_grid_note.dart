import 'package:flutter/material.dart';
import 'package:mytodoapp/models/note.dart';

class MyGridNote extends StatefulWidget {
  final Note note;
  final Function addToSelect;
  final Function removeFromSelect;

  const MyGridNote(
      {Key key, this.note, this.addToSelect, this.removeFromSelect})
      : super(key: key);
  @override
  _MyGridNoteState createState() => _MyGridNoteState();
}

class _MyGridNoteState extends State<MyGridNote> {
  @override
  Widget build(BuildContext context) {
    final Note note = widget.note;
    return InkWell(
      onTap: () => print(note.toString()),
      onLongPress: () {
        setState(
          () {
            if (note.isSelected == 0) {
              note.isSelected = 1;
              widget.addToSelect(note);
            } else {
              note.isSelected = 0;
              widget.removeFromSelect(note);
            }
          },
        );
      },
      child: Container(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              child: Card(
                elevation: 1.0,
                color: Color(note.color),
                child: Column(
                  children: [
                    if (note.title != null)
                      Text(
                        note.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.headline6.color),
                      ),
                    Text(note.content),
                  ],
                ),
              ),
            ),
            note.isSelected == 1
                ? Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.black,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
