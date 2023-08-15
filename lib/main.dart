import 'package:flutter/material.dart';
import 'package:inherited_widget_tut_1/form_page.dart';
import 'package:inherited_widget_tut_1/state_container.dart';

void main() {
  runApp(
    const StateContainer(
      child: UserApp(),
    ),
  );
}

class UserApp extends StatelessWidget {
  const UserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      // home: HomeScreen(),
      routes: <String, WidgetBuilder>{
        HomeScreen.route: (context) => const HomeScreen(),
        UpdateUserScreen.route: (context) => UpdateUserScreen()
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  static const route = "/";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late User? user;

  @override
  Widget build(BuildContext context) {
    final stateContainer = StateContainer.of(context);
    user = stateContainer.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inherited Widget'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // ignore: unnecessary_null_comparison
            user == null
                ? const Text(
                    'Please add user information',
                    style: TextStyle(fontSize: 18.0),
                  )
                : Text(
                    ' firstname: ${user!.firstName} \n lastname: ${user!.lastName} \n email: ${user!.email}',
                    style: const TextStyle(fontSize: 28.0),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, UpdateUserScreen.route),
        child: const Icon(Icons.edit),
      ),
    );
  }
}
