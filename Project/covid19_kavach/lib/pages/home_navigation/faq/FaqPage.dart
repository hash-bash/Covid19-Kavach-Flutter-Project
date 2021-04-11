import 'package:covid19_kavach/utilities/Colors.dart';
import 'package:covid19_kavach/utilities/Styles.dart';
import 'package:covid19_kavach/webview/WebViewHelper.dart';
import 'package:flutter/material.dart';

class FaqPage extends StatefulWidget {
  @override
  _FaqPageState createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  var howItSpreadsUrl =
      "https://www.cdc.gov/coronavirus/2019-ncov/prepare/transmission.html";
  var symptomsUrl =
      "https://www.cdc.gov/coronavirus/2019-ncov/symptoms-testing/symptoms.html";
  var howToUseMaskUrl =
      "https://www.who.int/campaigns/connecting-the-world-to-combat-coronavirus/healthyathome";
  var adviceForPublicUrl =
      "https://www.who.int/news-room/feature-stories/detail/a-guide-to-who-s-guidance";
  var mediaResourcesUrl =
      "https://docs.google.com/forms/d/e/1FAIpQLSdUAbs3GfAGk4AJmb26ynVN1_AFiJOdY0dzDcG75od93tHRNQ/viewform";
  var govtschemes =
      "https://www.tmf-group.com/en/news-insights/coronavirus/government-support-schemes/#I";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getPageBackgroundColor(),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 8),
          InkWell(
            onTap: () {
              var webViewDetails = WebViewDetails(
                  title: 'Request Checkup', url: mediaResourcesUrl);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => webViewDetails),
              );
            },
            splashColor: Colors.brown,
            child: getSingleFaqView('Request Checkup',
                'Request Doorstep checkup', 'images/faq_mythbusters.png'),
          ),
          InkWell(
            onTap: () {
              var webViewDetails = WebViewDetails(
                  title: 'How it spreads?', url: howItSpreadsUrl);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => webViewDetails),
              );
            },
            splashColor: Colors.redAccent,
            child: getSingleFaqView('How it spreads?',
                'Learn how Covid-19 spreads', 'images/faq_howitspreads.png'),
          ),
          InkWell(
            onTap: () {
              var webViewDetails =
                  WebViewDetails(title: 'Symptoms', url: symptomsUrl);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => webViewDetails),
              );
            },
            splashColor: Colors.deepPurpleAccent,
            child: getSingleFaqView('Symptoms', 'Learn Covid-19 symptoms',
                'images/faq_symptoms.png'),
          ),
          InkWell(
            onTap: () {
              var webViewDetails =
                  WebViewDetails(title: 'Health Tips', url: howToUseMaskUrl);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => webViewDetails),
              );
            },
            splashColor: Colors.blue,
            child: getSingleFaqView(
                'Health Tips',
                'Being healthy and fit at home',
                'images/faq_protectyourself.png'),
          ),
          InkWell(
            onTap: () {
              var webViewDetails = WebViewDetails(
                  title: 'Advice for public', url: adviceForPublicUrl);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => webViewDetails),
              );
            },
            splashColor: Colors.green,
            child: getSingleFaqView('Advice for public',
                'WHO guidelines for public', 'images/faq_mediaresources.png'),
          ),
          InkWell(
            onTap: () {
              var webViewDetails =
                  WebViewDetails(title: 'Government Schemes', url: govtschemes);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => webViewDetails),
              );
            },
            splashColor: Colors.brown,
            child: getSingleFaqView('Government Schemes',
                'Info of COVID-19 schemes', 'images/faq_govt.png'),
          ),
        ],
      ),
    );
  }

  Widget getSingleFaqView(String title, String subtitle, String imageSrc) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, top: 7, bottom: 7),
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 15.0,
            ),
          ]),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 30,
          ),
          Container(
            width: 60,
            height: 60,
            child: Image.asset(
              imageSrc,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Container(
            height: 40,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    title,
                    textAlign: TextAlign.left,
                    style: getFaqTitleStyle(),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    subtitle,
                    style: getFaqSubtitleStyle(),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
