import 'package:flutter/material.dart';
import 'package:fpjs_pro_plugin/fpjs_pro_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _initFingerprint();
  }

  void _initFingerprint() async {
    await FpjsProPlugin.initFpjs(
        'X876qE3W4DAYxlqO7sE4',
        // endpoint: "https://metrics.melissamoyerp.com",
        // Only necessary for the web platform
        scriptUrlPattern: "https://metrics.melissamoyerp.com/web/v<version>/<apiKey>/loader_v<loaderVersion>.js"
    );
  }

  // void identify() async {
  //   try {
  //     var visitorId = await FpjsProPlugin.getVisitorId();
  //     var deviceData = await FpjsProPlugin.getVisitorData();
  //     print('Visitor ID: ${visitorId}');
  //     print('Device data: ${deviceData}');
  //   } catch (e) {
  //     print('Error initializing FingerprintJS: $e');
  //     // process the error
  //   }
  // }
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
        useMaterial3: true,
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
  String _visitorId = "Fetching...";

  Future<void> _getVisitorId() async {
    try {
      var visitorId = await FpjsProPlugin.getVisitorId();
      var deviceData = await FpjsProPlugin.getVisitorData();
      setState(() {
        _visitorId = visitorId!;
      });
      print('Visitor ID: $visitorId');
      print('Device data: $deviceData');
    } catch (e) {
      print('Error initializing FingerprintJS: $e');
      setState(() {
        _visitorId = "Error fetching Visitor ID";
      });
    }
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
            Text(
              'Visitor ID:',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              _visitorId,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getVisitorId,
              child: const Text('Fetch Visitor ID'),
            ),
          ],
        ),
      ),
    );
  }
}
