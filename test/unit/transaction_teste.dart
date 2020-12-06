
import 'package:bytebanksalvamentointerno/models/transacao.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  ///unidade teste
  test('Verifica cadastro da transação', (){
    final transaction  = Transaction(null, 200,null);
    expect(transaction.value, 200);
  });

  test('Mostrar erro ao cadastrar transação igual ou menor que 0', (){
    expect(() => Transaction(null, 0,null), throwsAssertionError);
  });


  //teste widghe





}