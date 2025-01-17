import 'package:flutter/material.dart';
import 'package:weather_app/constants.dart';
import 'package:weather/weather.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class CitySearchDelegate extends SearchDelegate {
  final Function(String) fetchWeather;

  CitySearchDelegate({required this.fetchWeather});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    fetchWeather(query);
    close(context, null);
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text('New York'),
          onTap: () {
            query = 'New York';
            fetchWeather(query);
            close(context, null);
          },
        ),
        ListTile(
          title: Text('London'),
          onTap: () {
            query = 'London';
            fetchWeather(query);
            close(context, null);
          },
        ),
        ListTile(
          title: Text('Ranchi'),
          onTap: () {
            query = 'Ranchi';
            fetchWeather(query);
            close(context, null);
          },
        ),
        ListTile(
          title: Text('New Delhi'),
          onTap: () {
            query = 'New Delhi';
            fetchWeather(query);
            close(context, null);
          },
        ),
        ListTile(
          title: Text('Mumbai'),
          onTap: () {
            query = 'Mumbai';
            fetchWeather(query);
            close(context, null);
          },
        ),
        ListTile(
          title: Text('Banglore'),
          onTap: () {
            query = 'Banglore';
            fetchWeather(query);
            close(context, null);
          },
        ),
        ListTile(
          title: Text('Singapore'),
          onTap: () {
            query = 'Singapore';
            fetchWeather(query);
            close(context, null);
          },
        ),
        ListTile(
          title: Text('Los Angeles'),
          onTap: () {
            query = 'Los Angeles';
            fetchWeather(query);
            close(context, null);
          },
        ),
      ],
    );
  }
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

  void _fetchWeather(String place) {
    _wF.currentWeatherByCityName(place).then((x) {
      if (mounted) {
        setState(() {
          _weather = x;
          imagePath =
              getImagePathForWeatherDescription(_weather?.weatherDescription);
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
      }
    });
  }

  String getImagePathForWeatherDescription(String? description) {
    switch (description?.toLowerCase()) {
      case "clear sky":
        return "assets/images/sunny_day.png";
      case "few clouds":
      case "scattered clouds":
      case "broken clouds":
      case "overcast clouds":
        return "assets/images/clouds.png";
      case "haze":
        return "assets/images/haze.png";
      case "shower rain":
      case "rain":
        return "assets/images/cloud_with_rain.png";
      case "thunderstorm":
        return "assets/images/dark_cloud_with_thunder.png";
      case "snow":
        return "assets/images/snow.png";
      case "mist":
        return "assets/images/mist.png";
      default:
        return "assets/images/sunny_day.png";
    }
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
      ),
    );
  }

// AppBar Widget
  Widget appBarWidget() {
    return AppBar(
      iconTheme: IconThemeData(color: white),
      backgroundColor: transparent,
      centerTitle: true,
      elevation: 0,
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
      actions: [
        IconButton(
          icon: Icon(
            Icons.search,
            color: white,
            size: 25,
          ),
          onPressed: () {
            showSearch(
              context: context,
              delegate: CitySearchDelegate(fetchWeather: _fetchWeather),
            );
          },
        ),
      ],
    );
  }

// Body Widget
  Widget bodyWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 60,
                right: 60,
              ),
              child: Image.asset(
                imagePath,
                alignment: Alignment.center,
                fit: BoxFit.contain,
              ),
            ),
          ),

          temperatureWidget(),

          SizedBox(height: 30),

          //weather details.....
          weatherDetails("Place", _weather?.areaName ?? 'Unknown'),
          weatherDetails("Humidity", "${_weather?.humidity ?? 'N/A'}%"),
          weatherDetails("Condition", _weather?.weatherMain ?? 'N/A'),
          weatherDetails("Wind Speed",
              "${_weather?.windSpeed != null ? (_weather!.windSpeed! * 3.6).toStringAsFixed(2) : 'N/A'} km/h"),
          weatherDetails("Wind Degree", "${_weather?.windDegree ?? ""}°"),
        ],
      ),
    );
  }

// Weather Details Wiget
  Widget weatherDetails(String label, String value) {
    if (_weather == null) {
      label = "---";
      value = "---";
      return const Text("");
    } else {
      return Padding(
        padding: const EdgeInsets.only(
          right: 30,
          left: 30,
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
}
