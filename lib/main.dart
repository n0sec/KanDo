import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/login_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'widgets/to_do_list_item.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const KanDo());
}

class KanDo extends StatelessWidget {
  const KanDo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: FirebaseAuth.instance.currentUser == null ? 'login' : '/',
      routes: {
        '/': (ctx) => const MyHomePage(title: 'KanDo'),
        'login': (context) => const LoginScreen(title: 'Log in')
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Drawer Header',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.red,
              ),
            ),
            const ListTile(
              leading: Icon(Icons.inbox),
              title: Text('Inbox'),
            ),
            const ListTile(
              leading: Icon(Icons.calendar_today_outlined),
              title: Text('Today'),
            ),
            const ListTile(
              leading: FaIcon(FontAwesomeIcons.calendarAlt),
              title: Text('Upcoming'),
            ),
            const ListTile(
              leading: Icon(Icons.filter_alt_outlined),
              title: Text('Filters'),
            ),
            ListTile(
              title: TextButton(
                child: const Text("Signout"),
                onPressed: () {
                  signOut(context);
                },
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          ToDoListItem(),
          ToDoListItem(),
        ],
      ),
    );
  }

  Future signOut(context) async {
    await GoogleSignIn().disconnect();
    await FirebaseAuth.instance.signOut().then((_) {
      Navigator.pushReplacementNamed(context, 'login');

      return const LoginScreen(title: 'Login');
    });
  }
}
