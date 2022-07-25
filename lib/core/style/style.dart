import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_model/core/const/colors.dart';

TextStyle sFont({Color color = greenColor}) {
  return GoogleFonts.blinker(
    color: color,
    fontWeight: FontWeight.w600,
    fontSize: 20,
  );
}
