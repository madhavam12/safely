import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:geocoding/geocoding.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:geolocator/geolocator.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
//signs out the current user
  Future signOut() async {
    await _auth.signOut();
    final GoogleSignIn googleUser = GoogleSignIn();
    if (googleUser.currentUser != null) {
      googleUser.signOut();
    }
  }

  var signIn;
  //function which signs in the current user
  signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential user;
    try {
      user = await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      if (e is FirebaseAuthException) {
        String errorMessage = getErrorMessage1(errorCode: e.code);

        return errorMessage;
      }

      return "Unknown error occured. If it persists, try logging in with phone or email instead.";
    }

    return user.user;
  }
}

//returns an appropriate error message
String getErrorMessage1({String errorCode}) {
  switch (errorCode) {
    case 'app-deleted':
      return 'The database was not found.';
    case 'expired-action-code':
      return 'The action code o or link has expired.';
    case 'invalid-action-code':
      return 'The action code is invalid. This can happen if the code is malformed or has already been used. ';
    case 'user-disabled':
      return 'The user corresponding to the supplied credential has been disabled.';
    case 'user-not-found':
      return 'The user does not match any credentials.';
    case 'weak-password':
      return 'The password is too weak.';
    case 'email-already-in-use':
      return 'An account already exists with the email address provided.';
    case 'invalid-email':
      return 'The email address is not valid.';
    case 'operation-not-allowed':
      return 'The type of account corresponding to this credential is not yet activated.';
    case 'account-exists-with-different-credential':
      return 'E-mail already associated with another account.';
    case 'auth-domain-config-required':
      return 'The configuration for authentication has not been provided.';
    case 'credential-already-in-use':
      return 'An account already exists for this credential.';
    case 'operation-not-supported-in-this-environment':
      return 'This operation is not supported in the environment being performed. Make sure it must be http or https. ';
    case 'timeout':
      return 'Response time exceeded. The domain may not be authorized to perform operations. ';
    case 'missing-android-pkg-name':
      return 'A package name must be provided to install the Android application.';
    case 'missing-continue-uri':
      return 'The next URL must be provided in the request.';
    case 'missing-ios-bundle-id':
      return 'A package name must be provided to install the iOS application.';
    case 'invalid-continue-uri':
      return 'The next URL provided in the request is invalid.';
    case 'unauthorized-continue-uri':
      return 'The domain of the next URL is not whitelisted.';
    case 'invalid-dynamic-link-domain':
      return 'The dynamic link domain provided is not authorized or configured in the current project.';
    case 'argument-error':
      return 'Check the link configuration for the application.';
    case 'invalid-persistence-type':
      return 'The type specified for data persistence is invalid.';
    case 'unsupported-persistence-type':
      return 'The current environment does not support the type specified for data persistence.';
    case 'invalid-credential':
      return 'The credential has expired or is malformed.';
    case 'wrong-password':
      return 'Incorrect password.';
    case 'invalid-verification-code':
      return 'The credential verification code is not valid.';
    case 'invalid-verification-id':
      return 'The credential verification ID is not valid.';
    case 'custom-token-mismatch':
      return 'The token is different from the default requested.';
    case 'invalid-custom-token':
      return 'The provided token is not valid.';
    case 'captcha-check-failed':
      return 'The reCAPTCHA response token is not valid, has expired, or the domain is not allowed.';
    case 'invalid-phone-number':
      return 'The phone number is in an invalid format (E.164 standard).';
    case 'missing-phone-number':
      return 'The phone number is required.';
    case 'quota-exceeded':
      return 'The SMS quota has been exceeded.';
    case 'canceled-popup-request':
      return 'Only one pop-up window request is allowed at one time.';
    case 'popup-blocked':
      return 'The pop-up window has been blocked by the browser.';
    case 'popup-closed-by-user':
      return 'The pop-up window was closed by the user without completing login to the provider.';
    case 'unauthorized-domain':
      return 'The application domain is not authorized to perform operations.';
    case 'invalid-user-token':
      return 'The current user has not been identified.';
    case 'user-token-expired':
      return 'The current user\'s token has expired.';
    case 'null-user':
      return 'The current user is null.';
    case 'app-not-authorized':
      return 'Unauthorized application to authenticate with the given key.';
    case 'invalid-api-key':
      return 'The supplied API key is invalid.';
    case 'network-request-failed':
      return 'Failed to connect to the network.';
    case 'requires-recent-login':
      return 'The user\'s last access time does not meet the security limit.';
    case 'too-many-requests':
      return 'Requests have been blocked due to unusual activity. Try again after some time. ';
    case 'web-storage-unsupported':
      return 'The browser does not support storage or if the user has disabled this feature.';
    case 'invalid-claims':
      return 'The custom registration attributes are invalid.';
    case 'claims-too-large':
      return 'The request size exceeds the maximum allowed size of 1 Megabyte.';
    case 'id-token-expired':
      return 'The reported token has expired.';
    case 'id-token-revoked':
      return 'The informed token has expired.';
    case 'invalid-argument':
      return 'An invalid argument was given to a method.';
    case 'invalid-creation-time':
      return 'Creation time must be a valid UTC date.';
    case 'invalid-disabled-field':
      return 'The property for disabled user is invalid.';
    case 'invalid-display-name':
      return 'The user name is invalid.';
    case 'invalid-email-verified':
      return 'The email is invalid.';
    case 'invalid-hash-algorithm':
      return 'The HASH algorithm is not compatible encryption.';
    case 'invalid-hash-block-size':
      return 'The HASH block size is not valid.';
    case 'invalid-hash-derived-key-length':
      return 'The size of the HASH-derived key is not valid.';
    case 'invalid-hash-key':
      return 'The HASH key must have a valid byte buffer.';
    case 'invalid-hash-memory-cost':
      return 'The cost of HASH memory is not valid.';
    case 'invalid-hash-parallelization':
      return 'HASH parallel loading is not valid.';
    case 'invalid-hash-rounds':
      return 'HASH rounding is not valid.';
    case 'invalid-hash-salt-separator':
      return 'The HASH generation algorithm SALT separator field must be a valid byte buffer.';
    case 'invalid-id-token':
      return 'The token code entered is not valid.';
    case 'invalid-last-sign-in-time':
      return 'The last login time must be a valid UTC date.';
    case 'invalid-page-token':
      return 'The next URL provided in the request is invalid.';
    case 'invalid-password':
      return 'The password is invalid, it must be at least 6 characters long.';
    case 'invalid-password-hash':
      return 'The password HASH is not valid.';
    case 'invalid-password-salt':
      return 'The password SALT is not valid.';
    case 'invalid-photo-url':
      return 'The user photo URL is invalid.';
    case 'invalid-provider-id':
      return 'The provider identifier is not supported.';
    case 'invalid-session-cookie-duration':
      return 'The duration of the session COOKIE must be a valid number in milliseconds, between 5 minutes and 2 weeks.';
    case 'invalid-uid':
      return 'The provided identifier must be a maximum of 128 characters.';
    case 'invalid-user-import':
      return 'The user record to be imported is not valid.';
    case 'invalid-provider-data':
      return 'The data provider is not valid.';
    case 'maximum-user-count-exceeded':
      return 'The maximum number of users allowed to be imported has been exceeded.';
    case 'missing-hash-algorithm':
      return 'It is necessary to provide the HASH generation algorithm and its parameters to import users.';
    case 'missing-uid':
      return 'An identifier is required for the current operation.';
    case 'reserved-claims':
      return 'One or more custom properties provided used reserved words.';
    case 'session-cookie-revoked':
      return 'The session COOKIE has expired.';
    case 'uid-alread-exists':
      return 'The provided identifier is already in use.';
    case 'email-already-exists':
      return 'The email provided is already in use.';
    case 'phone-number-already-exists':
      return 'The phone provided is already in use.';
    case 'project-not-found':
      return 'No projects were found.';
    case 'insufficient-permission':
      return 'The credential used is not allowed to access the requested resource.';
    case 'internal-error':
      return 'The authentication server encountered an unexpected error while trying to process the request.';
    default:
      return "null";
  }
}
