import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen(this.weatherdata);
  final  weatherdata;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  double lon;
  var weather;
  String weatherMsg ;
  var Temp ;
  var ctiy;
  String weatherIcon;

  WeatherModel weatherModel = WeatherModel();
  @override
  void initState() {
    // TODO: implement initState
    updateUI(widget.weatherdata);
    super.initState();


  }
  void updateUI(weatherData){
    if(weatherData==null){
      Temp=0;
      ctiy ='Error in finding city';
      weatherMsg = 'no msg';
      weatherIcon = '';
      return;
    }
     lon = weatherData['coord']['lon'];
     weather = weatherData['weather'][0]['description'];
     var Tempe = weatherData['main']['temp'];
     Temp = Tempe.toInt();
     ctiy = weatherData['name'];
     var condition = weatherData['weather'][0]['id'];
      weatherIcon = weatherModel.getWeatherIcon(condition);
      weatherMsg = weatherModel.getMessage(Temp);


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black54,
        ),


        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await weatherModel.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 40.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                     var typedInput = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)
                        {
                          return CityScreen();
                        }
                        ),
                      );
                     if(typedInput != null) {
                       var weatherData = await weatherModel.getCityWeather(typedInput);

                       setState(() {
                         updateUI(weatherData);
                       });

                     }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 40.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0,right: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$Temp°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherIcon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMsg in $ctiy!",
                  textAlign: TextAlign.center,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
