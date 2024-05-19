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

  Future<void> signUpWithEmailPassword(
    String email,
    String password,
    String firstName,
    String lastName,
    String userName,
    String phoneNumber,
    String birthDate,
    String sex,
  ) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await addUserToFirestore(
        userCredential.user!.uid,
        email,
        firstName,
        lastName,
        userName ?? 'NA',
        phoneNumber ?? 'NA',
        birthDate ?? 'NA',
        sex ?? 'NA',
      );
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

      Map<String, dynamic> userData =
          await getUserData(userCredential.user!.uid);

      return {'user': userCredential.user, 'userData': userData};
    } catch (e) {
      print('Failed to sign in: $e');
      throw Exception('Failed to sign in');
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      await _auth.signOut();

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
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

      if (userCredential.additionalUserInfo!.isNewUser) {
        List<String> nameParts = googleUser.displayName!.split(' ');
        String firstName = nameParts.first;
        String lastName = nameParts.length > 1 ? nameParts.last : '';
        String sex = 'NA';
        String phoneNumber = 'NA';
        String birthDate = 'NA';

        await addUserToFirestore(
          userCredential.user!.uid,
          userCredential.user!.email!,
          firstName,
          lastName,
          null,
          phoneNumber,
          birthDate,
          sex,
        );
      }

      return userCredential.user;
    } catch (e) {
      print('Failed to sign in with Google: $e');
      throw Exception('Failed to sign in with Google');
    }
  }

  Future<void> addUserToFirestore(
    String uid,
    String email,
    String firstName,
    String lastName,
    String? userName,
    String phoneNumber,
    String birthDate,
    String sex,
  ) async {
    try {
      await _firestore.collection('Users').doc(uid).set({
        'Email': email,
        'FirstName': firstName,
        'LastName': lastName,
        'UserName': userName ?? 'NA',
        'Sex': sex ?? 'NA',
        'PhoneNumber': phoneNumber ?? 'NA',
        'BirthDate': birthDate ?? 'NA',
      });
    } catch (e) {
      print('Failed to add user to Firestore: $e');
      throw Exception('Failed to add user to Firestore');
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
    } catch (e) {
      print('Failed to sign out: $e');
      throw Exception('Failed to sign out');
    }
  }
}
