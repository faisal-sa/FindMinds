import 'package:flutter/material.dart';

Widget crInfoAppBar(TextEditingController controller, Function() fetchData) {
  return TextField(
    controller: controller,
    keyboardType: TextInputType.number,
    style: TextStyle(color: Colors.white),
    decoration: InputDecoration(
      labelText: "رقم السجل التجاري",
      labelStyle: TextStyle(
        color: Colors.blueAccent.shade100,
        fontWeight: FontWeight.w500,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blueAccent.shade100),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blueAccent.shade100, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      suffixIcon: IconButton(
        color: Colors.transparent,
        onPressed: fetchData,
        icon: Icon(Icons.search, color: Colors.blueAccent.shade100, size: 28),
      ),
    ),
    cursorColor: Colors.blueAccent.shade100,
  );
}
