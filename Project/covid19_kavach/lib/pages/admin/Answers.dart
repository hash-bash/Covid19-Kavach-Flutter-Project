import 'package:covid19_kavach/firebase/FirebaseHelper.dart';
import 'package:covid19_kavach/utilities/ConstantsBlue.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animations/loading_animations.dart';

class Answers extends StatefulWidget {
  final String uid;

  Answers(this.uid);

  @override
  _AnswersState createState() => _AnswersState();
}

class _AnswersState extends State<Answers> {
  Future<List<String>> _future;
  List<String> questionData;
  String uid;

  String question1;
  String question2;
  String question3;
  String question4;
  String question5;
  String question6;
  String question7;
  String question8;
  String question9;

  @override
  void initState() {
    uid = this.widget.uid;
    _future = fetchParticularUserDetails(uid);
    super.initState();
  }

  Widget _buildQuestion1TF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Are you feeling well?',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 60.0,
            child: Padding(
                padding: EdgeInsets.only(left: 15, right: 20),
                child: Text(
                  question1,
                  style: TextStyle(color: Colors.white54, fontSize: 16),
                ))),
      ],
    );
  }

  Widget _buildQuestion2TF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Are you Covid-19 healthcare worker, police, or amongst Covid-19 essential workers/services?',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 60.0,
            child: Padding(
                padding: EdgeInsets.only(left: 15, right: 20),
                child: Text(
                  question2,
                  style: TextStyle(color: Colors.white54, fontSize: 16),
                )))
      ],
    );
  }

  Widget _buildQuestion3TF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Are you well equipped with sanitizers and masks for you and your family?',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: Padding(
              padding: EdgeInsets.only(left: 15, right: 20),
              child: Text(
                question3,
                style: TextStyle(color: Colors.white54, fontSize: 16),
              )),
        )
      ],
    );
  }

  Widget _buildQuestion4TF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'What is your current body temperature?',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 20),
            child: Text(
              question4,
              style: TextStyle(color: Colors.white54, fontSize: 16),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildQuestion5TF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Are you experiencing any of the following symptoms?',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 100.0,
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 20),
            child: Text(
              question5.trim(),
              style: TextStyle(color: Colors.white54, fontSize: 16),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildQuestion6TF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'If yes, how many days have you been suffering from these symptoms?',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 20),
            child: Text(
              question6,
              style: TextStyle(color: Colors.white54, fontSize: 16),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildQuestion7TF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Have you ever had any of the following?',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 100.0,
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 20),
            child: Text(
              question7.trim(),
              style: TextStyle(color: Colors.white54, fontSize: 16),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildQuestion8TF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Have you travelled internationally in the last 14 days?',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 20),
            child: Text(
              question8,
              style: TextStyle(color: Colors.white54, fontSize: 16),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildQuestion9TF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Have you recently interacted or linked or currently lived with someone who has tested positive for Covid-19?',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 20),
            child: Text(
              question9,
              style: TextStyle(color: Colors.white54, fontSize: 16),
            ),
          ),
        )
      ],
    );
  }

  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
        future: _future, // async work
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                  child: LoadingBouncingGrid.square(
                      backgroundColor: Colors.white, inverted: true));
            default:
              if (snapshot.hasError)
                print('Error: ${snapshot.error}');
              else {
                questionData = snapshot.data;
                question1 = questionData[7];
                question2 = questionData[8];
                question3 = questionData[9];
                question4 = questionData[10];
                question5 = questionData[11];
                question6 = questionData[12];
                question7 = questionData[13];
                question8 = questionData[14];
                question9 = questionData[15];
              }
              return Scaffold(
                body: AnnotatedRegion<SystemUiOverlayStyle>(
                  value: SystemUiOverlayStyle.light,
                  child: GestureDetector(
                    onTap: () => FocusScope.of(this.context).unfocus(),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: double.infinity,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFF73AEF5),
                                Color(0xFF61A4F1),
                                Color(0xFF478DE0),
                                Color(0xFF398AE5),
                              ],
                              stops: [0.1, 0.4, 0.7, 0.9],
                            ),
                          ),
                        ),
                        Container(
                          height: double.infinity,
                          child: SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                              horizontal: 40.0,
                              vertical: 60.0,
                            ),
                            child: Column(children: <Widget>[
                              Container(
                                  alignment: Alignment.centerLeft,
                                  child: Row(children: <Widget>[
                                    Text("Answers",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'OpenSans',
                                        )),
                                  ])),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(height: 30.0),
                                  _buildQuestion1TF(),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  _buildQuestion2TF(),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  _buildQuestion3TF(),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  _buildQuestion4TF(),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  _buildQuestion5TF(),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  _buildQuestion6TF(),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  _buildQuestion7TF(),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  _buildQuestion8TF(),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  _buildQuestion9TF(),
                                ],
                              )
                            ]),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
          }
        });
  }
}
