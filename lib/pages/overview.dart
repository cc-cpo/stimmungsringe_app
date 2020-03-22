import 'package:flutter/cupertino.dart';
import 'package:stimmungsringeapp/data/sentiment.dart';
import 'package:stimmungsringeapp/widgets/avatar_row.dart';
import 'package:stimmungsringeapp/widgets/avatar_row_condensed.dart';
import 'package:stimmungsringeapp/data/dashboard.dart';
import 'package:stimmungsringeapp/global_constants.dart';

class OverviewPage extends StatelessWidget {
  final Dashboard dashboard;

  OverviewPage({
    Key key,
    this.dashboard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Übersicht'),
        trailing: GestureDetector(
          onTap: () => {}, // TODO
          child: Icon(
            CupertinoIcons.add,
            color: CupertinoColors.activeBlue,
          ),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: dashboard == null ? [] : children(context),
        ),
      ),
    );
  }

  List<Widget> children(BuildContext context) {
    return <Widget>[
      AvatarRow(
        name: dashboard.myTile.user.displayName,
        image: NetworkImage(avatarImageUrl(dashboard.myTile.user.userId)),
        avatarSentiment:
            Sentiment.fromSentimentStatus(dashboard.myTile.sentimentStatus),
        onSentimentIconTap: () => Navigator.pushNamed(context, 'my-sentiment'),
      ),
      Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Title(
          color: CupertinoColors.black,
          child: Text(
            'Meine Achtgeber:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      Expanded(
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: otherTiles(context),
        ),
      )
    ];
  }

  List<Widget> otherTiles(BuildContext context) {
    return dashboard.otherTiles
        .map(
          (tile) => Container(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: GestureDetector(
                child: AvatarRowCondensed(
                  name: tile.user.displayName,
                  image: NetworkImage(avatarImageUrl(tile.user.userId)),
                  avatarSentiment:
                      Sentiment.fromSentimentStatus(tile.sentimentStatus),
                ),
                onTap: () => Navigator.pushNamed(context, 'other-detail-page'),
              )),
        )
        .toList(growable: false);
  }
}
