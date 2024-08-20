/*
*   Repository repository=Repository();
*    repository.myMethod();
*
* */

import 'package:bitroot/parser/parser.dart';

class Repository {
  static Future<dynamic> fetchReviewSchedule() async {
    String url = 'https://mocki.io/v1/02803453-b00b-4c75-9e8e-5c582d050ed7';

    Map<String, String>? headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    Map<String, dynamic>? response = await HttpCallGenerator.makeHttpRequest(
      url: url,
      headers: headers,
      method: HTTPMethod.GET,
    );


    return response;
  }
}
