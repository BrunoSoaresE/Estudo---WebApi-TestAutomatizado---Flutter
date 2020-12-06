import 'package:bytebanksalvamentointerno/screens/transactions_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'contatos_list.dart';

class Dashboard extends StatelessWidget {

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: LayoutBuilder(
        builder: (context, constaints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constaints.maxHeight,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, //vertical
              crossAxisAlignment: CrossAxisAlignment.start, //horizontal
              children: <Widget>[
                //Image.network('https://cdn.pixabay.com/photo/2019/10/15/06/03/pinwheel-4550711_960_720.jpg'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('images/bytebank_logo.png'),
                ),

                Container(
                  height: 120,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      FeatureItem(
                        'Transceferencia',
                        Icons.monetization_on,
                        onClick: () {
                          _showContatosList(context);
                        },
                      ),
                      FeatureItem(
                        'Feed',
                        Icons.description,
                        onClick: () {
                          _showTrasferenciasList(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showContatosList(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ContatosLista(),
      ),
    );
  }

  void _showTrasferenciasList(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TransactionsList(),
      ),
    );
  }
}

class FeatureItem extends StatelessWidget {
  final String titulo;
  final IconData icone;
  final Function onClick; //call back

  FeatureItem(this.titulo, this.icone, {@required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          //InkWell tranfarma o container em button
          onTap: () {
            onClick();
          },
          child: Container(
            padding: EdgeInsets.all(8.0),
            //adiciona o padin para todos os itens internos
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  icone,
                  color: Colors.white,
                  size: 32,
                ),
                Text(
                  titulo,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
