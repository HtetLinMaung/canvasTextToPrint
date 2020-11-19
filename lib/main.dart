import 'package:canvasToImage/input_text.dart';
import 'package:canvasToImage/output_screen.dart';
import 'package:canvasToImage/print_screen.dart';
import 'package:canvasToImage/store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
      ],
      child: CanvasToImage(),
    ));

class CanvasToImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: InputText.routeName,
      routes: {
        InputText.routeName: (context) => InputText(),
        OutputScreen.routeName: (context) => OutputScreen(),
        PrintScreen.routeName: (context) => PrintScreen(),
      },
    );
  }
}
