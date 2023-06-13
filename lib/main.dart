

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
   Stream<int> a=Stream.fromIterable([1]);
  Stream<int> b= Stream.fromIterable([2, 3]);
  Stream<int> c=Stream.fromIterable([4, 5, 6]);
  @override
  Widget build(BuildContext context) {

    combineLatestStream(a, b, c).listen((event) {
      print(event);
    });

    concatStream(a, b, c).listen((event) {
      print(event);
    });

    forkJoinStream(a, b, c).listen((event) {
      print(event);
    });

    mergeStream(a, b, c).listen((event) {
      print(event);
    });



    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          ],
        ),
      ),

    );
  }
  Stream<List<int>> combineLatestStream(Stream<int> a,Stream<int> b,Stream<int> c){
    return
    CombineLatestStream.list<int>([
      a,b,c
    ]);
  }
  Stream<int> concatStream(Stream<int> a,Stream<int> b,Stream<int> c){
    return
  ConcatStream([
    a,b,c
  ]);
}
 Stream<List<int>> forkJoinStream(Stream<int> a,Stream<int> b,Stream<int> c){
    return
  ForkJoinStream.list<int>([
    a,b,c
  ]);
}
Stream<int> mergeStream(Stream<int> a,Stream<int> b,Stream<int> c){
    return
  MergeStream([
    a,b,c
  ]);
}



}
