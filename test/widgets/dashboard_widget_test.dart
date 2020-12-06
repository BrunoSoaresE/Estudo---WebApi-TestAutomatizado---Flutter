import 'package:bytebanksalvamentointerno/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter/cupertino.dart';

import '../matchers/matchers.dart';

void main() {
  testWidgets('Testar se imagem principal é mostrado na tela dashboard',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));

    ///sobe a instancia da tela desejada
    final mainImage = find.byType(Image);

    ///procura uma imagem
    expect(mainImage, findsOneWidget);

    ///verifica se a algum widge com a imagem
  });

  testWidgets('Testar btn "Transceferencia" ', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));

    ///sobe a instancia da tela desejada
//    final iconTransferBtn = find.widgetWithIcon(FeatureItem,Icons.monetization_on); ///procura a class FeatureItem e o icone
//    expect(iconTransferBtn, findsOneWidget); ///verifica se um ou mais
//    final nameTransferBtn = find.widgetWithText(FeatureItem,'Transceferencia'); ///procura a class FeatureItem e o texto
//    expect(nameTransferBtn, findsOneWidget); ///verifica se tem um

    final transferBtn = find.byWidgetPredicate((widget) =>
        featureItemMatcher(widget, 'Transceferencia', Icons.monetization_on));

    expect(transferBtn, findsOneWidget);

    ///verifica se tem um
  });

  testWidgets('Testar btn "feed" ', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));

    ///sobe a instancia da tela desejada

    final nameFeedBtn = find.byWidgetPredicate(
        (widget) => featureItemMatcher(widget, 'Feed', Icons.description));
    expect(nameFeedBtn, findsOneWidget);

    ///verifica se tem um
  });
}
