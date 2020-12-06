import 'package:bytebanksalvamentointerno/components/carregando.dart';
import 'package:bytebanksalvamentointerno/components/centered_message.dart';
import 'package:bytebanksalvamentointerno/http/interceptors/webclients/transactions_webclient.dart';
import 'package:bytebanksalvamentointerno/models/transacao.dart';
import 'package:flutter/material.dart';

class TransactionsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //transactions.add(Transaction(100.0, Contato(0, 'Alex', 1000)));
    final TransactionWebClient _webClient = TransactionWebClient();


    return Scaffold(
      appBar: AppBar(
        title: Text('Feed'),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: _webClient.findAll(),
        builder: (context, snapshopt) {
          switch (snapshopt.connectionState) {
            case ConnectionState.none:
              // TODO: Handle this case.
              break;
            case ConnectionState.waiting:
              // TODO: Handle this case.
              Carregando(mensagem: 'Carregando');
              break;
            case ConnectionState.active:
              // TODO: Handle this case.
              break;
            case ConnectionState.done:
              // TODO: Handle this case.
              if(snapshopt.hasData) {
                final List<Transaction> transactions = snapshopt.data;
                if (transactions.isNotEmpty) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final Transaction transaction = transactions[index];
                      return Card(
                        child: ListTile(
                          leading: Icon(Icons.monetization_on),
                          title: Text(
                            transaction.value.toString(),
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            transaction.contact.numeroConta.toString(),
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: transactions.length,
                  );
                }
              }
              return CenteredMessage('Nenhuma transação encontrada', icon: Icons.warning,);
              break;
          }

          return CenteredMessage('Erro desconhecido');
        },
      ),
    );
  }
}
