import 'package:firfir_tera/presentation/widgets/brand_promo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BrandPromo Widget Test', () {
    testWidgets('Displays brand logo, name, and tagline with correct styling',
        (WidgetTester tester) async {
      await tester
          .pumpWidget(const MaterialApp(home: BrandPromo(color: Colors.blue)));

      expect(find.image(const AssetImage('assets/icons/cutlery.png')),
          findsOneWidget);

      expect(find.text('FirfirTera'), findsOneWidget);
      var brandNameText = tester.widget<Text>(find.text('FirfirTera').first);
      expect(brandNameText.style!.fontSize, 40);
      expect(brandNameText.style!.fontWeight, FontWeight.w600);
      expect(brandNameText.style!.color, Colors.blue); 

      expect(
          find.text('Taste, Share, Create: Recipe Harmony.'), findsOneWidget);
      var taglineText = tester.widget<Text>(
          find.text('Taste, Share, Create: Recipe Harmony.').first);
      expect(taglineText.style!.fontSize, 15);
      expect(taglineText.style!.color, Colors.blue); 
      expect(taglineText.textAlign, TextAlign.center);
    });
  });
}
