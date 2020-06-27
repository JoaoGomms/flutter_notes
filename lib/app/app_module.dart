import 'package:flutter/material.dart';
import 'package:flutternotes/app/notes_list/notes.dart';
import 'package:flutternotes/app/shared/size_config.dart';

class AppModule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints){
        return OrientationBuilder(
          builder: (context, orientation){
            SizeConfig().init(constraints, orientation);
            return MaterialApp(
              home: Notes(),
            );
          },
        );
      }
    );
  }
}
