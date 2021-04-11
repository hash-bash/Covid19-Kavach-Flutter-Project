import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid19_kavach/firebase/FirebaseHelper.dart';
import 'package:covid19_kavach/utilities/SizeConfig.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

import 'UserDetails.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

CollectionReference users = FirebaseFirestore.instance.collection('Users');
String uid = FirebaseAuth.instance.currentUser.uid.toString();

class _AdminPageState extends State<AdminPage> {
  Future<List<DocumentSnapshot>> _future;
  List<DocumentSnapshot> finalList;

  @override
  void initState() {
    _future = fetchDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 3,
          brightness: Brightness.light,
          backgroundColor: Colors.red[300],
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
                  child: Text("Registered Users List",
                      style: TextStyle(
                          color: Color(0xFF2E3D5F),
                          fontSize: 18,
                          fontWeight: FontWeight.w600)))
            ],
          ),
        ),
        body: Container(
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
                    right: 20.0,
                    top: 3 * SizeConfig.heightMultiplier),
                child: FutureBuilder<List<DocumentSnapshot>>(
                  future: _future,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(
                            child: LoadingBouncingGrid.square(
                                backgroundColor: Colors.white, inverted: true));
                      default:
                        if (snapshot.hasError)
                          return Text('Error: ${snapshot.error}');
                        else {
                          finalList = snapshot.data;
                        }
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: finalList.length,
                          itemBuilder: (context, index) {
                            return RaisedButton(
                                color: Colors.red[200],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                hoverColor: Colors.white24,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UserDetails(
                                              finalList[index].get("uid"))));
                                },
                                child: Text(finalList[index].get("nameText")));
                          },
                        );
                    }
                  },
                ))));
  }
}
