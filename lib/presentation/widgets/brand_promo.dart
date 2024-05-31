import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BrandPromo extends StatelessWidget {
  final Color color;

  const BrandPromo({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/icons/cutlery.png', width: 100, height: 100),
        const SizedBox(
          height: 40,
        ),
        Text(
          "FirfirTera",
          style: GoogleFonts.firaSans(
            fontSize: 40,
            fontWeight: FontWeight.w600,
            color: color ?? Colors.black,
          ),
        ),
        Text(
          "Taste, Share, Create: Recipe Harmony.",
          style: TextStyle(
            fontSize: 15,
            color: color ?? Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
