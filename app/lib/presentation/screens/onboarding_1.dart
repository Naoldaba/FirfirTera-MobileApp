import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firfir_tera/presentation/widgets/brand_promo.dart';
// import 'package:go_router/go_router.dart';
import 'package:firfir_tera/main.dart';

class OnBoarding_1 extends StatefulWidget {
  const OnBoarding_1({Key? key}) : super(key: key);

  @override
  State<OnBoarding_1> createState() => _OnBoarding_1State();
}

class _OnBoarding_1State extends State<OnBoarding_1> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), navigateToAuthChecker);
  }

  void navigateToAuthChecker() async {
    Widget? result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AuthChecker()),
    );
    if (result != null) {
      setState(() {
        _renderedWidget = result;
      });
    }
  }

  Widget? _renderedWidget; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: _renderedWidget ?? BrandPromo(color: Colors.black),
        ),
      ),
    );
  }
}
