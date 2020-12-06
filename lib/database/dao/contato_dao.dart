import 'package:bytebanksalvamentointerno/database/app_database.dart';
import 'package:bytebanksalvamentointerno/models/contato.dart';

import 'dart:async';
import 'package:sqflite/sqflite.dart';

class ContatoDao {

  static const String _tableName = 'tbContatos';

  static const String _idContato = 'idContato';
  static const String _nome = 'nome';
  static const String _numeroConta = 'numeroConta';

  static const String  tableSql = "CREATE TABLE $_tableName"
      "($_idContato INTEGER PRIMARY KEY "
      ",$_nome TEXT "
      ",$_numeroConta INTEGER) ";


  Future<int> save(Contato contato) async {
    final Database db = await getDatabase();
    Map<String, dynamic> contactMap = _toMap(contato);

    return db.insert(_tableName, contactMap);
  }

  Future<List<Contato>> getAllContatos() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Contato> listContatos = _toList(result);
    return listContatos;
  }




  Map<String, dynamic> _toMap(Contato contato) {
    final Map<String, dynamic> contactMap = Map();
    contactMap['$_nome'] = contato.nome;
    contactMap['$_numeroConta'] = contato.numeroConta;
    return contactMap;
  }

  List<Contato> _toList(List<Map<String, dynamic>> result) {
    final List<Contato> listContatos = List();

    for (Map<String, dynamic> row in result) {
      final Contato contato = Contato(
        row['$_idContato'],
        row['$_nome'],
        row['$_numeroConta'],
      );
      listContatos.add(contato);
    }
    return listContatos;
  }

}