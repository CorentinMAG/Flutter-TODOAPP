import 'package:flutter/material.dart';

class CreateNote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Créer une note'),
      ),
      body: Container(
        child: Center(
          child: Text('Create Note'),
        ),
      ),
    );
  }
}
