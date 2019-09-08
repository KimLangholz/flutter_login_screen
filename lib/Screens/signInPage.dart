import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:momentum/CustomIcons.dart';
import 'package:momentum/Screens/Profile.dart';
import 'package:momentum/Widgets/SocialIcons.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

bool _signUpActive = false;
bool _signInActive = true;
var facebookLogin = FacebookLogin();
TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
TextEditingController _newEmailController = TextEditingController();
TextEditingController _newPasswordController = TextEditingController();

final FirebaseAuth _auth = FirebaseAuth.instance;

Widget horizontalLine() => Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: ScreenUtil.getInstance().setWidth(120),
        height: 1.0,
        color: Colors.white.withOpacity(0.6),
      ),
    );

class SignInPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LogInPageState();
}

class _LogInPageState extends StateMVC<SignInPage> {
  _LogInPageState() : super(Controller());

  bool isLoggedIn = false;
  var profileData;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1304, allowFontScaling: true)
          ..init(context);
    return new Scaffold(
      resizeToAvoidBottomPadding: true,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color.fromRGBO(20, 54, 66, 1),
              Color.fromRGBO(38, 102, 125, 1)
            ])),
        child: Padding(
          padding: EdgeInsets.only(top: 40.0),
          //Sets the main padding all widgets has to adhere to.
          child: Column(
            children: <Widget>[
              Container(
                child: Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          Controller.displayLogoTitle,
                          style: TextStyle(
                            //fontFamily: 'Open Sans',
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          Controller.displayLogoSubTitle,
                          style: TextStyle(
                            //fontFamily: 'Open Sans',
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )),
                width: ScreenUtil.getInstance().setWidth(750),
                height: ScreenUtil.getInstance().setHeight(190),
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(60),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: IntrinsicWidth(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        OutlineButton(
                          onPressed: () => setState(() => changeToSignIn()),
                          borderSide: new BorderSide(
                            style: BorderStyle.none,
                          ),
                          child: new Text(Controller.displaySignInMenuButton,
                              style: _signInActive
                                  ? TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)
                                  : TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal)),
                        ),
                        OutlineButton(
                          onPressed: () => setState(() => changeToSignUp()),
                          borderSide: BorderSide(
                            style: BorderStyle.none,
                          ),
                          child: Text(Controller.displaySignUpMenuButton,
                              style: _signUpActive
                                  ? TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)
                                  : TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal)),
                        )
                      ],
                    ),
                  ),
                ),
                width: ScreenUtil.getInstance().setWidth(750),
                height: ScreenUtil.getInstance().setHeight(170),
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(10),
              ),
              Container(
                child: Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child:
                        _signInActive ? _showSignIn(context) : _showSignUp()),
                width: ScreenUtil.getInstance().setWidth(750),
                height: ScreenUtil.getInstance().setHeight(778),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showSignIn(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          height: ScreenUtil.getInstance().setHeight(30),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.only(),
            child: TextField(
              style: TextStyle(color: Colors.white),
              controller: _emailController,
              decoration: InputDecoration(
                hintText: Controller.displayHintTextEmail,
                hintStyle: TextStyle(fontSize: 18.0, color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.0)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.0)),
                prefixIcon: const Icon(
                  Icons.email,
                  color: Colors.white,
                ),
              ),
              obscureText: false,
            ),
          ),
        ),
        SizedBox(
          height: ScreenUtil.getInstance().setHeight(50),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.only(),
            child: TextField(
              obscureText: true,
              style: TextStyle(color: Colors.white),
              controller: _passwordController,
              decoration: InputDecoration(
                //Add th Hint text here.
                hintText: Controller.displayHintTextPassword,
                hintStyle: TextStyle(fontSize: 18.0, color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.0)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.0)),
                prefixIcon: const Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: ScreenUtil.getInstance().setHeight(80),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.only(),
            child: RaisedButton(
              child: Row(
                children: <Widget>[
                  SocialIcon(iconData: CustomIcons.email),
                  Expanded(
                    child: Text(
                      Controller.displaySignInEmailButton,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  )
                ],
              ),
              color: Colors.blueGrey,
              onPressed: () => validateEmailWithFirebase(
                  context, _emailController, _passwordController),
            ),
          ),
        ),
        SizedBox(
          height: ScreenUtil.getInstance().setHeight(30),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.only(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                horizontalLine(),
                Text(Controller.displaySeparatorText,
                    style: TextStyle(color: Colors.white)),
                horizontalLine()
              ],
            ),
          ),
        ),
        SizedBox(
          height: ScreenUtil.getInstance().setHeight(30),
        ),
        Container(
          child: Padding(
              padding: EdgeInsets.only(),
              child: RaisedButton(
                child: Row(
                  children: <Widget>[
                    SocialIcon(iconData: CustomIcons.facebook),
                    Expanded(
                      child: Text(
                        Controller.displaySignInFacebookButton,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    )
                  ],
                ),
                color: Color(0xFF3C5A99),
                onPressed: () => _signInWithFacebook(context),
              )),
        ),
      ],
    );
  }

  _showSignUp() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          height: ScreenUtil.getInstance().setHeight(30),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.only(),
            child: TextField(
              obscureText: false,
              style: TextStyle(color: Colors.white),
              controller: _newEmailController,
              decoration: InputDecoration(
                //Add th Hint text here.
                hintText: Controller.displayHintTextNewEmail,
                hintStyle: TextStyle(fontSize: 18.0, color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.0)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.0)),
                prefixIcon: const Icon(
                  Icons.email,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: ScreenUtil.getInstance().setHeight(50),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.only(),
            child: TextField(
              obscureText: true,
              style: TextStyle(color: Colors.white),
              controller: _newPasswordController,
              decoration: InputDecoration(
                //Add the Hint text here.
                hintText: Controller.displayHintTextNewPassword,
                hintStyle: TextStyle(fontSize: 18.0, color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.0)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.0)),
                prefixIcon: const Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: ScreenUtil.getInstance().setHeight(80),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.only(),
            child: RaisedButton(
              child: Text(
                Controller.displaySignUpMenuButton,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
              color: Colors.blueGrey,
              onPressed: () => signUpWithEmailAndPassword(
                  _newEmailController, _newPasswordController),
            ),
          ),
        ),
      ],
    );
  }

  void onLoginStatusChanged(bool isLoggedIn, {profileData}) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
      this.profileData = profileData;
    });
  }

  void validateEmailWithFirebase(context, TextEditingController email,
      TextEditingController password) async {
    try {
      AuthResult result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.text.trim().toLowerCase(), password: password.text);
      print('Signed in: ${result.user.uid}');
      navigateToProfile(context);
    } catch (e) {
      print('Error: $e');
    }
  }

  void signUpWithEmailAndPassword(
      TextEditingController email, TextEditingController password) async {
    try {
      AuthResult result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text.trim().toLowerCase(), password: password.text);
      print('Signed up: ${result.user.uid}');
    } catch (e) {
      print('Error: $e');
    }
  }

  void changeToSignUp() {
    _signUpActive = true;
    _signInActive = false;
  }

  void changeToSignIn() {
    _signUpActive = false;
    _signInActive = true;
  }

  void _signInWithFacebook(context) async {
    final FacebookLoginResult result =
        await facebookLogin.logInWithReadPermissions(['email']);

    final AuthCredential credential = FacebookAuthProvider.getCredential(
      accessToken: result.accessToken.token,
    );
    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    setState(() {
      if (user != null) {
        print('Successfully signed in with Facebook. ' + user.uid);
        navigateToProfile(context);
      } else {
        print('Failed to sign in with Facebook. ');
      }
    });
  }

  Future navigateToProfile(context) async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => Profile()));
  }
}

class Controller extends ControllerMVC {
  /// Singleton Factory
  factory Controller() {
    if (_this == null) _this = Controller._();
    return _this;
  }

  static Controller _this;

  Controller._();

  /// Allow for easy access to 'the Controller' throughout the application.
  static Controller get con => _this;

  static String get displayLogoTitle => Model._logoTitle;

  static String get displayLogoSubTitle => Model._logoSubTitle;

  static String get displaySignUpMenuButton => Model._signUpMenuButton;

  static String get displaySignInMenuButton => Model._signInMenuButton;

  static String get displayHintTextEmail => Model._hintTextEmail;

  static String get displayHintTextPassword => Model._hintTextPassword;

  static String get displayHintTextNewEmail => Model._hintTextNewEmail;

  static String get displayHintTextNewPassword => Model._hintTextNewPassword;

  static String get displaySignUpButtonTest => Model._signUpButtonText;

  static String get displaySignInEmailButton =>
      Model._signInWithEmailButtonText;

  static String get displaySignInFacebookButton =>
      Model._signInWithFacebookButtonText;

  static String get displaySeparatorText =>
      Model._alternativeLogInSeparatorText;
}

class Model {
  static String _logoTitle = "MOMENTUM";
  static String _logoSubTitle = "GROWTH * HAPPENS * TODAY";
  static String _signInMenuButton = "SIGN IN";
  static String _signUpMenuButton = "SIGN UP";
  static String _hintTextEmail = "Email";
  static String _hintTextPassword = "Password";
  static String _hintTextNewEmail = "Enter your Email";
  static String _hintTextNewPassword = "Enter a Password";
  static String _signUpButtonText = "SIGN UP";
  static String _signInWithEmailButtonText = "Sign in with Email";
  static String _signInWithFacebookButtonText = "Sign in with Facebook";
  static String _alternativeLogInSeparatorText = "or";
}
