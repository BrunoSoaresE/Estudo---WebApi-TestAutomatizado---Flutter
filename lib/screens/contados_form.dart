import 'package:bytebanksalvamentointerno/database/dao/contato_dao.dart';
import 'package:bytebanksalvamentointerno/models/contato.dart';
import 'package:bytebanksalvamentointerno/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';

class ContatosForm extends StatefulWidget {

  @override
  _ContatosFormState createState() => _ContatosFormState();
}

class _ContatosFormState extends State<ContatosForm> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _numeroContataController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Novo contato'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(
                labelText: 'Nome completo',
              ),
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                controller: _numeroContataController,
                decoration: InputDecoration(
                  labelText: 'Número da conta',
                ),
                style: TextStyle(
                  fontSize: 24.0,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: double.maxFinite,///tamanho infinito
                child: RaisedButton(
                  onPressed: () {

                    final String name = _nomeController.text;
                    final int numeroConta = int.tryParse(_numeroContataController.text);

                    final Contato newContact = Contato(0, name, numeroConta);
                    _save(dependencies.contatoDao,newContact, context);
                  },
                  child: Text(
                    'Criar',
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _save(ContatoDao contatoDao,Contato newContact, BuildContext context) async{
    await contatoDao.save(newContact);
    Navigator.pop(context);
  }
}
