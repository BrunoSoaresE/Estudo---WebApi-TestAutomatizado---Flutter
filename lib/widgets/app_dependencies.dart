import 'package:bytebanksalvamentointerno/database/dao/contato_dao.dart';
import 'package:bytebanksalvamentointerno/http/interceptors/webclients/transactions_webclient.dart';
import 'package:flutter/material.dart';

class AppDependencies extends InheritedWidget {

  final ContatoDao contatoDao;
  final TransactionWebClient transactionWebClient;


  AppDependencies({@required this.contatoDao,@required this.transactionWebClient, @required Widget child,})
      : super (child: child);

  static AppDependencies of(BuildContext context) =>  context.dependOnInheritedWidgetOfExactType<AppDependencies>();




  @override
  bool updateShouldNotify(AppDependencies oldWidget) {
    // TODO: implement updateShouldNotify
    return contatoDao != oldWidget.contatoDao || transactionWebClient != oldWidget.transactionWebClient;
  }


}