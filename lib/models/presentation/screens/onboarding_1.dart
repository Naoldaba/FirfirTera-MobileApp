import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firfir_tera/models/presentation/widgets/brand_promo.dart';
import 'package:go_router/go_router.dart';

class OnBoarding_1 extends StatefulWidget {
  const OnBoarding_1({super.key});

  @override
  State<OnBoarding_1> createState() => _OnBoarding_1State();
}

class _OnBoarding_1State extends State<OnBoarding_1> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () => context.go('/Onboarding_2'));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: BrandPromo(
              color: Colors.black,
            )),
      ),
    );
  }
}
