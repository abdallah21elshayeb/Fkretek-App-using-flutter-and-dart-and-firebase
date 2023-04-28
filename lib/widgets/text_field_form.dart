import 'package:flutter/material.dart';

Widget TextFieldForm(
    BuildContext context,
    TextInputType keyboardText,
    TextEditingController controller,
    String name,
    String errorText,
    int? maxlength,
    int maxline,
    Function add) {
  return TextFormField(
    controller: controller,
    validator: (value) {
      if (value!.isNotEmpty) {
        return null;
      } else {
        return errorText;
      }
    },
    keyboardType: keyboardText,
    decoration: InputDecoration(
      labelText: name,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.pink,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    maxLength: maxlength,
    maxLines: maxline,
    onSaved: (_) => add,
  );
}
