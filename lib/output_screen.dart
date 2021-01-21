import 'package:canvasToImage/print_screen.dart';
import 'package:canvasToImage/print_screen2.dart';
import 'package:canvasToImage/print_screen3.dart';
import 'package:canvasToImage/store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';
// import 'package:pdf/pdf.dart';
// import 'dart:io';
// import 'package:image/image.dart';

const kCanvasSize = 200.0;

class OutputScreen extends StatefulWidget {
  static const routeName = "OutputScreen";

  @override
  _OutputScreenState createState() => _OutputScreenState();
}

class _OutputScreenState extends State<OutputScreen> {
  ByteData imgBytes;

  @override
  void initState() {
    super.initState();
    final store = context.read<AppProvider>();
    generateImagefromText(
      text: store.input,
      width: 100,
      height: 100,
      style: TextStyle(
        color: Colors.black,
        fontSize: 16,
        backgroundColor: Colors.white,
      ),
    ).then((imgBytes) {
      store.setImgBytes(imgBytes);
    });
  }

  // Future<Uint8List> _generatePdf(
  //     PdfPageFormat format, ByteData imgBytes) async {
  //   final pdf = pw.Document();
  //   final imageProvider = MemoryImage(Uint8List.view(imgBytes.buffer));
  //   final PdfImage image = await pdfImageFromImageProvider(
  //       pdf: pdf.document, image: imageProvider);
  //   pdf.addPage(
  //     pw.Page(
  //       pageFormat: format,
  //       build: (context) {
  //         return pw.Center(
  //           child: pw.Image(image),
  //         );
  //       },
  //     ),
  //   );

  //   return pdf.save();
  // }

  Future<ByteData> generateImagefromText({
    String text,
    int width,
    int height,
    TextStyle style,
  }) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder,
        Rect.fromPoints(Offset(0.0, 0.0), Offset(kCanvasSize, kCanvasSize)));
    TextSpan span = new TextSpan(style: style, text: text);
    TextPainter tp = new TextPainter(
      text: span,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, new Offset(5.0, 5.0));
    final picture = recorder.endRecording();
    final img = await picture.toImage(width, height);
    final pngBytes = await img.toByteData(format: ImageByteFormat.png);
    setState(() {
      imgBytes = pngBytes;
    });
    print(imgBytes);
    return imgBytes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: Text(
                'Preview Image',
                style: TextStyle(
                  fontSize: 32,
                ),
              ),
            ),
            imgBytes != null
                ? Image.memory(
                    Uint8List.view(imgBytes.buffer),
                    width: kCanvasSize,
                    height: kCanvasSize,
                  )
                : Container(),
            Text(
              'Please enable bluetooth, before printing',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, BluePrint.routeName);
              },
              child: Text('print'),
            ),
          ],
        ),
      ),
    );
  }
}
