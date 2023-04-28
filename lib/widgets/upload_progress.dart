import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class UploadProgress extends StatelessWidget {
  final double progress;
  final double precentage;

  UploadProgress({required this.progress, required this.precentage});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      width: 200.0,
      child: AnimatedSwitcher(
          duration: Duration(milliseconds: 375),
          child: progress == 100.0
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_rounded,
                      color: Colors.green,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      'Upload Complete',
                      style: GoogleFonts.poppins(
                        color: Colors.green,
                      ),
                    ),
                  ],
                )
              : LiquidCircularProgressIndicator(
                  value: precentage / 100,
                  valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),
                  backgroundColor: Colors.white,
                  direction: Axis.vertical,
                  center: Text(
                    '$precentage%',
                    style: GoogleFonts.poppins(
                        color: Colors.black87, fontSize: 25.0),
                  ),
                )),
    );
  }
}
