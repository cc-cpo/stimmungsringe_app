import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stimmungsringeapp/data/detail_pages.dart';
import 'package:stimmungsringeapp/data/sentiment.dart';
import 'package:stimmungsringeapp/global_constants.dart';
import 'package:stimmungsringeapp/widgets/avatar_row.dart';

class OtherDetailPage extends StatefulWidget {
  final String otherUserId;

  OtherDetailPage({@required String this.otherUserId}) {}

  @override
  State<StatefulWidget> createState() {
    return _OtherDetailPageState(otherUserId: otherUserId);
  }
}

class _OtherDetailPageState extends State<OtherDetailPage> {
  final String otherUserId;
  OtherDetail _otherDetail;

  _OtherDetailPageState({@required String this.otherUserId})
      : assert(otherUserId != null) {}

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Wie geht es eigentlich ... '),
      ),
      child: SafeArea(
        child: _otherDetail != null ? buildContent() : makeSpinner(),
      ),
    );
  }

  Column buildContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        AvatarRow(
          name: _otherDetail.user.displayName,
          image: NetworkImage(avatarImageUrl(_otherDetail.user.userId)),
          avatarSentiment:
              Sentiment.fromSentimentStatus(_otherDetail.sentimentStatus),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Title(
            color: CupertinoColors.black,
            child: Text(
              'Die Küche könnte etwas sauberer sein ...',
            ),
          ),
        ),
        Expanded(
          child: ListView(
            children: buildSuggestions(),
          ),
        )
      ],
    );
  }

  @override
  void initState() {
    loadOtherDetailPageData(otherUserId).then((otherDetail) {
      this.setState(() => _otherDetail = otherDetail);
    });
  }

  Widget makeSpinner() {
    return Center(
      child: CupertinoActivityIndicator(
        animating: true,
      ),
    );
  }

  Widget buildSuggestionRow(Suggestion suggestion) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://1s83z11vs1os1aeaj31io68i-wpengine.netdna-ssl.com/wp-content/themes/mobsquad/img/avatar-fallback.jpg'),
            ),
          ),
          Expanded(child: Text(suggestion.text))
        ],
      ),
    );
  }

  List<Widget> buildSuggestions() {
    return _otherDetail.suggestions
        .map((sugg) => buildSuggestionRow(sugg))
        .toList(growable: false);
  }
}
