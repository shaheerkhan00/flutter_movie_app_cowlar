import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app_cowlar/screens/tabscreen.dart';

void main() {
  group('TabScreen Widget Tests', () {
    testWidgets('TabScreen should have a BottomNavigationBar',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: TabScreen()));

      expect(find.byType(BottomNavigationBar), findsOneWidget);
    });

    testWidgets('TabScreen should have 4 BottomNavigationBarItem',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: TabScreen()));

      expect(find.byType(BottomNavigationBarItem), findsNWidgets(4));
    });

    testWidgets('TabScreen should have 2 SvgPicture with color white',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: TabScreen()));

      expect(
          find.byWidgetPredicate((widget) =>
              widget is SvgPicture &&
              widget.pictureProvider.toString() ==
                  'AssetBundlePictureProvider(bundle: PlatformAssetBundle#7be63(), name: "assets/icons/Ellipse 37.svg")'),
          findsNWidgets(4));
    });
  });
}
