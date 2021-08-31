import 'package:flutter/material.dart';

class CityScreen extends StatelessWidget {
  String city;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(

          image: DecorationImage(
            fit: BoxFit.cover,
              image: AssetImage(
                  'images/images.jpg'
              ),

          ),
        ),
        constraints: BoxConstraints.expand(),
        child: Column(

          children: [

            SafeArea(

              child: Align(
                alignment: Alignment.topLeft,
                child: FlatButton(

                child: Icon(Icons.arrow_back,
                size: 50.0,
                ),
                  onPressed: (){
                  Navigator.pop(context);
                  },

            ),
              ),),

            TextField(

              onChanged: (val){
                city=val;
              },

              style: TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                hintText: 'Enter city name',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            ButtonTheme(
              minWidth: 100.0,
             // height: 50.0,
              child: RaisedButton(


                onPressed: (){
                  Navigator.pop(context,city);
                },

                child: Text('Get Weather',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                ),
                color: Colors.blue[200],


              ),
            )
          ],

        ),

      ),
    );
  }
}
