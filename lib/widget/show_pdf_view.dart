import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
// import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:ungcartoon/models/cartoon_model.dart';
import 'package:ungcartoon/utility/my_style.dart';

class ShowPdfView extends StatefulWidget {
  final CartoonModel cartoonModel;
  ShowPdfView({Key key, this.cartoonModel}) : super(key: key);
  @override
  _ShowPdfViewState createState() => _ShowPdfViewState();
}

class _ShowPdfViewState extends State<ShowPdfView> {
  CartoonModel model;
  PDFDocument pdfDocument;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model = widget.cartoonModel;
    createPDFDocument();
  }

  Future<Null> createPDFDocument() async {
    try {
      var result = await PDFDocument.fromURL(model.pdf);
      setState(() {
        pdfDocument = result;
      });
    } catch (e) {
      print('e ==> ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().primaryColor,
        title: Text(model.name == null ? 'Read Cartoon' : model.name),
      ),
      body: pdfDocument == null
          ? Center(child: CircularProgressIndicator())
          : PDFViewer(document: pdfDocument),
    );
  }
}
