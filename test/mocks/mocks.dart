import 'package:bytebanksalvamentointerno/database/dao/contato_dao.dart';
import 'package:bytebanksalvamentointerno/http/interceptors/webclients/transactions_webclient.dart';
import 'package:mockito/mockito.dart';

class MockContatoDao extends Mock implements ContatoDao{}

class MockTransactionWebClient extends Mock implements TransactionWebClient{}