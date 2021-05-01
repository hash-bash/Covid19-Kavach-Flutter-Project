import 'package:covid19_kavach/pages/home_navigation/faq/FaqPage.dart';
import 'package:covid19_kavach/pages/home_navigation/global/GlobalPage.dart';
import 'package:covid19_kavach/pages/home_navigation/map/MapPage.dart';
import 'package:covid19_kavach/pages/home_navigation/news/NewsPage.dart';
import 'package:covid19_kavach/pages/home_navigation/profile/ProfilePage.dart';
import 'package:covid19_kavach/utilities/Styles.dart';
import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RateMyApp _rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 0,
    minLaunches: 2,
    remindDays: 2,
    remindLaunches: 5,
  );

  Color getColorF(currentTab) {
    if (currentTab == 0)
      return Colors.greenAccent;
    else if (currentTab == 1)
      return Colors.orangeAccent;
    else if (currentTab == 2)
      return Colors.cyanAccent;
    else if (currentTab == 3)
      return Colors.amberAccent;
    else if (currentTab == 4) return Colors.red[300];
  }

  final List<Widget> screens = [
    GlobalPage(),
    FaqPage(),
    NewsPage(),
    MapPage(),
    ProfilePage()
  ];
  Widget currentScreen = GlobalPage();
  final PageStorageBucket bucket = PageStorageBucket();
  int currentTab = 0;

  @override
  void initState() {
    super.initState();
    _rateMyApp.init().then((_) {
      if (_rateMyApp.shouldOpenDialog) {
        _rateMyApp.showStarRateDialog(
          context,
          title: 'Loving the app so far?',
          message:
              'Please leave a rating and give feedback to help us grow. Thanks you!',
          actionsBuilder: (_, stars) {
            return [
              FlatButton(
                child: Text('OK'),
                onPressed: () async {
                  print('Thanks for the ' +
                      (stars == null ? '0' : stars.round().toString()) +
                      ' star(s) !');
                  if (stars != null && (stars == 4 || stars == 5)) {
                    // if the user stars is equal to four or five
                  } else {
                    // else you can redirect the user to a page in your app to tell you how you can make the app better
                  }
                  await _rateMyApp
                      .callEvent(RateMyAppEventType.rateButtonPressed);
                  Navigator.pop<RateMyAppDialogButton>(
                      context, RateMyAppDialogButton.rate);
                },
              ),
            ];
          },
          dialogStyle: DialogStyle(
            titleAlign: TextAlign.center,
            messageAlign: TextAlign.center,
            messagePadding: EdgeInsets.only(bottom: 20.0),
          ),
          starRatingOptions: StarRatingOptions(),
          onDismissed: () =>
              _rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        brightness: Brightness.light,
        backgroundColor: getColorF(currentTab),
        title: Row(
          children: <Widget>[
            Container(
              height: 40,
              child: Hero(
                  tag: "ic_covid",
                  child: Image.asset(
                    'images/main_icon.png',
                    fit: BoxFit.cover,
                  )),
            ),
            Spacer(),
            InkWell(
                onTap: () {
                  removeUserCountry();
                },
                child: Text(getPageTitle(currentTab),
                    style: getPageTitleTextStyle(18.0)))
          ],
        ),
      ),
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      bottomNavigationBar: getBottomNavigationBar(),
    );
  }

  Widget getBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentTab,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage(
              "images/tab_icon_global.png",
            ),
            color: currentTab == 0 ? Colors.greenAccent : Colors.white38,
          ),
          title: Container(
            margin: EdgeInsets.all(8.0),
          ),
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage(
              "images/tab_icon_faq.png",
            ),
            color: currentTab == 1 ? Colors.orangeAccent : Colors.white38,
          ),
          title: Container(
            margin: EdgeInsets.all(8.0),
          ),
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage(
              "images/tab_icon_news.png",
            ),
            color: currentTab == 2 ? Colors.lightBlueAccent : Colors.white38,
          ),
          title: Container(
            margin: EdgeInsets.all(8.0),
          ),
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage(
              "images/tab_icon_map.png",
            ),
            color: currentTab == 3 ? Colors.amberAccent : Colors.white38,
          ),
          title: Container(
            margin: EdgeInsets.all(8.0),
          ),
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage(
              "images/tab_icon_profile.png",
            ),
            color: currentTab == 4 ? Colors.red[300] : Colors.white38,
          ),
          title: Container(
            margin: EdgeInsets.all(8.0),
          ),
        )
      ],
      onTap: (index) {
        if (this.mounted)
          setState(() {
            currentScreen = screens[index];
            currentTab = index;
          });
      },
    );
  }

  String getPageTitle(int currentTab) {
    var pageTitle = "GLOBAL";
    switch (currentTab) {
      case 0:
        pageTitle = 'GLOBAL';
        break;
      case 1:
        pageTitle = 'HELP';
        break;
      case 2:
        pageTitle = 'NEWS';
        break;
      case 3:
        pageTitle = 'COVID19 MAP';
        break;
      case 4:
        pageTitle = 'PROFILE';
    }
    if (this.mounted)
      setState(() {
        pageTitle = pageTitle;
      });
    return pageTitle;
  }
}

void removeUserCountry() async {
  var preference = await SharedPreferences.getInstance();
  preference.remove('userCountry');
}
