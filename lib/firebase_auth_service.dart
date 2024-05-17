import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<Map<String, dynamic>> getUserData(String uid) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('Users').doc(uid).get();
      if (snapshot.exists) {
        return snapshot.data() as Map<String, dynamic>;
      } else {
        throw Exception('User data not found');
      }
    } catch (e) {
      print('Failed to get user data: $e');
      throw Exception('Failed to get user data');
    }
  }

  Future<void> signUpWithEmailPassword(String email, String password,
      String firstName, String lastName, String userName) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await addUserToFirestore(
          userCredential.user!.uid, email, firstName, lastName, userName);
    } catch (e) {
      print('Failed to sign up: $e');
      throw Exception('Failed to sign up');
    }
  }

  Future<Map<String, dynamic>> signInWithEmailPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Retrieve user data from Firestore
      Map<String, dynamic> userData =
          await getUserData(userCredential.user!.uid);

      // Return a map containing user object and user's firstName
      return {'user': userCredential.user, 'firstName': userData['FirstName']};
    } catch (e) {
      print('Failed to sign in: $e');
      throw Exception('Failed to sign in');
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      await _auth.signOut(); // Sign out current user

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // The user canceled the sign-in
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      // Check if the user is new and add to Firestore if necessary
      if (userCredential.additionalUserInfo!.isNewUser) {
        List<String> nameParts = googleUser.displayName!.split(' ');
        String firstName = nameParts.first;
        String lastName = nameParts.length > 1 ? nameParts.last : '';

        await addUserToFirestore(
            userCredential.user!.uid,
            userCredential.user!.email!,
            firstName,
            lastName,
            ''); // No username provided for Google sign-in
      }

      return userCredential.user;
    } catch (e) {
      print('Failed to sign in with Google: $e');
      throw Exception('Failed to sign in with Google');
    }
  }

  // Method to add user data to Firestore
  Future<void> addUserToFirestore(String uid, String email, String firstName,
      String lastName, String userName) async {
    try {
      await _firestore.collection('Users').doc(uid).set({
        'Email': email,
        'FirstName': firstName,
        'LastName': lastName,
        'UserName': userName,
      });
    } catch (e) {
      print('Failed to add user to Firestore: $e');
      throw Exception('Failed to add user to Firestore');
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut(); // Sign out Google user as well
    } catch (e) {
      print('Failed to sign out: $e');
      throw Exception('Failed to sign out');
    }
  }
}
