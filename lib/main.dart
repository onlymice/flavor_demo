import 'package:flavor_demo/utils.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final env = Environment();
  runApp(MyApp(env: env));
}

class MyApp extends StatelessWidget {
  final Environment env;

  const MyApp({super.key, required this.env});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: env.current,
        builder: (context, current, _) {
          return MaterialApp(
            title: '${current.name} Demo App',
            theme: ThemeData(
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              appBarTheme:
                  AppBarTheme.of(context).copyWith(color: current.color),
            ),
            home: MyHomePage(
              title: '${current.name} Demo Page',
              currentEnv: current,
            ),
          );
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.currentEnv});

  final String title;
  final EnvironmentType currentEnv;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: EnvironmentButtons(
        env: widget.currentEnv,
      )),
    );
  }
}

class EnvironmentButtons extends StatelessWidget {
  final EnvironmentType env;
  const EnvironmentButtons({super.key, required this.env});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center, children: widgetByEnv());
  }

  List<Widget> widgetByEnv() {
    switch (env) {
      case EnvironmentType.blue:
        return [
          button('Domestic transfer'),
          button('International transfer'),
          button('Bill payment')
        ];
      case EnvironmentType.green:
        return [
          button('Domestic transfer'),
          button('International transfer'),
        ];
      case EnvironmentType.red:
        return [button('International transfer')];
      default:
        return [Container()];
    }
  }

  Widget button(String text) => MaterialButton(
        color: env.color,
        textColor: Colors.white,
        onPressed: () {},
        child: Text(text),
      );
}
