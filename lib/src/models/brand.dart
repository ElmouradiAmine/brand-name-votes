import 'package:cloud_firestore/cloud_firestore.dart';

class Brand {
  final String name;
  final int votes;
  final DocumentReference reference;

  Brand.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['votes'] != null),
        name = map["name"],
        votes = map["votes"];

  Brand.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
