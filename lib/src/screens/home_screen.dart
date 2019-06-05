import 'package:flutter/material.dart';
import '../models/brand.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

final dummySnapshot = [
  {"name": "Itwins", "votes": 13},
  {"name": "Itech", "votes": 3},
  {"name": "NinjaTech", "votes": 12},
];

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Brand Name votes'),
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showForm(context);
          }),
    );
  }

  Widget _buildBody() {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("brands").snapshots(),
      builder: (context, snapshot) {
        return Center(
          child: snapshot.hasData
              ? _buildList(snapshot.data.documents)
              : CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _buildList(List<DocumentSnapshot> snapshot) {
    snapshot.sort((a, b) => a.data["votes"] < b.data["votes"] ? 1 : 0);
    return ListView(
      padding: EdgeInsets.only(top: 20.0),
      children: snapshot.map((map) => _buildListItem(map)).toList(),
    );
  }

  Widget _buildListItem(DocumentSnapshot map) {
    final brand = Brand.fromSnapshot(map);
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      trailing: Text(brand.votes.toString()),
      title: Text(brand.name),
      onTap: () {
        brand.reference.updateData({
          "votes": brand.votes + 1,
        });
      },
    );
  }

  void showForm(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add brand name'),
            content: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'brand',
              ),
            ),
            actions: <Widget>[
              RaisedButton(
                child: Text(
                  'Confirm',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if (_controller.text != "") {
                    Firestore.instance.collection("brands").add({
                      "name": _controller.text,
                      "votes": 0,
                    });
                  }

                  _controller.clear();
                  Navigator.of(context).pop();
                },
              ),
              RaisedButton(
                color: Colors.red,
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
