import 'package:flutter/material.dart';
import 'package:mytodoapp/models/appStateModifier.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final List select;
  final Function onDelete;

  const MyAppBar({Key key, this.title, this.select, this.onDelete})
      : super(key: key);

  @override
  _MyAppBarState createState() => _MyAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      title: Text(widget.title),
      actions: [
        IconButton(
          icon: Icon(
              Provider.of<AppStateNotifier>(context, listen: false).isDarkMode
                  ? Icons.brightness_high
                  : Icons.brightness_low),
          color: Colors.white,
          onPressed: () {
            Provider.of<AppStateNotifier>(context, listen: false).updateTheme(
                !Provider.of<AppStateNotifier>(context, listen: false)
                    .isDarkMode);
          },
        ),
        if (widget.select != null && widget.select.isNotEmpty)
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              widget.onDelete();
            },
          ),
      ],
    );
  }
}
