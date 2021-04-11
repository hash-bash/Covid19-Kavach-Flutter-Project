import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference users = FirebaseFirestore.instance.collection('Users');

Future<void> userSetup(
    String nameText,
    String ageText,
    String phoneText,
    String emailText,
    String genderText,
    String addressText,
    String imgUrl,
    String question1,
    String question2,
    String question3,
    String question4,
    String question5,
    String question6,
    String question7,
    String question8,
    String question9,
    String uid) async {
  users.doc(uid).set({
    'nameText': nameText,
    'ageText': ageText,
    'phoneText': phoneText,
    'emailText': emailText,
    'genderText': genderText,
    'addressText': addressText,
    'imgUrl': imgUrl,
    'question1': question1,
    'question2': question2,
    'question3': question3,
    'question4': question4,
    'question5': question5,
    'question6': question6,
    'question7': question7,
    'question8': question8,
    'question9': question9,
    'uid': uid
  });
  return;
}

Future<List<DocumentSnapshot>> fetchDetails() => users.get().then((value) {
      return value.docs;
    });

Future<List<String>> fetchParticularUserDetails(userId) =>
    users.doc(userId).get().then((value) {
      return [
        value['nameText'],
        value['ageText'],
        value['phoneText'],
        value['emailText'],
        value['genderText'],
        value['addressText'],
        value['imgUrl'],
        value['question1'],
        value['question2'],
        value['question3'],
        value['question4'],
        value['question5'],
        value['question6'],
        value['question7'],
        value['question8'],
        value['question9'],
      ];
    });
