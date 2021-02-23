import 'package:flutter/material.dart';
import 'package:myapp/screen/DistrictsScreen.dart';
import 'dart:io';

import 'package:firedart/firedart.dart';

const apiKey = 'AIzaSyB-vFYTNh4prsOvRgBM9FhBhdUd7kwhwQU';
const projectId = 'auth-login-578ee';
const email = 'test@test.com';
const password = 'test123';

void main() {
  FirebaseAuth.initialize(apiKey, VolatileStore());
  Firestore.initialize(projectId);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Desktop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Desktop'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Documents',
            ),
            StreamBuilder<List<Document>>(
              stream: Firestore.instance.collection('manual_user').stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Text(
                        '${snapshot.data.length}',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) =>
                            Center(child: Text(snapshot.data[index].map['name'])),
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              },
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  onPressed: () async {
                    if (!auth.isSignedIn) {
                      print(auth.isSignedIn);
                      await auth.signIn(email, password);
                    }
                    print(auth.userId);
                    setState(() {

                    });
                  },
                  child: Text("Login"),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DistrictScreen(),
              ));
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
