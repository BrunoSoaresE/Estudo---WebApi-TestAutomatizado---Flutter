import 'package:bytebanksalvamentointerno/components/response_dialog.dart';
import 'package:bytebanksalvamentointerno/components/transaction_auth_dialog.dart';
import 'package:bytebanksalvamentointerno/main.dart';
import 'package:bytebanksalvamentointerno/models/contato.dart';
import 'package:bytebanksalvamentointerno/models/transacao.dart';
import 'package:bytebanksalvamentointerno/screens/contatos_list.dart';
import 'package:bytebanksalvamentointerno/screens/dashboard.dart';
import 'package:bytebanksalvamentointerno/screens/transaction_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../matchers/matchers.dart';
import '../mocks/mocks.dart';
import 'actions.dart';

void main() {
  testWidgets('trasferir para um contato', (tester) async {
    final mockContatoDao = MockContatoDao();
    final mockTransactionWebClient = MockTransactionWebClient();

    await tester.pumpWidget(ByteBanckApp(
      contatoDao: mockContatoDao,transactionWebClient: mockTransactionWebClient,
    ));//instancia o app


    final dashBoard = find.byType(Dashboard);// procura o widge Dashboard foi aberto
    expect(dashBoard, findsOneWidget);    // verifica se o widge Dashboard foi aberto

    final contact = Contato(0,'Bruno',1);
    when(mockContatoDao.getAllContatos()).thenAnswer((invocation) async => [contact]);    //força o retorno de um dado no getAllContatos


    await clickOnTheTransferFeatureItem(tester);// clica no btn

    await tester.pumpAndSettle();//realiza todas as minitarefas ***

    final contatList = find.byType(ContatosLista);// procura o widge ContatosLista
    expect(contatList, findsOneWidget);// verifica se o widge Dashboard foi aberto

    verify(mockContatoDao.getAllContatos()).called(1);    //verifica se a funçao foi chamada

    final contatoBruno = find.byWidgetPredicate((widget) {
      if (widget is ContatoItem) {
        return widget.contato.nome == 'Bruno' &&
            widget.contato.numeroConta == 1;
      }
      return false;
    });
    expect(contatoBruno, findsOneWidget);

    await tester.tap(contatoBruno);
    await tester.pumpAndSettle();

    final transactionForm = find.byType(TransactionForm);
    expect(transactionForm, findsOneWidget);


    final contactName = find.text('Bruno');
    expect(contactName, findsOneWidget);

    final contactAccontNumber = find.text('1');
    expect(contactAccontNumber, findsOneWidget);


    final textFielValue = find.byWidgetPredicate((widget) => textFildMatcherBylabelText(widget,'Value'));
    expect(textFielValue, findsOneWidget);
    await tester.enterText(textFielValue, '200');

    final transferBtn =  find.widgetWithText(RaisedButton, 'Transfer');
    expect(transferBtn, findsOneWidget);
    await tester.tap(transferBtn);
    await tester.pumpAndSettle();//realiza todas as minitarefas ***


    final transactionAuthDialog = find.byType(TransactionAuthDialog);
    expect(transactionAuthDialog, findsOneWidget);


    final transactionAuthDialogAuthenticateTextFildPass = find.byKey(TransactionAuthDialogAuthenticateTextFildPass);
    expect(transactionAuthDialogAuthenticateTextFildPass, findsOneWidget);
    await tester.enterText(transactionAuthDialogAuthenticateTextFildPass, '1000');



    final calcelButton = find.widgetWithText(FlatButton,'Cancelar');
    expect(calcelButton, findsOneWidget);


    final confirmButton = find.widgetWithText(FlatButton,'Confirmar');
    expect(confirmButton, findsOneWidget);


    when(mockTransactionWebClient.save(Transaction(null,200,contact), '1000')).thenAnswer((_) async => Transaction(null,200,contact));// verifica se o widge Dashboard foi aberto
    
    
    await tester.tap(confirmButton);
    await tester.pumpAndSettle();//realiza todas as minitarefas ***



    final sucessDialog = find.byType(SuccessDialog);
    expect(sucessDialog, findsOneWidget);


    final okBtn = find.widgetWithText(FlatButton, 'Ok');
    expect(okBtn, findsOneWidget);
    await tester.tap(okBtn);
    await tester.pumpAndSettle();//realiza todas as minitarefas ***



    final contactsListBack = find.byType(ContatosLista);
    expect(contactsListBack, findsOneWidget);




  });
}
