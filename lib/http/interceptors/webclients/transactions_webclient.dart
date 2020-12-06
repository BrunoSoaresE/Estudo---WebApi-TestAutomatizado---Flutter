import 'dart:convert';


import 'package:bytebanksalvamentointerno/http/webclient.dart';
import 'package:bytebanksalvamentointerno/models/transacao.dart';
import 'package:http/http.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final Response response = await client.get(base_url);

    // List<Transaction> transaction = _toTransactions(response);

    final List<dynamic> decodeJson = jsonDecode(response.body);

    return decodeJson
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();

    // return transaction;
  }

  Future<Transaction> save(Transaction transaction, String password) async {


    await Future.delayed(Duration(seconds: 10));
    final Response response = await client.post(base_url,
        headers: {
          'Content-Type': 'application/json',
          'password': password,
        },
        body: jsonEncode(transaction.toJson())).timeout(Duration(seconds: 5));



    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    }

    throw HttpException(_getMessage(response.statusCode));
  }

  String _getMessage(int statusCode) {
    if(_statusCodeResponses.containsKey(statusCode)){
      return _statusCodeResponses[statusCode];
    }

      return 'Erro inesperado';
  }


  static final Map<int, String> _statusCodeResponses = {
    400: 'there was an error submitting transaction',
    401: 'authentication failed',
    409: 'transação ja existe',
  };
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
