import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';

class FirebaseAuthAPI {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static GoogleSignIn _googleSignIn = GoogleSignIn();

  FirebaseUser firebaseUser;

  FirebaseAuthAPI(FirebaseUser user) {
    this.firebaseUser = user;
  }

  static Future<FirebaseAuthAPI> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    AuthCredential authCredential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final AuthResult result = await _auth.signInWithCredential(authCredential);

    assert(result.user.email != null);
    assert(result.user.displayName != null);

    assert(await result.user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(result.user.uid == currentUser.uid);

    return FirebaseAuthAPI(result.user);
  }

  static Future<FirebaseAuthAPI> signInWithTwitter() async {
    var twitterLogin = new TwitterLogin(
      consumerKey: 'VNdHHc2LwyHqipiVP2QHw',
      consumerSecret: 'fu7bIiIamWR1vbkQaDP97PM0F5Yb1GKAxvEL7JCLI',
    );

    final TwitterLoginResult result = await twitterLogin.authorize();

    switch (result.status) {
      case TwitterLoginStatus.loggedIn:
        var session = result.session;
        break;
      case TwitterLoginStatus.cancelledByUser:
        break;
      case TwitterLoginStatus.error:
        break;
    }
  }
}
