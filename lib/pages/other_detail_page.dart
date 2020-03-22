import 'package:flutter/cupertino.dart';
import 'package:stimmungsringeapp/data/dashboard.dart';
import 'package:stimmungsringeapp/data/sentiment.dart';
import 'package:stimmungsringeapp/widgets/avatar_row.dart';

import '../global_constants.dart';

class OtherDetailPage extends StatelessWidget {
  final Dashboard dashboard;
  final String otherUserId;

  OtherDetailPage(
      {Key key, @required this.dashboard, @required String this.otherUserId})
      : assert(dashboard != null),
        assert(otherUserId != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Wie geht es eigentlich ... ' + otherUserId),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            AvatarRow(
              name: dashboard.myTile.user.displayName,
              image: NetworkImage(avatarImageUrl(dashboard.myTile.user.userId)),
              avatarSentiment: Sentiment.fromSentimentStatus(
                  dashboard.myTile.sentimentStatus),
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
        ),
      ),
    );
  }
}
