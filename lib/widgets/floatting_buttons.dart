import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:mytodoapp/blocs/note_bloc.dart';
import 'package:mytodoapp/models/appStateModifier.dart';
import 'package:mytodoapp/models/note.dart';
import 'package:mytodoapp/screens/create_note_screen.dart';
import 'package:mytodoapp/widgets/my_floating_button.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';

class FloattingButtons extends StatefulWidget {
  final NotesBloc noteBloc;
  final bool isNote;

  const FloattingButtons({Key key, this.noteBloc, this.isNote})
      : super(key: key);

  @override
  _FloattingButtonsState createState() => _FloattingButtonsState();
}

class _FloattingButtonsState extends State<FloattingButtons> {
  SpeechToText _speech;
  bool _isListening = false;
  String _text;

  @override
  void initState() {
    _speech = SpeechToText();
    super.initState();
  }

  Future<void> _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() {
          _isListening = true;
        });
        _speech.listen(
          onResult: (val) => setState(
            () {
              _text = val.recognizedWords;
            },
          ),
        );
      }
    } else {
      setState(
        () {
          _isListening = false;
          _speech.stop();
          if (widget.isNote) {
            final note = Note(
                content: _text, isArchived: 0, isImportant: 0, isSelected: 0);
            widget.noteBloc.addNote(note);
            showModalBottomSheet(
                context: context, builder: (ctx) => _buildBottom(ctx, _text));
          }
        },
      );
    }
  }

  Container _buildBottom(context, text) {
    return Container(
      height: 300.0,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.deepOrange, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 120.0,
          right: 0.0,
          child: MyFloatingButton(
            heroTag: "Voice",
            icon: _isListening ? Icons.mic : Icons.mic_none,
            onPressed: _listen,
            color: Colors.white,
          ),
        ),
        Positioned(
          bottom: 20.0,
          right: 0.0,
          child: widget.isNote
              ? _myOpenContainer(context, widget.noteBloc)
              : MyFloatingButton(
                  heroTag: "Task",
                  icon: Icons.add,
                  color: Colors.white,
                ),
        )
      ],
    );
  }
}

Widget _myOpenContainer(context, noteBloc) {
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
    openBuilder: (BuildContext context, _) => CreateNote(bloc: noteBloc),
    tappable: false,
  );
}
