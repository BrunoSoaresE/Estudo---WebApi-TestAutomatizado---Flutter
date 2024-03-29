import 'dart:async';

import 'package:bytebanksalvamentointerno/components/carregando.dart';
import 'package:bytebanksalvamentointerno/components/response_dialog.dart';
import 'package:bytebanksalvamentointerno/components/transaction_auth_dialog.dart';
import 'package:bytebanksalvamentointerno/http/interceptors/webclients/transactions_webclient.dart';
import 'package:bytebanksalvamentointerno/models/contato.dart';
import 'package:bytebanksalvamentointerno/models/transacao.dart';
import 'package:bytebanksalvamentointerno/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TransactionForm extends StatefulWidget {
  final Contato contact;

  TransactionForm(this.contact);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final String transactionId = Uuid().v4();
  bool _sending = false;

  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Carregando(),
                ),
                visible: _sending,
              ),
              Text(
                widget.contact.nome,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.numeroConta.toString(),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(labelText: 'Value'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: RaisedButton(
                    child: Text('Transfer'),
                    onPressed: () {
                      final double value =
                      double.tryParse(_valueController.text);
                      final transactionCreated =
                      Transaction(transactionId, value, widget.contact);

                      showDialog(
                          context: context,
                          builder: (contextDialog) {
                            return TransactionAuthDialog(
                              onConfirm: (String password) {

                                _save(dependencies.transactionWebClient,transactionCreated, password, context);
                              },
                            );
                          });
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _save(TransactionWebClient webClient,Transaction transactionCreated, String password,
      BuildContext context) async {
    Transaction transaction = await _send(
        webClient,transactionCreated, password, context);


    _showSucessfulMensager(transaction, context);
  }

  Future _showSucessfulMensager(Transaction transaction,
      BuildContext context) async {
    if (transaction != null) {
      await showDialog(
          context: context,
          builder: (contextDialog) {
            return SuccessDialog('successful transaction');
          });
      Navigator.pop(context);
    }
  }

  Future<Transaction> _send(TransactionWebClient webClient,Transaction transactionCreated, String password,
      BuildContext context) async {

    setState(() {
      _sending = true;
    });

    final Transaction transaction =
    await webClient.save(transactionCreated, password).catchError((e) {
      _showFailureMenseger(
          context, message: 'timeout submitting the transaction');
    }, test: (e) => e is TimeoutException).catchError((e) {
      _showFailureMenseger(context, message: e.message);
    }, test: (e) => e is HttpException).catchError((e) {
      _showFailureMenseger(context);
    }).whenComplete(() {
          setState(() {
          _sending = false;
          });
    });
    return transaction;
  }


  void _showFailureMenseger(BuildContext context,
      {String message = "Erro inesperado"}) {
    showDialog(
        context: context,
        builder: (contextDialog) {
          return FailureDialog(message);
        });
  }
}
