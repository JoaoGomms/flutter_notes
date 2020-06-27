import 'package:flutter/material.dart';


Widget builNoteEditor(controller) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        style: TextStyle(
            fontSize: 26, color: Color(0xFF2C2D39),
        ),
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Começe seu texto por aqui",
            hintStyle: TextStyle(fontSize: 26, color: Color(0x892C2D39))),
        maxLines: null,
        controller: controller,
      ),
    ),
  );
}



Widget buildTitleEditor(controller) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        maxLines: null,
        cursorColor: Colors.white,
        style: TextStyle(fontSize: 18),
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Titulo da Nota",
            hintStyle: TextStyle(fontSize: 26, color: Color(0x892C2D39))),
        controller: controller,
      ),
    ),
  );
}



