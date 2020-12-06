import 'package:bytebanksalvamentointerno/main.dart';
import 'package:bytebanksalvamentointerno/models/contato.dart';
import 'package:bytebanksalvamentointerno/screens/contados_form.dart';
import 'package:bytebanksalvamentointerno/screens/contatos_list.dart';
import 'package:bytebanksalvamentointerno/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../matchers/matchers.dart';
import '../mocks/mocks.dart';
import 'actions.dart';

void main(){

  testWidgets('Salvar um contato', (tester) async{
    final mockContatoDao = MockContatoDao();
    final mockTransactionWebClientContatoDao = MockTransactionWebClient();

    await tester.pumpWidget(ByteBanckApp(contatoDao: mockContatoDao,transactionWebClient: mockTransactionWebClientContatoDao,)); ///instancia o app
    final dashBoard = find.byType(Dashboard); /// procura o widge Dashboard foi aberto
    expect(dashBoard, findsOneWidget);/// verifica se o widge Dashboard foi aberto


    await clickOnTheTransferFeatureItem(tester); /// clica no btn
    await tester.pumpAndSettle(); ///realiza todas as minitarefas ***


    ///
    ///
    final contatList = find.byType(ContatosLista); /// procura o widge ContatosLista
    expect(contatList, findsOneWidget);/// verifica se o widge Dashboard foi aberto


    verify(mockContatoDao.getAllContatos()).called(1); ///verifica se a funçao foi chamada



    final fabNewContato = find.widgetWithIcon(FloatingActionButton, Icons.add);/// procura o FloatingActionButton
    expect(fabNewContato, findsOneWidget);/// verifica se o widge FloatingActionButton foi aberto

    await tester.tap(fabNewContato);
    await tester.pumpAndSettle(); ///realiza todas as minitarefas ***


    final contatoForm = find.byType(ContatosForm);/// procura o ContatosForm
    expect(contatoForm, findsOneWidget);/// verifica se o widge ContatosForm foi aberto


    final nameTextFild = find.byWidgetPredicate((widget) {
      return textFildMatcherBylabelText(widget,'Nome completo');
    });/// procura o nameTextFild
    /// 
    /// 
    expect(nameTextFild, findsOneWidget);/// verifica se o widge FloatingActionButton foi aberto
    await tester.enterText(nameTextFild, 'Alex');

    final accountNumberTextField = find.byWidgetPredicate((widget) {
      return textFildMatcherBylabelText(widget,'Número da conta');
    });
    expect(accountNumberTextField, findsOneWidget);
    await tester.enterText(accountNumberTextField, '1000');


    final createButton = find.widgetWithText(RaisedButton, 'Criar');
    expect(createButton, findsOneWidget);
    await tester.tap(createButton);
    await tester.pumpAndSettle(); ///realiza todas as minitarefas ***
    ///
    ///
    verify(mockContatoDao.save(Contato(0,'Alex',1000))); ///verifica se a funçao foi chamada

    final contactsListBack = find.byType(ContatosLista);
    expect(contactsListBack, findsOneWidget);

    verify(mockContatoDao.getAllContatos()).called(1); ///verifica se a funçao foi chamada




  });


}

