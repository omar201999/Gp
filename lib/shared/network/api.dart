import 'dart:io';

import 'package:http/http.dart' as http;

class Api {
  final HttpClient httpClient = HttpClient();
  final String fcmUrl = 'https://fcm.googleapis.com/fcm/send';
  final fcmKey = "AAAA77dt2Ts:APA91bGn4JtkfeZ0OidQGWsnyfruAgIxPTf8wwPsWlO929fN8zSuj-2d8aZ6yCsgQjzV-uPjZOQeop6wtv_nPMRyzNjB4d6ufp5t01LMt8uV_TwcARWCfSoFkCmTKWw6zbi5At_SyrSd";

  void sendFcm(String title, String body, String fcmToken) async {

    var headers = {'Content-Type': 'application/json', 'Authorization': 'key=$fcmKey'};
    var request = http.Request('POST', Uri.parse(fcmUrl));
    request.body = '''{"to":"$fcmToken","priority":"high","notification":{"title":"$title","body":"$body","sound": "default"}}''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}