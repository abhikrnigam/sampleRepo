import 'mainscreen.dart';
import 'conditions.dart';
import 'package:flutter/material.dart';
import 'networkingscreen.dart';
import 'package:weather_app/Location.dart';

class WelcomeScreen extends StatefulWidget {

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {


  dynamic response;
  dynamic responseuv;
  dynamic position;
  double latitude;
  double longitude;

  void getWeatherData() async{
    Location location=new Location();
    Networking networking=new Networking();
    position=await location.getLocation();
    latitude=position.latitude;
    longitude=position.longitude;
    response=await networking.getResponse(latitude, longitude);
    responseuv=await networking.getUVIndex(latitude, longitude);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreen(response: response,responseuv: responseuv,)));
  }

  @override
  Widget build(BuildContext context) {
    String image;
    DateTime a=DateTime.now();
    Conditions cond=new Conditions();
    image=cond.checkDayTime(a);
    return
       Container(
          decoration: BoxDecoration(
          image: DecorationImage(
          image: AssetImage('images/$image'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
          Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
          ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Spacer(flex: 4,),
            Material(
              type: MaterialType.transparency,
              child: Text(
                  'WeaThR Application',
                style: TextStyle(
                  fontSize: 50.0,
                  color: Colors.white,
                  fontFamily: 'Pacifico',
                ),
              ),
            ),
          Spacer(flex: 1,),
          RawMaterialButton(
            elevation: 6.0,
            fillColor: Colors.grey[900],
            constraints: BoxConstraints(
              minWidth: 200.0,
              minHeight: 60.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
                'Get Weather',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,

              ),
            ),

            onPressed: (){
              getWeatherData();
            },
          ),
          SizedBox(
            height: 20.0,
          ),
          RawMaterialButton(
            elevation: 10.0,
            padding: EdgeInsets.all(10.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            fillColor: Colors.grey[900],
            constraints: BoxConstraints(
              minWidth: 180.0,
              minHeight: 60.0,
            ),
            child: Text(
              'Search',
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,

              ),
            ),
            onPressed: (){
              Navigator.pushNamed(context, 'cityscreen');
            },
          ),
            Spacer(flex: 3,)
          ],
        ),
    );
  }
}


