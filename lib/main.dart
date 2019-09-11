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

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return MaterialApp(
        theme: _buildDarkTheme(),
        home: Scaffold(
          resizeToAvoidBottomPadding: true,
          body: new Builder(
              builder: (context) =>
              new Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Theme
                              .of(context)
                              .primaryColor,
                          Theme
                              .of(context)
                              .primaryColorLight
                        ])),
                child: Padding(
                  padding: EdgeInsets.only(top: 40.0),
                  //Sets the main padding all widgets has to adhere to.
                  child: LogInPage(),
                ),
              )
          ),
        )
    );
  }
}

class _LogInPageState extends StateMVC<LogInPage> {
  _LogInPageState() : super(Controller());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    ScreenUtil.instance = ScreenUtil.getInstance()
      ..init(context);
    ScreenUtil.instance =
    ScreenUtil(width: 750, height: 1304, allowFontScaling: true)
      ..init(context);
    return Column(
      children: <Widget>[
        Container(
          child: Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                      Controller.displayLogoTitle,
                      style: CustomTextStyle.title(context)
                  ),
                  Text(
                    Controller.displayLogoSubTitle,
                    style: CustomTextStyle.subTitle(context),
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
                    onPressed: () =>
                        setState(() => Controller.changeToSignIn()),
                    borderSide: new BorderSide(
                      style: BorderStyle.none,
                    ),
                    child: new Text(Controller.displaySignInMenuButton,
                        style: _signInActive
                            ? TextStyle(
                            fontSize: 22,
                            color: Theme
                                .of(context)
                                .accentColor,
                            fontWeight: FontWeight.bold)
                            : TextStyle(
                            fontSize: 16,
                            color: Theme
                                .of(context)
                                .accentColor,
                            fontWeight: FontWeight.normal)),
                  ),
                  OutlineButton(
                    onPressed: () =>
                        setState(() => Controller.changeToSignUp()),
                    borderSide: BorderSide(
                      style: BorderStyle.none,
                    ),
                    child: Text(Controller.displaySignUpMenuButton,
                        style: _signUpActive
                            ? TextStyle(
                            fontSize: 22,
                            color: Theme
                                .of(context)
                                .accentColor,
                            fontWeight: FontWeight.bold)
                            : TextStyle(
                            fontSize: 16,
                            color: Theme
                                .of(context)
                                .accentColor,
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
              child: _signInActive ? _showSignIn(context) : _showSignUp()),
          width: ScreenUtil.getInstance().setWidth(750),
          height: ScreenUtil.getInstance().setHeight(778),
        ),
      ],
    );
  }

  Widget _showSignIn(context) {
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
              style: TextStyle(color: Theme
                  .of(context)
                  .accentColor),
              controller: _emailController,
              decoration: InputDecoration(
                hintText: Controller.displayHintTextEmail,
                hintStyle: CustomTextStyle.formField(context),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme
                            .of(context)
                            .accentColor, width: 1.0)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme
                            .of(context)
                            .accentColor, width: 1.0)),
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
              style: TextStyle(color: Theme
                  .of(context)
                  .accentColor),
              controller: _passwordController,
              decoration: InputDecoration(
                //Add th Hint text here.
                hintText: Controller.displayHintTextPassword,
                hintStyle: CustomTextStyle.formField(context),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme
                            .of(context)
                            .accentColor, width: 1.0)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme
                            .of(context)
                            .accentColor, width: 1.0)),
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
                      style: CustomTextStyle.button(context),
                    ),
                  )
                ],
              ),
              color: Colors.blueGrey,
              onPressed: () =>
                  Controller.tryToLogInUserViaEmail(
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
                    style: CustomTextStyle.body(context)),
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
                        style: CustomTextStyle.button(context),
                      ),
                    )
                  ],
                ),
                color: Color(0xFF3C5A99),
                onPressed: () => Controller.tryToLogInUserViaFacebook(context),
              )),
        ),
      ],
    );
  }

  Widget _showSignUp() {
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
              style: CustomTextStyle.formField(context),
              controller: _newEmailController,
              decoration: InputDecoration(
                //Add th Hint text here.
                hintText: Controller.displayHintTextNewEmail,
                hintStyle: CustomTextStyle.formField(context),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme
                            .of(context)
                            .accentColor, width: 1.0)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme
                            .of(context)
                            .accentColor, width: 1.0)),
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
              style: CustomTextStyle.formField(context),
              controller: _newPasswordController,
              decoration: InputDecoration(
                //Add the Hint text here.
                hintText: Controller.displayHintTextNewPassword,
                hintStyle: CustomTextStyle.formField(context),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme
                            .of(context)
                            .accentColor, width: 1.0)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme
                            .of(context)
                            .accentColor, width: 1.0)),
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
                style: CustomTextStyle.button(context),
              ),
              color: Colors.blueGrey,
              onPressed: () =>
                  Controller.signUpWithEmailAndPassword(
                      _newEmailController, _newPasswordController),
            ),
          ),
        ),
      ],
    );
  }

  Widget horizontalLine() =>
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: ScreenUtil.getInstance().setWidth(120),
          height: 1.0,
          color: Colors.white.withOpacity(0.6),
        ),
      );

  Widget emailErrorText() => Text(Controller.displayErrorEmailLogIn);
}

class LogInPage extends StatefulWidget {
  LogInPage({Key key}) : super(key: key);

  @protected
  @override
  State<StatefulWidget> createState() => _LogInPageState();
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

  /// The Controller doesn't know any values or methods. It simply handles the communication between the view and the model.

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

  static String get displayErrorEmailLogIn => Model._emailLogInFailed;

  static void changeToSignUp() => Model._changeToSignUp();

  static void changeToSignIn() => Model._changeToSignIn();

  static Future<bool> signInWithFacebook(context) =>
      Model._signInWithFacebook(context);

  static Future<bool> signInWithEmail(context, email, password) =>
      Model._signInWithEmail(context, email, password);

  static void signUpWithEmailAndPassword(email, password) =>
      Model._signUpWithEmailAndPassword(email, password);

  static Future navigateToProfile(context) => Model._navigateToProfile(context);

  static Future tryToLogInUserViaFacebook(context) async {
    if (await signInWithFacebook(context) == true) {
      navigateToProfile(context);
    }
  }

  static Future tryToLogInUserViaEmail(context, email, password) async {
    if (await signInWithEmail(context, email, password) == true) {
      navigateToProfile(context);
    }
  }

  static Future tryToSignUpWithEmail(email, password) async {
    if (await tryToSignUpWithEmail(email, password) == true) {
      //TODO Display success message or go to Login screen
    } else {
      //TODO Display error message and stay put.
    }
  }
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
  static String _emailLogInFailed =
      "Email or Password was incorrect. Please try again";

  static void _changeToSignUp() {
    _signUpActive = true;
    _signInActive = false;
  }

  static void _changeToSignIn() {
    _signUpActive = false;
    _signInActive = true;
  }

  static Future<bool> _signInWithFacebook(context) async {
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
    if (user != null) {
      print('Successfully signed in with Facebook. ' + user.uid);
      return true;
    } else {
      print('Failed to sign in with Facebook. ');
      return false;
    }
  }

  static Future<bool> _signInWithEmail(context, TextEditingController email,
      TextEditingController password) async {
    try {
      AuthResult result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: email.text.trim().toLowerCase(), password: password.text);
      print('Signed in: ${result.user.uid}');
      return true;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  static Future<bool> _signUpWithEmailAndPassword(TextEditingController email,
      TextEditingController password) async {
    try {
      AuthResult result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: email.text.trim().toLowerCase(), password: password.text);
      print('Signed up: ${result.user.uid}');
      return true;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  static Future _navigateToProfile(context) async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => Profile()));
  }
}

ThemeData _buildDarkTheme() {
  final baseTheme = ThemeData(
    fontFamily: "Open Sans",
  );
  return baseTheme.copyWith(
    brightness: Brightness.dark,
    primaryColor: Color(0xFF143642),
    primaryColorLight: Color(0xFF26667d),
    primaryColorDark: Color(0xFF08161b),
    primaryColorBrightness: Brightness.dark,
    accentColor: Colors.white,
  );
}

class CustomTextStyle {
  static TextStyle formField(BuildContext context) {
    return Theme
        .of(context)
        .textTheme
        .title
        .copyWith(
        fontSize: 18.0, fontWeight: FontWeight.normal, color: Colors.white);
  }

  static TextStyle title(BuildContext context) {
    return Theme
        .of(context)
        .textTheme
        .title
        .copyWith(
        fontSize: 34, fontWeight: FontWeight.bold, color: Colors.white);
  }

  static TextStyle subTitle(BuildContext context) {
    return Theme
        .of(context)
        .textTheme
        .title
        .copyWith(
        fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white);
  }

  static TextStyle button(BuildContext context) {
    return Theme
        .of(context)
        .textTheme
        .title
        .copyWith(
        fontSize: 20, fontWeight: FontWeight.normal, color: Colors.white);
  }

  static TextStyle body(BuildContext context) {
    return Theme
        .of(context)
        .textTheme
        .title
        .copyWith(
        fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white);
  }
}
