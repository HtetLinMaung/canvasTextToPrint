import 'package:canvasToImage/output_screen.dart';
import 'package:canvasToImage/store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InputText extends StatefulWidget {
  static const routeName = "InputText";

  @override
  _InputTextState createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  TextEditingController _controller = TextEditingController();

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
                onPressed: () {
                  context.read<AppProvider>().setInput(_controller.text);
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
