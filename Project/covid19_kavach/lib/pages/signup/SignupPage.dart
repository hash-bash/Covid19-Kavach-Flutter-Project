import 'dart:io';

import 'package:covid19_kavach/utilities/ConstantsBlue.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:the_validator/the_validator.dart';

import 'OneMoreStep.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String nameText;
  String ageText;
  String phoneText;
  String emailText;
  String genderText;
  String addressText;
  String passwordText;
  String passwordText2;

  File _image;

  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  var _nameController = new TextEditingController();
  var _emailController = new TextEditingController();
  var _passwordController = new TextEditingController();
  var _passwordController2 = new TextEditingController();
  var _ageController = new TextEditingController();
  var phoneController = new TextEditingController();
  var _addressController = new TextEditingController();

  Future getImage() async {
    try {
      var image = await ImagePicker.pickImage(
          source: ImageSource.gallery, maxHeight: 10000);

      setState(() {
        _image = image;
      });
    } catch (e) {
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text("Please use a different file manager.")));
    }
  }

  Widget _buildNameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Full Name',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            validator:
                FieldValidator.required(message: "*Please enter a valid Name"),
            controller: _nameController,
            onChanged: (value) {
              nameText = value;
            },
            keyboardType: TextInputType.name,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              errorStyle: TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
              ),
              contentPadding: EdgeInsets.only(top: 17, left: 15),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: 'Enter your Name',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            validator:
                FieldValidator.email(message: "*Please enter a valid Email"),
            controller: _emailController,
            onChanged: (value) {
              emailText = value;
            },
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              errorStyle: TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
              ),
              contentPadding: EdgeInsets.only(top: 17, left: 15),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your Email',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            validator: FieldValidator.password(
                errorMessage: "*Password must have 8 characters, 1 symbol",
                minLength: 8),
            controller: _passwordController,
            onChanged: (value) {
              passwordText = value;
            },
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              errorStyle: TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
              ),
              contentPadding: EdgeInsets.only(top: 17, left: 15),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            validator: FieldValidator.equalTo(_passwordController,
                message: "*Password does not match"),
            controller: _passwordController2,
            onChanged: (value) {
              passwordText2 = value;
            },
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              errorStyle: TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
              ),
              contentPadding: EdgeInsets.only(top: 17, left: 15),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Confirm Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAgeTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Age',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            validator: FieldValidator.number(
                noSymbols: true, message: "*Enter a valid Age."),
            controller: _ageController,
            onChanged: (value) {
              ageText = value;
            },
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              errorStyle: TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
              ),
              contentPadding: EdgeInsets.only(top: 17, left: 15),
              prefixIcon: Icon(
                Icons.date_range,
                color: Colors.white,
              ),
              hintText: 'Enter your Age',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Gender',
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
                  "Select your Gender",
                  style: TextStyle(color: Colors.white54, fontSize: 16),
                ),
                value: genderText,
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
                    genderText = newValue;
                  });
                },
                items: <String>['Male', 'Female', 'Others']
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

  Widget _buildPhoneTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Phone',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            validator: FieldValidator.required(
                message: "*Please enter a valid 10 digit phone number"),
            controller: phoneController,
            onChanged: (value) {
              phoneText = value;
            },
            keyboardType: TextInputType.phone,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              errorStyle: TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
              ),
              contentPadding: EdgeInsets.only(top: 17, left: 15),
              prefixIcon: Icon(
                Icons.phone_android,
                color: Colors.white,
              ),
              hintText: 'Enter your Phone',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddressTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Address',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 100.0,
          child: TextFormField(
            validator: FieldValidator.required(
                message: "Please enter a valid address"),
            controller: _addressController,
            onChanged: (value) {
              addressText = value;
            },
            maxLines: 3,
            maxLength: 60,
            keyboardType: TextInputType.streetAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              errorStyle: TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
              ),
              contentPadding: EdgeInsets.only(top: 17, left: 15),
              prefixIcon: Icon(
                Icons.location_city,
                color: Colors.white,
              ),
              hintText: 'Enter your Address',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignupBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: 120,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          if (_image == null) {
            _scaffoldKey.currentState.showSnackBar(
                SnackBar(content: Text("Please select the profile image.")));
          } else if (_formKey.currentState.validate() &&
              genderText != null &&
              _image != null) {
            Navigator.push(
                this.context,
                MaterialPageRoute(
                    builder: (context) => OneMoreStep(
                        nameText,
                        ageText,
                        phoneText,
                        emailText,
                        genderText,
                        addressText,
                        passwordText,
                        _image)));
          } else if (genderText == null) {
            _scaffoldKey.currentState.showSnackBar(
                SnackBar(content: Text("Please select the the gender")));
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
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
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
                          Text("Sign Up",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'OpenSans',
                              )),
                          SizedBox(
                            width: 50,
                          ),
                          GestureDetector(
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.white24,
                              child: Padding(
                                  padding: EdgeInsets.all(0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: (_image != null)
                                        ? Image.file(
                                            _image,
                                            fit: BoxFit.cover,
                                            height: double.infinity,
                                            width: double.infinity,
                                            alignment: Alignment.center,
                                          )
                                        : Image.asset(
                                            "images/select_image.png",
                                            color: Colors.blue[600],
                                          ),
                                  )),
                            ),
                            onTap: () => getImage(),
                          )
                        ])),
                    Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 30.0),
                            _buildNameTF(),
                            SizedBox(
                              height: 20.0,
                            ),
                            _buildEmailTF(),
                            SizedBox(
                              height: 20.0,
                            ),
                            _buildPasswordTF(),
                            SizedBox(
                              height: 15.0,
                            ),
                            _buildPasswordTF2(),
                            SizedBox(
                              height: 20.0,
                            ),
                            _buildAgeTF(),
                            SizedBox(
                              height: 20.0,
                            ),
                            _buildGenderTF(),
                            SizedBox(
                              height: 20.0,
                            ),
                            _buildPhoneTF(),
                            SizedBox(
                              height: 20.0,
                            ),
                            _buildAddressTF(),
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
