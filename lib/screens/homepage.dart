import 'package:covid_app/services/covid_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService service = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.lightBlueAccent, Colors.white],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              'ViroSafe - COVID-19 Tracker',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlueAccent, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 5,
                  child: FutureBuilder(
                    future: service.getCovidData(),
                    builder: (context, snapshot) {
                      Map<String, dynamic>? data = snapshot.data;

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasError) {
                        return const Text(
                          "Something went wrong...",
                          style: TextStyle(fontSize: 18, color: Colors.red),
                        );
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: const Icon(
                              FontAwesomeIcons.viruses,
                              size: 30,
                              color: Colors.orange,
                            ),
                            title: const Text(
                              "Local Total Cases",
                              style: TextStyle(fontSize: 20),
                            ),
                            subtitle: Text(
                              "${data!["local_total_cases"]}",
                              style: const TextStyle(fontSize: 25),
                            ),
                          ),
                          ListTile(
                            leading: const Icon(
                              FontAwesomeIcons.skullCrossbones,
                              size: 30,
                              color: Colors.red,
                            ),
                            title: const Text(
                              "Local Deaths",
                              style: TextStyle(fontSize: 20),
                            ),
                            subtitle: Text(
                              "${data["local_deaths"]}",
                              style: const TextStyle(fontSize: 25),
                            ),
                          ),
                          ListTile(
                            leading: const Icon(
                              FontAwesomeIcons.heartbeat,
                              size: 30,
                              color: Colors.green,
                            ),
                            title: const Text(
                              "Local Recovered",
                              style: TextStyle(fontSize: 20),
                            ),
                            subtitle: Text(
                              "${data["local_recovered"]}",
                              style: const TextStyle(fontSize: 25),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
