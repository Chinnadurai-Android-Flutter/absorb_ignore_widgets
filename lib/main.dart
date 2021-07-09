import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Absorb & Ignore'),
    );;
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool buttonClick = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
      buttonClick = true;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Absorb & Ignore Enabled, You can\'t click next 5 seconds'),
        ),
      );
    });
    Future.delayed(const Duration(milliseconds: 5000), () {
      setState(() {
        buttonClick = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Absorb & Ignore Disabled, You can click now'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: buttonClick,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
        floatingActionButton: IgnorePointer(
          ignoring: buttonClick,
          child: FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
