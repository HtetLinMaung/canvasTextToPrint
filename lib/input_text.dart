import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:canvasToImage/output_screen.dart';
import 'package:canvasToImage/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class InputText extends StatefulWidget {
  static const routeName = "InputText";

  @override
  _InputTextState createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  TextEditingController _controller = TextEditingController();
  GlobalKey _globalKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RepaintBoundary(
                key: _globalKey,
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(right: 65),
                  child: Text(
                    _controller.text,
                    style: TextStyle(
                      backgroundColor: Colors.white,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.clip,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Input here',
                  ),
                ),
              ),
              RaisedButton(
                child: Text('Convert'),
                onPressed: () async {
                  RenderRepaintBoundary boundary =
                      _globalKey.currentContext.findRenderObject();
                  ui.Image image = await boundary.toImage(pixelRatio: 2);
                  ByteData byteData =
                      await image.toByteData(format: ui.ImageByteFormat.png);
                  var pngBytes = byteData.buffer.asUint8List();
                  var bs64 = base64Encode(pngBytes);
                  context.read<AppProvider>().setInput(_controller.text);
                  context.read<AppProvider>().setImgBytes2(pngBytes);
                  Navigator.pushNamed(context, OutputScreen.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
