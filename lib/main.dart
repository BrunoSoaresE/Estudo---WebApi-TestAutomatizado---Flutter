import 'package:bytebanksalvamentointerno/database/dao/contato_dao.dart';
import 'package:bytebanksalvamentointerno/screens/dashboard.dart';
import 'package:bytebanksalvamentointerno/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';

import 'http/interceptors/webclients/transactions_webclient.dart';

void main() {
  runApp(ByteBanckApp(contatoDao: ContatoDao(),transactionWebClient: TransactionWebClient(),));
}

class ByteBanckApp extends StatelessWidget {
  final ContatoDao contatoDao;
  final TransactionWebClient transactionWebClient;

  ByteBanckApp({@required this.contatoDao, @required this.transactionWebClient});


  @override
  Widget build(BuildContext context) {
    return AppDependencies(
      contatoDao: contatoDao,
      transactionWebClient: transactionWebClient,
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.green[900],
          accentColor: Colors.blue[700],
          buttonTheme: ButtonThemeData(
              buttonColor: Colors.blueAccent[700],
              textTheme: ButtonTextTheme.primary),
        ),
        home: Dashboard(),
      ),
    );
  }
}


