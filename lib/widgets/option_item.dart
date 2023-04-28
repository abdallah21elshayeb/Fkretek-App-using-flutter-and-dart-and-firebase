import 'package:flutter/material.dart';

class OptionItem extends StatelessWidget {
  final String title;
  final Color color;
  final Function add;

  OptionItem(
    this.title,
    this.color,
    this.add,
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: add as void Function()?,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: EdgeInsets.all(15),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.7), color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
