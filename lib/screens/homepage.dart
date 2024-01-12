import 'package:covid_app/services/covid_data.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService service = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('COVID-19 Tracker'),
      ),
      body: Center(
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
                      return const Text("Something went wrong...",
                          style: TextStyle(fontSize: 18, color: Colors.red));
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
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
    );
  }
}
