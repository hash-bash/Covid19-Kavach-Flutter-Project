import 'dart:io';

import 'package:covid19_kavach/firebase/FirebaseHelper.dart';
import 'package:covid19_kavach/pages/country_selection/SelectCountry.dart';
import 'package:covid19_kavach/utilities/ConstantsBlue.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class OneMoreStep extends StatefulWidget {
  final String nameText;
  final String ageText;
  final String phoneText;
  final String emailText;
  final String genderText;
  final String addressText;
  final String passwordText;
  final File picture;

  OneMoreStep(this.nameText, this.ageText, this.phoneText, this.emailText,
      this.genderText, this.addressText, this.passwordText, this.picture);

  @override
  _OneMoreStepState createState() => _OneMoreStepState();
}

class _OneMoreStepState extends State<OneMoreStep> {
  String nameText;
  String ageText;
  String phoneText;
  String emailText;
  String genderText;
  String addressText;
  String passwordText;
  File picture;
  String imgUrl;

  String question1;
  String question2;
  String question3;
  String question4;
  String question5;
  String question6;
  String question7;
  String question8;
  String question9;

  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  Map<String, bool> mapQ5 = {
    'Cough': false,
    'Fever': false,
    'Difficulty in breathing': false,
    'Loss of senses of smell and taste': false,
    'None of the above': false,
  };

  Map<String, bool> mapQ7 = {
    'Diabetes': false,
    'Hypertension': false,
    'Lung Disease': false,
    'Heart Disease': false,
    'Kidney Disorder': false,
    'None of the above': false
  };

  getCheckboxItems() {
    question5 = "";
    mapQ5.forEach((key, value) {
      if (value == true) {
        question5 = question5 + "\n" + key;
      }
    });
  }

  getCheckboxItems2() {
    question7 = "";
    mapQ7.forEach((key, value) {
      if (value == true) {
        question7 = question7 + "\n" + key;
      }
    });
  }

  _high() {
    if (question5.trim() != 'None of the above' ||
        question7.trim() != 'None of the above' ||
        question3 == 'No' ||
        question4 == 'Above 101°F' ||
        question9 == 'Yes')
      return true;
    else
      return false;
  }

  _displayAlert(context) {
    if (_high() == false) {
      Alert(
        context: context,
        title: "ALERT!",
        desc:
            "Great job! You are at low risk. Maintain same practices to help fighting Covid-19.",
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => SelectCountry()),
                  (Route<dynamic> route) => false);
            },
            width: 120,
          )
        ],
        image: Image.asset("assets/gauge_low.png"),
      ).show();
    } else {
      Alert(
        context: this.context,
        title: "ALERT!",
        desc:
            "You are at high risk, Please follow all necessary guidelines and help fight Covid-19.",
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => SelectCountry()),
                  (Route<dynamic> route) => false);
            },
            width: 120,
          )
        ],
        image: Image.asset("assets/gauge_high.png"),
      ).show();
    }
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
              child: DropdownButton<String>(
                isExpanded: true,
                dropdownColor: Colors.blue[400],
                hint: Text(
                  "Answer",
                  style: TextStyle(color: Colors.white54, fontSize: 16),
                ),
                value: question1,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 24,
                iconEnabledColor: Colors.white,
                elevation: 2,
                style: TextStyle(color: Colors.white54),
                underline: Container(
                  height: 2,
                  color: Colors.transparent,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    question1 = newValue;
                  });
                },
                items: <String>['Yes', 'No']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )),
        )
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
              child: DropdownButton<String>(
                isExpanded: true,
                dropdownColor: Colors.blue[400],
                hint: Text(
                  "Answer",
                  style: TextStyle(color: Colors.white54, fontSize: 16),
                ),
                value: question2,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 24,
                iconEnabledColor: Colors.white,
                elevation: 2,
                style: TextStyle(color: Colors.white54),
                underline: Container(
                  height: 2,
                  color: Colors.transparent,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    question2 = newValue;
                  });
                },
                items: <String>['Yes', 'No']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )),
        )
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
              child: DropdownButton<String>(
                isExpanded: true,
                dropdownColor: Colors.blue[400],
                hint: Text(
                  "Answer",
                  style: TextStyle(color: Colors.white54, fontSize: 16),
                ),
                value: question3,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 24,
                iconEnabledColor: Colors.white,
                elevation: 2,
                style: TextStyle(color: Colors.white54),
                underline: Container(
                  height: 2,
                  color: Colors.transparent,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    question3 = newValue;
                  });
                },
                items: <String>['Yes', 'No']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
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
              child: DropdownButton<String>(
                isExpanded: true,
                dropdownColor: Colors.blue[400],
                hint: Text(
                  "Answer",
                  style: TextStyle(color: Colors.white54, fontSize: 16),
                ),
                value: question4,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 24,
                iconEnabledColor: Colors.white,
                elevation: 2,
                style: TextStyle(color: Colors.white54),
                underline: Container(
                  height: 2,
                  color: Colors.transparent,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    question4 = newValue;
                  });
                },
                items: <String>['97°F -99°F', '99.1°F - 101°F', 'Above 101°F']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )),
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
          height: 280.0,
          child: ListView(
            padding: EdgeInsets.all(0),
            physics: NeverScrollableScrollPhysics(),
            children: mapQ5.keys.map((String key) {
              return new CheckboxListTile(
                title: new Text(key,
                    style: TextStyle(color: Colors.white54, fontSize: 16)),
                value: mapQ5[key],
                activeColor: Colors.blue[200],
                checkColor: Colors.white,
                onChanged: (bool value) {
                  setState(() {
                    mapQ5[key] = value;
                    getCheckboxItems();
                  });
                },
              );
            }).toList(),
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
              child: DropdownButton<String>(
                isExpanded: true,
                dropdownColor: Colors.blue[400],
                hint: Text(
                  "Answer",
                  style: TextStyle(color: Colors.white54, fontSize: 16),
                ),
                value: question6,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 24,
                iconEnabledColor: Colors.white,
                elevation: 2,
                style: TextStyle(color: Colors.white54),
                underline: Container(
                  height: 2,
                  color: Colors.transparent,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    question6 = newValue;
                  });
                },
                items: <String>[
                  '1 Week',
                  '2 Weeks',
                  '2-3 Weeks',
                  'None of the above'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )),
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
          height: 340.0,
          child: ListView(
            padding: EdgeInsets.all(0),
            physics: NeverScrollableScrollPhysics(),
            children: mapQ7.keys.map((String key) {
              return new CheckboxListTile(
                title: new Text(key,
                    style: TextStyle(color: Colors.white54, fontSize: 16)),
                value: mapQ7[key],
                activeColor: Colors.blue[200],
                checkColor: Colors.white,
                onChanged: (bool value) {
                  setState(() {
                    mapQ7[key] = value;
                    getCheckboxItems2();
                  });
                },
              );
            }).toList(),
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
              child: DropdownButton<String>(
                isExpanded: true,
                dropdownColor: Colors.blue[400],
                hint: Text(
                  "Answer",
                  style: TextStyle(color: Colors.white54, fontSize: 16),
                ),
                value: question8,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 24,
                iconEnabledColor: Colors.white,
                elevation: 2,
                style: TextStyle(color: Colors.white54),
                underline: Container(
                  height: 2,
                  color: Colors.transparent,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    question8 = newValue;
                  });
                },
                items: <String>['Yes', 'No']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )),
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
              child: DropdownButton<String>(
                isExpanded: true,
                dropdownColor: Colors.blue[400],
                hint: Text(
                  "Answer",
                  style: TextStyle(color: Colors.white54, fontSize: 16),
                ),
                value: question9,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 24,
                iconEnabledColor: Colors.white,
                elevation: 2,
                style: TextStyle(color: Colors.white54),
                underline: Container(
                  height: 2,
                  color: Colors.transparent,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    question9 = newValue;
                  });
                },
                items: <String>['Yes', 'No']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )),
        )
      ],
    );
  }

  Widget _buildSignupBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: 120,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          if (question1 != null &&
              question2 != null &&
              question3 != null &&
              question4 != null &&
              question5 != null &&
              question6 != null &&
              question7 != null &&
              question8 != null &&
              question9 != null) {
            _scaffoldKey.currentState.showSnackBar(
                SnackBar(content: Text("Please wait, Signing you up!")));
            try {
              await FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                      email: emailText, password: passwordText)
                  .then((_) {
                User user = FirebaseAuth.instance.currentUser;
                user.updateProfile(displayName: nameText);

                String fileName = user.uid + '.jpg';

                Reference firebaseStorageRef =
                    FirebaseStorage.instance.ref().child(fileName);
                UploadTask uploadTask = firebaseStorageRef.putFile(picture);

                String uid = user.uid.toString();

                uploadTask.whenComplete(() async {
                  try {
                    imgUrl = await firebaseStorageRef.getDownloadURL();
                  } catch (onError) {
                    print("Error");
                  }
                  userSetup(
                      nameText,
                      ageText,
                      phoneText,
                      emailText,
                      genderText,
                      addressText,
                      imgUrl,
                      question1,
                      question2,
                      question3,
                      question4,
                      question5,
                      question6,
                      question7,
                      question8,
                      question9,
                      uid);
                });
              });
              _displayAlert(this.context);
            } catch (e) {
              return _scaffoldKey.currentState
                  .showSnackBar(SnackBar(content: Text(e.message)));
            }
          } else {
            _scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text("Please make sure all questions are answered.")));
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'SIGN UP',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    nameText = this.widget.nameText;
    ageText = this.widget.ageText;
    phoneText = this.widget.phoneText;
    emailText = this.widget.emailText;
    genderText = this.widget.genderText;
    addressText = this.widget.addressText;
    passwordText = this.widget.passwordText;
    picture = this.widget.picture;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                          Text("One More Step..",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'OpenSans',
                              )),
                        ])),
                    Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 30.0),
                            _buildQuestion1TF(),
                            SizedBox(
                              height: 20.0,
                            ),
                            _buildQuestion2TF(),
                            SizedBox(
                              height: 20.0,
                            ),
                            _buildQuestion3TF(),
                            SizedBox(
                              height: 20.0,
                            ),
                            _buildQuestion4TF(),
                            SizedBox(
                              height: 20.0,
                            ),
                            _buildQuestion5TF(),
                            SizedBox(
                              height: 20.0,
                            ),
                            _buildQuestion6TF(),
                            SizedBox(
                              height: 20.0,
                            ),
                            _buildQuestion7TF(),
                            SizedBox(
                              height: 20.0,
                            ),
                            _buildQuestion8TF(),
                            SizedBox(
                              height: 20.0,
                            ),
                            _buildQuestion9TF(),
                            SizedBox(
                              height: 20.0,
                            ),
                            _buildSignupBtn(),
                          ],
                        ))
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
