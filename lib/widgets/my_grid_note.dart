import 'package:flutter/material.dart';
import 'package:mytodoapp/models/note.dart';

class MyGridNote extends StatefulWidget {
  final Note note;
  final Function addToSelect;
  final Function removeFromSelect;
  final Function onTap;

  const MyGridNote(
      {Key key, this.note, this.addToSelect, this.removeFromSelect, this.onTap})
      : super(key: key);
  @override
  _MyGridNoteState createState() => _MyGridNoteState();
}

class _MyGridNoteState extends State<MyGridNote> {
  @override
  Widget build(BuildContext context) {
    final Note note = widget.note;
    return InkWell(
      onTap: widget.onTap,
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
              height: 200.0,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 1.0,
                color: Color(note.color),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (note.title != null)
                        Text(
                          note.title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0,
                              color:
                                  Theme.of(context).textTheme.headline6.color),
                        ),
                      if (note.title != null)
                        SizedBox(
                          height: 15.0,
                        ),
                      Expanded(
                        child: Text(
                          note.content,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 18.0),
                          maxLines: 20,
                        ),
                      ),
                    ],
                  ),
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
