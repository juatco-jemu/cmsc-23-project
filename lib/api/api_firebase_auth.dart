import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthAPI {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  User? getUser() {
    return auth.currentUser;
  }

  Stream<User?> userSignedIn() {
    return auth.authStateChanges();
  }

  Future<String?> signIn(String username, String password) async {
    try {
      // Search for the username in admins collection
      QuerySnapshot adminStream = await db
          .collection('admins')
          .where('adminUsername', isEqualTo: username)
          .limit(1)
          .get();

      if (adminStream.docs.isNotEmpty) {
        // Username found in admins, get the email
        String email = adminStream.docs.first['adminEmail'];
        await auth.signInWithEmailAndPassword(email: email, password: password);
        return 'successfully signed in as admin';
      }

      // Search for the username in donors collection
      QuerySnapshot donorStream = await db
          .collection('donors')
          .where('username', isEqualTo: username)
          .limit(1)
          .get();

      if (donorStream.docs.isNotEmpty) {
        // Username found in donors, get the email
        String email = donorStream.docs.first['email'];
        await auth.signInWithEmailAndPassword(email: email, password: password);
        return 'successfully signed in as donor';
      }

      // Search for the username in organizations collection
      QuerySnapshot orgStream = await db
          .collection('organizations')
          .where('orgUsername', isEqualTo: username)
          .limit(1)
          .get();

      if (orgStream.docs.isNotEmpty) {
        // Username found in organizations, get the email
        String email = orgStream.docs.first['orgEmail'];
        await auth.signInWithEmailAndPassword(email: email, password: password);
        return 'successfully signed in as organization';
      }

      return 'Username not found';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return 'Invalid email address.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password.';
      } else {
        return 'Failed at ${e.code}: ${e.message}';
      }
    }
  }

  Future<void> signUpDonor(
      String firstName,
      String lastName,
      String username,
      String email,
      List<String> addressList,
      String contactNumber,
      List<int> donationIDList,
      String password) async {
    UserCredential credential;

    try {
      // Check if the username already exists
      QuerySnapshot usernameSnapshot = await db
          .collection('donors')
          .where('username', isEqualTo: username)
          .get();

      if (usernameSnapshot.docs.isNotEmpty) {
        print('The username already exists. Please choose a different username.');
        return; // Exit the function if the username exists
      }

      // Create a new user
      credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await credential.user!.updateDisplayName('$firstName $lastName');

      // Save the new user to Firestore
      await db.collection('donors').doc(credential.user!.uid).set({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'username': username,
        'addressList': addressList,
        'contactNumber': contactNumber,
        'donationIDList': donationIDList,
      });

      // Print the object returned by createUserWithEmailAndPassword
      print(credential);
    } on FirebaseAuthException catch (e) {
      // Handle specific FirebaseAuthException errors
      if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else if (e.code == 'weak-password') {
        print('The password must be at least 6 characters long.');
      }
    } catch (e) {
      // Handle other errors
      print(e);
    }
  }

  Future<void> signUpOrganization(
      String orgName,
      String orgEmail,
      String orgUsername,
      String orgDescription,
      List<String> orgAddressList,
      String orgContactNumber,
      List<int> orgDriveIDList,
      String orgStatus,
      String password) async {
    UserCredential credential;

    try {
      // Check if the organization username already exists
      QuerySnapshot usernameSnapshot = await db
          .collection('organizations')
          .where('orgUsername', isEqualTo: orgUsername)
          .get();

      if (usernameSnapshot.docs.isNotEmpty) {
        print('The organization username already exists. Please choose a different username.');
        return; // Exit the function if the username exists
      }

      // Create a new user
      credential = await auth.createUserWithEmailAndPassword(
        email: orgEmail,
        password: password,
      );

      await credential.user!.updateDisplayName(orgName);

      // Save the new organization to Firestore
      await db.collection('organizations').doc(credential.user!.uid).set({
        'orgName': orgName,
        'orgEmail': orgEmail,
        'orgUsername': orgUsername,
        'orgDescription': orgDescription,
        'orgAddressList': orgAddressList,
        'orgContactNumber': orgContactNumber,
        'orgDriveIDList': orgDriveIDList,
        'orgStatus': orgStatus
      });

      // Print the object returned by createUserWithEmailAndPassword
      print(credential);
    } on FirebaseAuthException catch (e) {
      // Handle specific FirebaseAuthException errors
      if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else if (e.code == 'weak-password') {
        print('The password must be at least 6 characters long.');
      }
    } catch (e) {
      // Handle other errors
      print(e);
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  Future<bool> isAdmin (String email) async {
    try {
      QuerySnapshot adminStream = await db
          .collection('admins')
          .where('adminEmail', isEqualTo: email)
          .limit(1)
          .get();
      return adminStream.docs.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Future<bool> isDonor (String email) async {
    try {
      QuerySnapshot donorStream = await db
          .collection('donors')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();
      return donorStream.docs.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Future<bool> isOrganization (String email) async {
    try {
      QuerySnapshot orgStream = await db
          .collection('organizations')
          .where('orgEmail', isEqualTo: email)
          .limit(1)
          .get();
      return orgStream.docs.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}
