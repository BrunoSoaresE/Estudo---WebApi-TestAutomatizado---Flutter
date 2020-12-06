import 'package:flutter/material.dart';

class Carregando extends StatelessWidget {
  final String mensagem;
  Carregando({this.mensagem = "Carregando"});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          Text(mensagem),
        ],
      ),
    );
  }
}
