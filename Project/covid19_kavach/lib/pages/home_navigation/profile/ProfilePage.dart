import 'package:covid19_kavach/firebase/FirebaseHelper.dart';
import 'package:covid19_kavach/pages/login_user/LoginUser.dart';
import 'package:covid19_kavach/utilities/Colors.dart';
import 'package:covid19_kavach/utilities/SizeConfig.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<List<String>> _future;
  List<String> personalData;
  String uid = FirebaseAuth.instance.currentUser.uid.toString();

  @override
  void initState() {
    _future = fetchParticularUserDetails(uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String nameText = "Someone's Name";
    String ageText = "20";
    String phoneText = "1234567890";
    String emailText = "examplemail@gmail.com";
    String genderText = "Male";
    String addressText =
        "Here is some example of the address, which will let you have some idea about same.";
    String imgUrl;

    return Scaffold(
      backgroundColor: Colors.blue[500],
      body: Stack(
        children: <Widget>[
          FutureBuilder<List<String>>(
            future: _future, // async work
            builder:
                (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                    child: LoadingBouncingGrid.square(
                        backgroundColor: Colors.white, inverted: true),
                    heightFactor: 3,
                  );
                default:
                  if (snapshot.hasError)
                    print('Error: ${snapshot.error}');
                  else {
                    personalData = snapshot.data;
                    nameText = personalData[0];
                    ageText = personalData[1];
                    phoneText = personalData[2];
                    emailText = personalData[3];
                    genderText = personalData[4];
                    addressText = personalData[5];
                    imgUrl = personalData[6];
                  }
                  return Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.blue[700],
                            Colors.blue[700],
                            Colors.blue[600],
                            Colors.blue[500],
                          ],
                          stops: [0.1, 0.4, 0.7, 0.9],
                        ),
                        border: Border.all(
                          width: 1.5,
                          color: Colors.white54,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    margin: EdgeInsets.all(1.3 * SizeConfig.heightMultiplier),
                    height: 60 * SizeConfig.heightMultiplier,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 20.0,
                          right: 10.0,
                          top: 3 * SizeConfig.heightMultiplier),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                  height: 11 * SizeConfig.heightMultiplier,
                                  width: 22 * SizeConfig.widthMultiplier,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 18,
                                    child: ClipOval(
                                      child: Image.network(
                                        imgUrl,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes
                                                  : null,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                width: 5 * SizeConfig.widthMultiplier,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    nameText,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 3 * SizeConfig.textMultiplier,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 1 * SizeConfig.heightMultiplier,
                                  ),
                                  Row(children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Image.asset(
                                          "assets/phone.png",
                                          height:
                                              5 * SizeConfig.heightMultiplier,
                                          width: 5 * SizeConfig.widthMultiplier,
                                        ),
                                        SizedBox(
                                          width: 2 * SizeConfig.widthMultiplier,
                                        ),
                                        Text(
                                          phoneText,
                                          style: TextStyle(
                                            color: Colors.white60,
                                            fontSize:
                                                2 * SizeConfig.textMultiplier,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 7 * SizeConfig.widthMultiplier,
                                    )
                                  ]),
                                  Row(
                                    children: <Widget>[
                                      Image.asset(
                                        "assets/email.png",
                                        height: 5 * SizeConfig.heightMultiplier,
                                        width: 5 * SizeConfig.widthMultiplier,
                                      ),
                                      SizedBox(
                                        width: 2 * SizeConfig.widthMultiplier,
                                      ),
                                      Text(
                                        emailText,
                                        style: TextStyle(
                                          color: Colors.white60,
                                          fontSize:
                                              2 * SizeConfig.textMultiplier,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 4 * SizeConfig.widthMultiplier,
                          ),
                          Row(
                            children: <Widget>[
                              Image.asset(
                                "assets/map.png",
                                height: 5 * SizeConfig.heightMultiplier,
                                width: 5 * SizeConfig.widthMultiplier,
                              ),
                              SizedBox(
                                width: 2 * SizeConfig.widthMultiplier,
                              ),
                              Flexible(
                                  child: Padding(
                                      padding: new EdgeInsets.only(right: 13.0),
                                      child: Text(addressText,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          style: TextStyle(
                                              color: Colors.white60,
                                              fontSize: 2 *
                                                  SizeConfig.textMultiplier))))
                            ],
                          ),
                          SizedBox(
                            height: 4 * SizeConfig.widthMultiplier,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    genderText,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 3 * SizeConfig.textMultiplier,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Gender",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 1.9 * SizeConfig.textMultiplier,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    ageText,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 3 * SizeConfig.textMultiplier,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Age",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 1.9 * SizeConfig.textMultiplier,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "☆ NEW MEMBER",
                                    style: TextStyle(
                                        color: Colors.white60,
                                        fontSize:
                                            1.8 * SizeConfig.textMultiplier),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
              }
            },
          ),
          Padding(
              padding: EdgeInsets.only(
                  top: 35 * SizeConfig.heightMultiplier,
                  left: 5 * SizeConfig.widthMultiplier,
                  right: 5 * SizeConfig.widthMultiplier),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      topLeft: Radius.circular(20.0),
                    )),
                child: Column(children: <Widget>[
                  SizedBox(height: 1 * SizeConfig.heightMultiplier),
                  Container(
                      margin: EdgeInsets.all(3 * SizeConfig.heightMultiplier),
                      child: Column(children: <Widget>[
                        FlatButton(
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(15.0)),
                            minWidth: 75 * SizeConfig.widthMultiplier,
                            color: Colors.blue[500],
                            onPressed: () => launch("tel://011 23978046"),
                            child: Text(
                              "📞 : Call Helpline",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 2 * SizeConfig.textMultiplier,
                                  fontWeight: FontWeight.bold),
                            )),
                        FlatButton(
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(15.0)),
                            onPressed: () => launch("tel://1075"),
                            minWidth: 75 * SizeConfig.widthMultiplier,
                            color: Colors.blue[500],
                            child: Text(
                              "☎ : Toll-free Contact",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 2 * SizeConfig.textMultiplier,
                                  fontWeight: FontWeight.bold),
                            )),
                        FlatButton(
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(15.0)),
                            color: Colors.blue[500],
                            minWidth: 75 * SizeConfig.widthMultiplier,
                            onPressed: () => launch("mailto:ncov2019@gov.in"),
                            child: Text(
                              "📱 : Email Support",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 2 * SizeConfig.textMultiplier,
                                  fontWeight: FontWeight.bold),
                            ))
                      ])),
                  SizedBox(height: 3 * SizeConfig.heightMultiplier),
                  RaisedButton(
                      padding: EdgeInsets.all(1 * SizeConfig.heightMultiplier),
                      color: Colors.red[300],
                      textColor: getPrimaryColor(),
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => LoginScreen()));
                      },
                      child: Text(
                        "Sign Out",
                        style: TextStyle(
                            fontSize: 2 * SizeConfig.textMultiplier,
                            fontWeight: FontWeight.bold),
                      )),
                ]),
              ))
        ],
      ),
    );
  }
}
