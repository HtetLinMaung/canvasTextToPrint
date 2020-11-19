import 'package:canvasToImage/store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';

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
    generateImagefromText(
      text: context.read<AppProvider>().input,
      textColor: Colors.black,
      width: 200,
      height: 200,
      style: TextStyle(
        color: Colors.black,
        fontSize: 12,
      ),
    );
  }

  Future<Uint8List> _generatePdf(
      PdfPageFormat format, ByteData imgBytes) async {
    final pdf = pw.Document();
    final imageProvider = MemoryImage(Uint8List.view(imgBytes.buffer));
    final PdfImage image = await pdfImageFromImageProvider(
        pdf: pdf.document, image: imageProvider);
    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Center(
            child: pw.Image(image),
          );
        },
      ),
    );

    return pdf.save();
  }

  Future<ByteData> generateImagefromText({
    String text,
    Color textColor,
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
      // body: Center(
      //   child: imgBytes != null
      //       ? Center(
      //           child: Image.memory(
      //           Uint8List.view(imgBytes.buffer),
      //           width: kCanvasSize,
      //           height: kCanvasSize,
      //         ))
      //       : Container(),
      body: imgBytes != null
          ? PdfPreview(
              build: (format) => _generatePdf(format, imgBytes),
            )
          : Container(),
    );
  }
}
