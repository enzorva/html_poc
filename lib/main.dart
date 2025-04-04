import 'package:flutter/material.dart';

import 'second_page.dart'; // Import the new page

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  // Add controllers for new input fields
  final TextEditingController _name1Controller = TextEditingController();
  final TextEditingController _name2Controller = TextEditingController();
  final TextEditingController _name3Controller = TextEditingController();
  final TextEditingController _name4Controller = TextEditingController();
  final TextEditingController _checkInController = TextEditingController();
  final TextEditingController _checkOutController = TextEditingController();
  final TextEditingController _carModelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: Text(widget.title)),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(controller: _name1Controller, decoration: const InputDecoration(labelText: 'Name 1', border: OutlineInputBorder())),
              const SizedBox(height: 16),
              TextField(controller: _name2Controller, decoration: const InputDecoration(labelText: 'Name 2', border: OutlineInputBorder())),
              const SizedBox(height: 16),
              TextField(controller: _name3Controller, decoration: const InputDecoration(labelText: 'Name 3', border: OutlineInputBorder())),
              const SizedBox(height: 16),
              TextField(controller: _name4Controller, decoration: const InputDecoration(labelText: 'Name 4', border: OutlineInputBorder())),
              const SizedBox(height: 16),
              TextField(controller: _checkInController, decoration: const InputDecoration(labelText: 'Check-in Date', border: OutlineInputBorder())),
              const SizedBox(height: 16),
              TextField(
                controller: _checkOutController,
                decoration: const InputDecoration(labelText: 'Check-out Date', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 16),
              TextField(controller: _carModelController, decoration: const InputDecoration(labelText: 'Car Model', border: OutlineInputBorder())),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => SecondPage(
                            name1: _name1Controller.text,
                            name2: _name2Controller.text,
                            name3: _name3Controller.text,
                            name4: _name4Controller.text,
                            checkIn: _checkInController.text,
                            checkOut: _checkOutController.text,
                            carModel: _carModelController.text,
                          ),
                    ),
                  );
                },
                child: const Text('Go to Second Page'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose controllers to free resources
    _name1Controller.dispose();
    _name2Controller.dispose();
    _name3Controller.dispose();
    _name4Controller.dispose();
    _checkInController.dispose();
    _checkOutController.dispose();
    _carModelController.dispose();
    super.dispose();
  }
}
