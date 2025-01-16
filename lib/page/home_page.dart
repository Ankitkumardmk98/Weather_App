import 'package:flutter/material.dart';
import 'package:weather_app/constants.dart';
import 'package:weather/weather.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Variables
  final WeatherFactory _wF = WeatherFactory(weatherAppAPIKey);
  Weather? _weather;

  TextEditingController userInput = TextEditingController();

  @override
  void dispose() {
    userInput.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather(cityName);
  }

  // Fetch weather data for a specific city.
  void _fetchWeather(String place) {
    _wF.currentWeatherByCityName(place).then((x) {
      if (mounted) {
        setState(() {
          _weather = x;
          if (_weather?.weatherDescription?.toLowerCase() == "clear sky") {
            imagePath = "assets/images/sunny_day.png";
          } else if (_weather?.weatherDescription?.toLowerCase() ==
              "few clouds") {
            imagePath = "assets/images/clouds.png";
          } else if (_weather?.weatherDescription?.toLowerCase() ==
              "scattered clouds") {
            imagePath = "assets/images/clouds.png";
          } else if (_weather?.weatherDescription?.toLowerCase() ==
              "broken clouds") {
            imagePath = "assets/images/clouds.png";
          } else if (_weather?.weatherDescription?.toLowerCase() ==
              "shower rain") {
            imagePath = "assets/images/cloud_with_rain.jpg";
          } else if (_weather?.weatherDescription?.toLowerCase() == "rain") {
            imagePath = "assets/images/cloud_with_rain.jpg";
          } else if (_weather?.weatherDescription?.toLowerCase() ==
              "thunderstorm") {
            imagePath = "assets/images/dark_cloud_with_thunder.png";
          } else if (_weather?.weatherDescription?.toLowerCase() == "snow") {
            imagePath = "assets/images/clouds.png";
          } else if (_weather?.weatherDescription?.toLowerCase() == "mist") {
            imagePath = "assets/images/clouds.png";
          } else {
            imagePath = "assets/images/clouds.png";
          }
        });
      }
    }).catchError((error) {
      if (mounted) {
        setState(() {
          userInput.clear();
          weatherDetails("---", "---");
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: bgColor,
            showCloseIcon: true,
            closeIconColor: white,
            content: Text("Error: No city name found, check your spelling"),
            duration: const Duration(seconds: 3),
          ),
        );
      } else {
        setState(() {
          userInput.clear();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: blueGradientColors,
        ),
      ),
      child: Scaffold(
        backgroundColor: transparent,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: appBarWidget(),
        ),
        body: bodyWidget(),
        bottomNavigationBar: navBar(),
      ),
    );
  }

// AppBar Widget
  Widget appBarWidget() {
    return AppBar(
      iconTheme: IconThemeData(color: white),
      backgroundColor: transparent,
      centerTitle: true,
      title: Text(
        _weather?.areaName ?? 'Unknown',
        style: TextStyle(
          color: white,
          fontSize: 24,
          fontFamily: "Omsk",
          fontWeight: FontWeight.w600,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

// Body Widget
  Widget bodyWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Image.asset(imagePath),
          ),

          temperatureWidget(),

          SizedBox(height: 30),

          //weather details.....
          weatherDetails("Place", _weather?.areaName ?? 'Unknown'),
          weatherDetails("Humidity", "${_weather?.humidity ?? 'N/A'}%"),
          weatherDetails("Condition", _weather?.weatherDescription ?? 'N/A'),
          weatherDetails("Wind",
              "${_weather?.windSpeed != null ? (_weather!.windSpeed! * 3.6).toStringAsFixed(2) : 'N/A'} km/h"),
        ],
      ),
    );
  }

// Weather Details Wiget
  Widget weatherDetails(String label, String value) {
    if (_weather == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Padding(
        padding: const EdgeInsets.only(
          right: 50,
          left: 50,
          top: 8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                color: greyTransparent,
                fontFamily: "Omsk",
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                color: greyTransparent,
                fontFamily: "Omsk",
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }
  }

//Temperature Wiget
  Widget temperatureWidget() {
    if (_weather == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      dynamic feelsLikeTemp =
          "${_weather?.tempFeelsLike?.celsius?.toStringAsFixed(0) ?? 'N/A'}°C";
      dynamic temp =
          "${_weather?.temperature?.celsius?.toStringAsFixed(0) ?? 'N/A'}°C";
      return Padding(
        padding: const EdgeInsets.only(
          left: 40,
        ),
        child: Row(
          children: [
            Text(
              temp,
              style: TextStyle(
                color: greyTransparent,
                fontSize: 55,
                fontFamily: "Omsk",
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "feels like",
                    style: TextStyle(
                      color: greyTransparent,
                      fontSize: 16,
                      fontFamily: "Omsk",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    feelsLikeTemp,
                    style: TextStyle(
                      color: greyTransparent,
                      fontSize: 16,
                      fontFamily: "Omsk",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }
  }

  //Nav Bar
  Widget navBar() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextField(
              controller: userInput,
              style: TextStyle(color: white),
              decoration: InputDecoration(
                hintText: "Search Place Name",
                hintStyle: TextStyle(
                  color: white,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10),
                  child: Icon(
                    Icons.search,
                    color: white,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: white, style: BorderStyle.none),
                ),
              ),
              onSubmitted: (newCity) {
                setState(() {
                  _fetchWeather(newCity);
                  // cityName = _weather?.areaName ?? 'Unknown';
                  cityName = newCity;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
