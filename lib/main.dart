import 'package:flutter/cupertino.dart';
import 'package:stimmungsringeapp/data/dashboard.dart';
import 'package:stimmungsringeapp/pages/loading_spinner_page.dart';
import 'package:stimmungsringeapp/pages/other_detail_page.dart';
import 'package:stimmungsringeapp/pages/overview_page.dart';
import 'package:stimmungsringeapp/pages/set_my_sentiment_page.dart';

void main() {
  // TODO: throws exceptions on start
//  SystemChrome.setPreferredOrientations(
//      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(SentimentApp());
}

class SentimentApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SentimentAppState();
  }
}

class _SentimentAppState extends State<SentimentApp> {
  Dashboard _dashboard;

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Stimmungsringe',
      routes: {
        '/': (_) => _dashboard != null
            ? OverviewPage(dashboard: _dashboard)
            : LoadingSpinnerPage(),
        'my-sentiment': (_) => SetMySentimentPage(
              dashboard: _dashboard,
              onSentimentChange: (sentiment) {
                if (_dashboard.myTile.sentimentStatus.sentimentCode !=
                    sentiment.name) {
                  setState(() => _dashboard
                      .myTile.sentimentStatus.sentimentCode = sentiment.name);
                }
              },
            ),
        'other-detail-page': (context) => OtherDetailPage(
            otherUserId: ModalRoute.of(context).settings.arguments)
      },
    );
  }

  @override
  void initState() {
    loadDashboardPageData().then((dashboard) {
      this.setState(() => _dashboard = dashboard);
    });
  }
}
