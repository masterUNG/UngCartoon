import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ungcartoon/models/cartoon_model.dart';
import 'package:ungcartoon/utility/my_style.dart';
import 'package:ungcartoon/widget/show_pdf_view.dart';

class ShowCartoonList extends StatefulWidget {
  @override
  _ShowCartoonListState createState() => _ShowCartoonListState();
}

class _ShowCartoonListState extends State<ShowCartoonList> {
  List<Widget> widgets = [];
  List<CartoonModel> cartoonModels = [];

  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<Null> readData() async {
    await Firebase.initializeApp().then((value) async {
      print('initialize Success');
      await FirebaseFirestore.instance
          .collection('cartoon')
          .orderBy('name')
          .snapshots()
          .listen((event) {
        print('snapshot = ${event.docs}');
        int index = 0;
        for (var snapshots in event.docs) {
          Map<String, dynamic> map = snapshots.data();
          print('map = $map');
          CartoonModel model = CartoonModel.fromMap(map);
          cartoonModels.add(model);
          print('name = ${model.name}');
          setState(() {
            widgets.add(createWidget(model, index));
          });
          index++;
        }
      });
    });
  }

  Widget createWidget(CartoonModel model, int index) => GestureDetector(
        onTap: () {
          print('You Click from index = $index');
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShowPdfView(
                  cartoonModel: cartoonModels[index],
                ),
              ));
        },
        child: Card(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 120,
                  child: Image.network(model.cover),
                ),
                SizedBox(
                  height: 16,
                ),
                MyStyle().titleH2(model.name),
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgets.length == 0
          ? Center(child: CircularProgressIndicator())
          : GridView.extent(maxCrossAxisExtent: 220, children: widgets),
    );
  }
}
