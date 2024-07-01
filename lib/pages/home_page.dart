import 'package:flutter/material.dart';
import 'package:motix_app/data/auth/Auth.dart';
import 'package:motix_app/pages/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<void> signout()async{
    await Auth().signOut();
    Navigator.push(context, MaterialPageRoute(builder:(context) {return const LoginPage();}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text('Home Page'),
            ElevatedButton(
                onPressed: signout,
                child: Text("Çıkış yap")
            )
          ],
        ),

      ),
    );
  }
}