import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../module/auth/screen/splash_screen/splash_screen_view_model.dart';

class Authentication {
  // static String provider = '';
  // static String uid = '';
  // static String name = '';
  // static String emailAddress = '';
  // static String password = '';
  // static String profilePhoto = '';

  Authentication() {}

  // static void initializeFirebase() async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );
  //   // await FirebaseAuth.instance.useAuthEmulator('localhost', 5575);
  // }

  static void checkAuth({required BuildContext context}) {
    var duration = const Duration(seconds: 3);
    Timer(duration, () {
      SplashScreenViewModel.startOnboard(context: context);

      // FirebaseAuth.instance.userChanges().listen(
      //   (User? user) async {
      //     if (user == null) {
      //       print('User is currently signed out!');
      //       SplashScreenViewModel.startOnboard(context: context);
      //     } else {
      //       print('User is signed in!');
      //       await getData();
      //       LoginViewModel.onCallBackLogin(context: context);
      //     }
      //   },
      // );
    });
  }

  // static void createUserWithEmailAndPassword({required BuildContext context}) async {
  //   final registerViewModel = context.read<RegisterViewModel>();
  //   try {
  //     await FirebaseAuth.instance
  //         .createUserWithEmailAndPassword(
  //       email: registerViewModel.emailController.text,
  //       password: registerViewModel.passwordController.text,
  //     )
  //         .then((value) async {
  //       await value.user?.updateDisplayName(registerViewModel.nameController.text);
  //     }).then((value) async {
  //       await FirebaseAuth.instance.signOut();
  //       registerViewModel.navigateToLoginScreen(context: context);
  //     });
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         customSnackBar(
  //           content: 'The password provided is too weak.',
  //           context: context,
  //         ),
  //       );
  //       print('The password provided is too weak.');
  //     } else if (e.code == 'email-already-in-use') {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         customSnackBar(
  //           content: 'The account already exists for that email.',
  //           context: context,
  //         ),
  //       );
  //       print('The account already exists for that email.');
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // static void signInWithEmailPassword({required BuildContext context}) async {
  //   final loginViewModel = context.read<LoginViewModel>();
  //   try {
  //     await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: loginViewModel.emailController.text,
  //         password: loginViewModel.passwordController.text);
  //     LoginViewModel.onCallBackLogin(context: context);
  //   } on FirebaseAuthException catch (e) {
  //     var error;
  //     if (e.code == 'user-not-found') {
  //       error = 'No user found for that email.';
  //     } else if (e.code == 'wrong-password') {
  //       error = 'Wrong password provided for that user.';
  //     } else if (e.code == 'channel-error') {
  //       error = 'Field is empty.';
  //     } else if (e.code == 'invalid-email') {
  //       error = 'The email address is badly formatted.';
  //     } else {
  //       error = 'Error logging in. Try again.';
  //     }
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       customSnackBar(
  //         content: error,
  //         context: context,
  //       ),
  //     );
  //   }
  // }

  // static Future<User?> signInWithGoogle({required BuildContext context}) async {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   User? user;
  //   var error;

  //   final GoogleSignIn googleSignIn = GoogleSignIn();

  //   final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

  //   if (googleSignInAccount != null) {
  //     final GoogleSignInAuthentication googleSignInAuthentication =
  //         await googleSignInAccount.authentication;

  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleSignInAuthentication.accessToken,
  //       idToken: googleSignInAuthentication.idToken,
  //     );

  //     try {
  //       final UserCredential userCredential = await auth.signInWithCredential(credential);

  //       user = userCredential.user;
  //       LoginViewModel.onCallBackLogin(context: context);
  //     } on FirebaseAuthException catch (e) {
  //       if (e.code == 'account-exists-with-different-credential') {
  //         error = 'The account already exists with a different credential.';
  //       } else if (e.code == 'invalid-credential') {
  //         error = 'Error occurred while accessing credentials. Try again.';
  //       }
  //     } catch (e) {
  //       error = 'Error occurred while accessing credentials. Try again.';
  //     }
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       customSnackBar(
  //         content: error,
  //         context: context,
  //       ),
  //     );
  //   }
  //   return user;
  // }

  // static void signOut({required BuildContext context}) async {
  //   try {
  //     await FirebaseAuth.instance.signOut();
  //     await GoogleSignIn().disconnect();
  //     navigateToLoginScreen(context: context);
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       customSnackBar(
  //         content: 'Error signing out. Try again.',
  //         context: context,
  //       ),
  //     );
  //   }
  // }

  // static void navigateToLoginScreen({required BuildContext context}) {
  //   Navigator.of(context).pushReplacement(CupertinoPageRoute(
  //     builder: (context) => const LoginScreen(),
  //   ));
  // }

  // static void updateProfile({required BuildContext context}) async {
  //   final profileViewModel = context.read<MainProfileViewModel>();
  //   final user = FirebaseAuth.instance.currentUser;
  //   if (user != null) {
  //     await user.updateDisplayName(profileViewModel.name.text).then((value) {
  //       user.updateEmail(profileViewModel.email.text);
  //     }).then((value) {
  //       user.updatePassword(profileViewModel.password.text);
  //     });
  //   }
  // }

  // static getData() {
  //   final user = FirebaseAuth.instance.currentUser;
  //   if (user != null) {
  //     for (final providerProfile in user.providerData) {
  //       // ID of the provider (google.com, apple.com, etc.)
  //       provider = providerProfile.providerId;

  //       // UID specific to the provider
  //       uid = providerProfile.uid ?? '';

  //       // Name, email address, and profile photo URL
  //       name = providerProfile.displayName ?? '';
  //       emailAddress = providerProfile.email ?? '';
  //       profilePhoto = providerProfile.photoURL ?? '';
  //     }
  //   }
  // }

  // static SnackBar customSnackBar({required String content, required BuildContext context}) {
  //   return SnackBar(
  //     backgroundColor: Colors.transparent,
  //     elevation: 0,
  //     content: Container(
  //       margin: EdgeInsets.symmetric(
  //           horizontal: MediaQuery.of(context).size.width * 0.25, vertical: 10),
  //       padding: const EdgeInsets.all(2),
  //       decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(4)),
  //       child: Text(
  //         content,
  //         style: TextStyle(
  //           color: Colors.red,
  //           fontSize: 16,
  //         ),
  //         textAlign: TextAlign.center,
  //       ),
  //     ),
  //   );
  // }
}
