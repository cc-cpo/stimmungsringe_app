import 'package:flutter/cupertino.dart';
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
          child: GridView.count(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            children: [Text('sadf')], // ex all sentiments
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
}
