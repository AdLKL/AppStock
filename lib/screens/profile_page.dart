import 'package:appstock/screens/auth/components/text_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final usersCollection = FirebaseFirestore.instance.collection('users');

  //edit field
  Future<void> editField(String field) async {
    String newValue = "";
    bool saveClicked = false;

    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.grey[900],
              title: Text(
                "Edit $field",
                style: const TextStyle(color: Colors.white),
              ),
              content: TextField(
                autofocus: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Enter new $field",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                onChanged: (value) {
                  newValue = value;
                },
              ),
              actions: [
                // cancel button
                TextButton(
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () => Navigator.pop(context)),

                // save button
                TextButton(
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      saveClicked = true;
                      Navigator.of(context).pop(newValue);
                    })
              ],
            ));

    // update in firestore
    if (newValue.trim().isNotEmpty) {
      await usersCollection.doc(currentUser.uid).update({field: newValue});
      updateEmail(newValue);
    } else if (saveClicked && newValue.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'The $field cannot be empty!',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }

  // Function to update user's email
  Future<void> updateEmail(String newEmail) async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Reauthenticate if required
        // Uncomment the next lines if reauthentication is needed
        // AuthCredential credential = EmailAuthProvider.credential(
        //   email: user.email!,
        //   password: 'currentPassword', // Provide the user's current password
        // );
        // await user.reauthenticateWithCredential(credential);

        // Update the email
        await user.updateEmail(newEmail);

        // Send email verification for the new email
        await user.sendEmailVerification();

        print("Email updated successfully. Please verify the new email.");
      } else {
        print("User not signed in.");
      }
    } catch (e) {
      print("Error updating email: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
            title: const Text(
              "Profile Page",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: const Color(0xff19143b)),
        body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(currentUser.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userData = snapshot.data!.data() as Map<String, dynamic>;

              return ListView(
                children: [
                  const SizedBox(
                    height: 50,
                  ),

                  // profile pic
                  const Icon(
                    Icons.person,
                    size: 72,
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  // user email
                  Text(
                    currentUser.email!,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[700]),
                  ),

                  const SizedBox(
                    height: 50,
                  ),

                  //user details
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Text(
                      'My Details',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),

                  // username
                  MyTextBox(
                    text: userData['name'],
                    sectionName: 'Name',
                    onPressed: () => editField('name'),
                  ),
                  // email
                  MyTextBox(
                    text: userData['email'],
                    sectionName: 'Email',
                    onPressed: () => editField('email'),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error${snapshot.error}'),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
