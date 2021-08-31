import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'home_page.dart';
class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState(){
    // TODO: implement initState
     goToHomePage();


    super.initState();
  }

  void goToHomePage() async
  {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return  HomePage();
    }));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SpinKitChasingDots(
          color: Colors.green,
          size: 50.0,
        ),
      ),
    );
  }
}
