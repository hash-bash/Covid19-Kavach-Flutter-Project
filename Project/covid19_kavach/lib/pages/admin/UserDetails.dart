import 'package:covid19_kavach/firebase/FirebaseHelper.dart';
import 'package:covid19_kavach/utilities/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Answers.dart';

class UserDetails extends StatefulWidget {
  final String uid;

  UserDetails(this.uid);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  String uid;
  Future<List<String>> _future;
  List<String> personalData;

  @override
  void initState() {
    uid = this.widget.uid;
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
      appBar: AppBar(
        elevation: 3,
        brightness: Brightness.light,
        backgroundColor: Colors.greenAccent,
        title: Row(
          children: <Widget>[
            Spacer(),
            InkWell(
                child: Text("User Details",
                    style: TextStyle(
                        color: Color(0xFF2E3D5F),
                        fontSize: 18,
                        fontWeight: FontWeight.w600)))
          ],
        ),
      ),
      backgroundColor: Colors.black,
      body: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          FutureBuilder<List<String>>(
            future: _future, // async work
            builder:
                (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                      child: LoadingBouncingGrid.square(
                          backgroundColor: Colors.white, inverted: true));
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
                        border: Border.all(
                          color: Colors.white60,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    margin: EdgeInsets.all(1.3 * SizeConfig.heightMultiplier),
                    height: MediaQuery.of(context).size.height - 10,
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
                                  SelectableText(
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
                                        GestureDetector(
                                          child: Text(
                                            phoneText,
                                            style: TextStyle(
                                              color: Colors.white60,
                                              fontSize:
                                                  2 * SizeConfig.textMultiplier,
                                            ),
                                          ),
                                          onTap: () =>
                                              launch("tel://" + phoneText),
                                        )
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
                                      GestureDetector(
                                        child: Text(
                                          emailText,
                                          style: TextStyle(
                                            color: Colors.white60,
                                            fontSize:
                                                2 * SizeConfig.textMultiplier,
                                          ),
                                        ),
                                        onTap: () =>
                                            launch("mailto:" + emailText),
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
                                  border: Border.all(color: Colors.white60),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: RaisedButton(
                                      color: Colors.transparent,
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Answers(uid)));
                                      },
                                      child: Text(
                                        "See Answers",
                                        style: TextStyle(
                                            color: Colors.white60,
                                            fontSize: 1.8 *
                                                SizeConfig.textMultiplier),
                                      )),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Image.asset(
                            "images/family.png",
                            height: 200,
                            width: 200,
                          )
                        ],
                      ),
                    ),
                  );
              }
            },
          ),
        ],
      ),
    );
  }
}
