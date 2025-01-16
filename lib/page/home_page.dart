import 'package:flutter/material.dart';
import 'package:weather_app/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: blueGradientColors,
      )),
      child: Scaffold(
        backgroundColor: transparent,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60), child: appBarWidget()),
        drawer: drawerDesign(),
        body: bodyWidget(),
      ),
    );
  }
}

/*
All 
Widgets 
are 
present 
here
 */

// AppBar Widget
Widget appBarWidget() {
  return AppBar(
    iconTheme: IconThemeData(color: white),
    backgroundColor: transparent,
    centerTitle: true,
    title: Text(
      cityName,
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
          child: Text(
            "15 January 2025",
            style: TextStyle(
              color: white,
              fontSize: 16,
              fontFamily: "Omsk",
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Center(
          child: Image.asset(imagePath),
        ),

        Padding(
          padding: const EdgeInsets.only(
            left: 40,
          ),
          child: Row(
            children: [
              Text(
                "25°C",
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
                      "28 °C",
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
        ),
        SizedBox(height: 30),

        //weather details.....

        weatherDetails("Humidity", "23%"),
        weatherDetails("Pressure", "1014 mb"),
        weatherDetails("Rain", "45%"),
        weatherDetails("Wind", "32 km/hr"),
      ],
    ),
  );
}

// Weather Details Wiget
Widget weatherDetails(String label, String value) {
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

// Drawer Widget
Widget drawerDesign() {
  return Drawer(
    child: ListView(
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: bgColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Weather App',
                style: TextStyle(
                  color: white,
                  fontSize: 24,
                  fontFamily: "Omsk",
                ),
              ),
              SizedBox(height: 20),
              TextField(
                style: TextStyle(color: white),
                decoration: InputDecoration(
                  hintText: "Search City",
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
                    borderSide:
                        BorderSide(color: white, style: BorderStyle.none),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 30),
        ListTile(
          title: Row(
            children: [
              Icon(
                Icons.info,
                color: const Color.fromARGB(255, 75, 75, 75),
              ),
              SizedBox(width: 15),
              Text("About"),
            ],
          ),
          onTap: () {},
        ),
        ListTile(
          title: Row(
            children: [
              Icon(
                Icons.code,
                color: const Color.fromARGB(255, 75, 75, 75),
              ),
              SizedBox(width: 15),
              Text("Code"),
            ],
          ),
          onTap: () {},
        ),
        ListTile(
          title: Row(
            children: [
              Icon(
                Icons.mail,
                color: const Color.fromARGB(255, 75, 75, 75),
              ),
              SizedBox(width: 15),
              Text("Mail Me"),
            ],
          ),
          onTap: () {},
        ),
      ],
    ),
  );
}
