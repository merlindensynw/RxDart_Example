import 'dart:collection';

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
  @override
  Widget build(BuildContext context) {
    BehaviorSubject<int> behaviorSubject = BehaviorSubject<int>.seeded(1);
    BehaviorSubject<int> behaviorSubject1 = BehaviorSubject<int>();

    behaviorSubject1.stream.listen((data) {
      print("listener - 1 : $data");
    });

    behaviorSubject1.add(1);
    behaviorSubject1.add(2);

    behaviorSubject1.stream.listen((data) {
      print("listener - 2 : $data");
    });

    behaviorSubject1.add(3);

    behaviorSubject1.stream.listen((data) {
      print("listener - 3 : $data");
    });

    CombineLatestStream.list<int>([
      Stream.fromIterable([1]),
      Stream.fromIterable([2, 3]),
      Stream.fromIterable([4, 5, 6]),
    ]).listen(print);

    ConcatStream([
      Stream.fromIterable([1]),
      Stream.fromIterable([2, 3]),
      Stream.fromIterable([4, 5, 6]),
    ]).listen(print);

    ForkJoinStream.list<int>([
      Stream.fromIterable([1, 2, 3]),
      Stream.fromIterable([4, 5]),
      Stream.fromIterable([6]),
    ]).listen(print);

    FromCallableStream(() async {
      await Future<void>.delayed(const Duration(seconds: 3));
      return 'Value';
    }).listen(print);

    MergeStream([
      Stream.fromIterable([1, 2, 3]),
      Stream.fromIterable([4, 5]),
      Stream.fromIterable([6]),
    ]).listen(print);

    RaceStream([
      TimerStream([1, 2, 3], Duration(seconds: 15)),
      TimerStream([4, 5], Duration(seconds: 10)),
      TimerStream([6, 7, 8, 9, 10], Duration(seconds: 5)),
    ]).listen(print);

    DeferStream(() => Stream.value([1, 2, 3])).listen(print);
    RangeStream(1, 5).listen((i) => print(i));

    var isError = false;
    RetryWhenStream<String>(
          () => Stream.periodic(const Duration(seconds: 1), (i) => i).map((i) {
        return (i == 4)
            ? throw 'Stop'
            : (i == 3 && !isError)
            ? throw 'restart'
            : isError ? 'restart: $i': '$i';
      }),
          (e, s) {
        isError = true;
        if (e == 'restart') {
          return Stream.value('restarting!!!');
        } else {
          return Stream.error(e, s);
        }
      },
    ).listen(print, onError: print);

    SwitchLatestStream<String>(
      Stream.fromIterable(<Stream<String>>[
        Rx.timer('1', Duration(seconds: 2)),
        Rx.timer('2', Duration(seconds: 3)),
        Stream.value('3'),
      ]),
    ).listen(print);

    SequenceEqualStream(
      Stream.fromIterable([1, 2, 3, 4, 5]),
      Stream.fromIterable([1, 2, 3, 4, 5]),
    ).listen(print);

    SwitchLatestStream<String>(
      Stream.fromIterable(<Stream<String>>[
        Rx.timer('1', Duration(seconds: 2)),
        Rx.timer('2', Duration(seconds: 3)),
        Stream.value('3'),
      ]),
    ).listen(print);

    TimerStream(1, Duration(seconds: 5)).listen((i) => print(i));

    UsingStream<int, Queue<int>>(
          () => Queue.of([1, 2, 3, 4, 5]),
          (r) => Stream.fromIterable(r),
          (r) => r.clear(),
    ).listen(print);

    ZipStream(
      [
        Stream.fromIterable([1, 2]),
        Stream.fromIterable([3, 4]),
        Stream.fromIterable([5, 6, 7]),
      ],
          (values) => values.join(),
    ).listen(print);



    behaviorSubject1.close();

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
}
