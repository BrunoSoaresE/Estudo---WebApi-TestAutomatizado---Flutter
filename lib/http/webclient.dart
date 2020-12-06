import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

import 'interceptors/loggin_interceptor.dart';


final Client client =
HttpClientWithInterceptor.build(interceptors: [LogginInterceptor()],
requestTimeout: Duration(seconds: 5),
);

const String base_url = 'http://192.168.0.11:8080/transactions';

