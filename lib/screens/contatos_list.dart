import 'package:bytebanksalvamentointerno/components/carregando.dart';
import 'package:bytebanksalvamentointerno/models/contato.dart';
import 'package:bytebanksalvamentointerno/screens/contados_form.dart';
import 'package:bytebanksalvamentointerno/screens/transaction_form.dart';
import 'package:bytebanksalvamentointerno/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';

class ContatosLista extends StatefulWidget {

  @override
  _ContatosListaState createState() => _ContatosListaState();
}

class _ContatosListaState extends State<ContatosLista> {

  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Transferencia'),
      ),
      body: FutureBuilder<List<Contato>>(
        initialData: List(),
        future: dependencies.contatoDao.getAllContatos(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none: //FUTURE AINDA NÃO FOI EXECUTADO
              break;
            case ConnectionState.waiting: // CARREGANDO AINDA NÃO FINALIZADO
              return Carregando(mensagem: 'Carregando');
              break;
            case ConnectionState
                .active: //jA TEM DADO MAS AINDA NÃO FINALIZOU O FUTURE EX:(dowload, pages)
              break;
            case ConnectionState.done:
              final List<Contato> listaContato = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Contato contato = listaContato[index];

                  return ContatoItem(
                    contato,
                    onClick: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TransactionForm(contato),
                        ),
                      );
                    },
                  );
                },
                itemCount: listaContato.length,
              );
              break;
          }
          return Text('Unknown error');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => ContatosForm(),
            ),
          )
              .then((id) {
            setState(() {});
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class ContatoItem extends StatelessWidget {
  final Contato contato;
  final Function onClick;

  ContatoItem(this.contato, {@required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => onClick(),
        title: Text(
          contato.nome,
          style: TextStyle(fontSize: 24.0),
        ),
        subtitle: Text(
          contato.numeroConta.toString(),
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
