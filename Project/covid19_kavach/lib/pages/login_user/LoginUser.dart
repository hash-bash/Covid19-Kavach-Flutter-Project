import 'package:covid19_kavach/pages/home_navigation/HomePage.dart';
import 'package:covid19_kavach/pages/login_admin/LoginAdmin.dart';
import 'package:covid19_kavach/pages/signup/SignupPage.dart';
import 'package:covid19_kavach/utilities/ConstantsBlue.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:the_validator/the_validator.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String emailText;
  String passwordText;
  String pwdrst;

  var _formKey = GlobalKey<FormState>();
  var _formKey2 = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  var _reset = new TextEditingController();
  var _email = new TextEditingController();
  var _password = new TextEditingController();

  _resetPassword(context) {
    Alert(
        context: context,
        title: "Reset Password",
        content: Form(
          key: _formKey2,
          child: TextFormField(
            validator:
                FieldValidator.email(message: "*Please enter a valid email"),
            controller: _reset,
            onChanged: (value) {
              pwdrst = value;
            },
            decoration: InputDecoration(
              errorStyle: TextStyle(
                color: Colors.redAccent,
                fontFamily: 'OpenSans',
              ),
              icon: Icon(Icons.account_circle),
              labelText: 'Email',
            ),
          ),
        ),
        buttons: [
          DialogButton(
            onPressed: () async {
              if (_formKey2.currentState.validate()) {
                Navigator.pop(context);
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                    content:
                        Text("Please wait, sending password reset link.")));
                try {
                  await FirebaseAuth.instance
                      .sendPasswordResetEmail(email: pwdrst)
                      .then((value) => SnackBar(
                          content:
                              Text("Password reset link sent successfully.")));
                } catch (e) {
                  return _scaffoldKey.currentState
                      .showSnackBar(SnackBar(content: Text(e.message)));
                }
              }
            },
            child: Text(
              "Request Link",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
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
            controller: _email,
            validator:
                FieldValidator.email(message: "*Please enter a valid email"),
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
            controller: _password,
            validator: FieldValidator.required(
                message: "*Please enter a valid password"),
            keyboardType: TextInputType.visiblePassword,
            onChanged: (value) {
              passwordText = value;
            },
            obscureText: true,
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

  Widget _buildForgotPasswordBtn() {
    return Container(
        child: Column(children: <Widget>[
      Row(children: <Widget>[
        FlatButton(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => AdminLoginScreen())),
          child: Text(
            'Admin?',
            style: kLabelStyle,
          ),
        ),
        SizedBox(width: 45),
        FlatButton(
          onPressed: () => _resetPassword(context),
          child: Text(
            'Forgot Password?',
            style: kLabelStyle,
          ),
        ),
      ])
    ]));
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: 120,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            _scaffoldKey.currentState.showSnackBar(
                SnackBar(content: Text("Please wait, Logging you in.")));
            try {
              await FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                      email: emailText, password: passwordText)
                  .then((_) {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomePage()));
              });
            } catch (e) {
              return _scaffoldKey.currentState
                  .showSnackBar(SnackBar(content: Text(e.message)));
            }
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'LOGIN',
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

  Widget _buildOrText() {
    return Column(children: <Widget>[
      Text(
        '- OR -',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
    ]);
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignupScreen())),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Stack(children: <Widget>[
      Container(
          child: Image.asset(
        "images/main_icon.png",
        height: 100,
        alignment: Alignment.topCenter,
      )),
      SizedBox(
        height: 100,
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Form(
              key: _formKey,
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
                        vertical: 90.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _buildIcon(),
                          SizedBox(height: 30.0),
                          _buildEmailTF(),
                          SizedBox(
                            height: 20.0,
                          ),
                          _buildPasswordTF(),
                          _buildForgotPasswordBtn(),
                          _buildLoginBtn(),
                          _buildOrText(),
                          SizedBox(
                            height: 15,
                          ),
                          _buildSignupBtn(),
                        ],
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
