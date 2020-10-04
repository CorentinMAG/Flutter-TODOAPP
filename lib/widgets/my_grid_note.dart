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
    //TODO: le champ isSelected dans la bdd est inutile il faut en faire un local
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
        child: Card(
          color: Color(note.color),
          child: Column(
            children: [
              if (note.title != null) Text(note.title),
              Text(note.content),
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
      ),
    );
  }
}
