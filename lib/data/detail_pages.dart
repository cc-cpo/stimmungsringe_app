import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user.dart';
import 'sentiment.dart';
import 'package:stimmungsringeapp/global_constants.dart';


Future<OtherDetailPage> loadOtherDetailPageData(String userId) async {
  final String url = restUrlOtherStatus(userId);

  http.Response response = await http.get(
    url,
    headers: {'X-User-ID': sampleUserMutti},
  );

  var detailPage = OtherDetailPage.fromJson(json.decode(response.body));

  return detailPage;
}


class Suggestion {
  String text;

  Suggestion.fromJson(Map<String, dynamic> jsonMap) {
    this.text = jsonMap['text'];
  }
}

class OtherDetailPage {
  UserMinimal user;
  SentimentStatus sentimentStatus;
  List<Suggestion> suggestions;

  OtherDetailPage.fromJson(Map<String, dynamic> jsonMap) {
    this.user = UserMinimal.fromJson(jsonMap['user']);
    this.sentimentStatus = SentimentStatus.fromJson(jsonMap['sentimentStatus']);

    final suggestionsJson = (jsonMap['suggestions'] as List);
    this.suggestions = suggestionsJson.map((sugg) => Suggestion.fromJson(sugg)).toList(growable: false);

  }
}
