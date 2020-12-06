import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../matchers/matchers.dart';

Future<void> clickOnTheTransferFeatureItem(WidgetTester tester) async {
  final transferBtn = find.byWidgetPredicate((widget) =>
      featureItemMatcher(widget, 'Transceferencia', Icons.monetization_on)); /// procura o btn de Transceferencia
  expect(transferBtn, findsOneWidget); /// verifica se o btn de Transceferencia esta aberto

  return await tester.tap(transferBtn); /// clica no btn
}


Future<void> clickOnTheContato(WidgetTester tester) async {
  final transferBtn = find.byWidgetPredicate((widget) =>
      featureItemMatcher(widget, 'Transceferencia', Icons.monetization_on)); /// procura o btn de Transceferencia
  expect(transferBtn, findsOneWidget); /// verifica se o btn de Transceferencia esta aberto

  return await tester.tap(transferBtn); /// clica no btn
}

