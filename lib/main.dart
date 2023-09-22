import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:house_of_reels/api/hor_api.dart';
import 'package:house_of_reels/api/models/event.dart';
import 'package:house_of_reels/firebase_options.dart';

void main() {
  runApp(const MyApp());
}

Future<void> initializeApp() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        useMaterial3: true,
      ),
      home: FutureBuilder<dynamic>(
          future: initializeApp(),
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? CircularProgressIndicator.adaptive()
                : const MyHomePage(title: 'House of Reels');
          }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String data = "Nothing yet";
  void _incrementCounter() async {
    final events = await HorApi().getEvents();
    setState(() {
      data = events.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            StreamBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
                stream:
                    FirebaseFirestore.instance.collection("events").snapshots().map((event) => event.docs),
                builder: (context, snapshot) {
                  return Text(
                    "${snapshot.data?.map((e) => Event.fromMap(e.data())).toList()}",
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
