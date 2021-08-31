
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_weather_app/city_screen.dart';
import'constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart'as http;
import 'city_screen.dart';

import 'dart:convert';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  @override
  void initState() {
    updateUi(null);// TODO: implement initState
    super.initState();
  }

  void updateSmallUi(dynamic smallConvertedWeather)
  {
    setState(() {
      double temp=smallConvertedWeather['list'][10]['main']['temp'];
      temperature2=temp.toInt();
      smallWeatherIcon2(smallConvertedWeather['list'][10]['weather'][0]['id']);
      smallWeatherIcon3(smallConvertedWeather['list'][20]['weather'][0]['id']);

      double temp2=smallConvertedWeather['list'][20]['main']['temp'];
      temperature3=temp2.toInt();



    });
  }

  void updateUi(dynamic convertedWeather)
  {

    setState(() {
      if(convertedWeather==null)
        {
          temperature=0;
          weatherIcon0='N/A';
          cityName='N/A';
          weatherDescription='N/A';
          return;
        }


      double temp=convertedWeather['list'][1]['main']['temp'];

      temperature= temp.toInt();
      cityName=convertedWeather['city']['name'];
      updateSmallUi(convertedWeather);




    });


  }

  void smallWeatherIcon3(int condition)
  {

    if (condition < 300) {
      weatherIcon3= '🌩';

    } else if (condition < 400) {
      weatherIcon3= '🌧';
    } else if (condition < 600) {
      weatherIcon3= '☔️';
    } else if (condition < 700) {
      weatherIcon3= '☃️';
    } else if (condition < 800) {
      weatherIcon3= '🌫';
    } else if (condition == 800) {
      weatherIcon3= '☀️';
    } else if (condition <= 804) {
      weatherIcon3= '☁️';
    } else {
      weatherIcon3= '🤷‍';
    }

  }
  void smallWeatherIcon2(int condition)
  {

    if (condition < 300) {
      weatherIcon2= '🌩';

    } else if (condition < 400) {
      weatherIcon2= '🌧';
    } else if (condition < 600) {
      weatherIcon2= '☔️';
    } else if (condition < 700) {
      weatherIcon2= '☃️';
    } else if (condition < 800) {
      weatherIcon2= '🌫';
    } else if (condition == 800) {
      weatherIcon2= '☀️';
    } else if (condition <= 804) {
      weatherIcon2= '☁️';
    } else {
      weatherIcon2= '🤷‍';
    }

  }

  String cityName;
  String weatherDescription;
  int temperature;
  String weatherIcon0='a';
  int temperature2;
  String weatherIcon2='a';
  int temperature3;
  String weatherIcon3='a';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Mousam')),),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('images/ihfnlpbze7o01.jpg'),
          )
        ) ,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FlatButton(onPressed: ()async{


                  Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                  print(position.longitude);
                  http.Response response= await http.get('https://api.openweathermap.org/data/2.5/forecast?lat=${position.latitude}&lon=${position.longitude}&units=metric&appid=6cdf2bd75ba76614ca58ee13b6f1a246');
                  print(response.statusCode);

                  var convertedWeather= jsonDecode(response.body);
                  //var smallConvertedWeather=jsonDecode(response2.body);
                  updateUi(convertedWeather);


                  }, child:
                Icon(Icons.near_me_outlined,
                  size: kIconSize,
                  color: kIconColor,
                ),

                ),
                FlatButton(
                  onPressed: ()async{
                    cityName= await Navigator.push(context, MaterialPageRoute(builder: (context){
                      return CityScreen();
                    }));
                    http.Response response= await http.get('https://api.openweathermap.org/data/2.5/forecast?q=$cityName&units=metric&appid=6cdf2bd75ba76614ca58ee13b6f1a246');
                    var convertedWeather=jsonDecode(response.body);
                    updateUi(convertedWeather);
                  },
                  child: Icon(Icons.location_city,
                  size: kIconSize,
                    color: kIconColor,

                  ),
                  padding: EdgeInsets.all(15.0),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 50),
              child: Text('$cityName',
                style: kRecommendationTextStyle,
                textAlign: TextAlign.right,
              ),
            ),
            Text('$temperature°',
            style: kTempratureTextStyle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                smallWeather(2,weatherIcon2,temperature2),
                smallWeather(3,weatherIcon3,temperature3),


              ]
            ),


          ],
        ),
        ),



    );
  }
}

class smallWeather extends StatelessWidget {
  smallWeather(this.day, this.icon, this.degree);
  int day;
  String icon;
  int degree;


  @override
  Widget build(BuildContext context) {
    return Container(
      
      height: 150,
      width: 150.0,
      decoration: BoxDecoration(

        color: Colors.white.withOpacity(0.1),

        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: EdgeInsets.only(top: 20.0),
      child: Column(

        children: [


          Center(child: Text('Day$day',
          style: TextStyle(fontWeight: FontWeight.bold),
          ),),
          SizedBox(height: 30.0),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children:[
            Text('$degree',
            style: TextStyle(
              fontSize: 30.0

            ),
            ),
              Text('$icon',
                style: TextStyle(
                    fontSize: 30.0

                ),
              ),
              ]
            ),
        ],
      ),

    );
  }
}
