import 'package:SimpleWeatherApp/WeatherBloc.dart';
import 'package:SimpleWeatherApp/WeatherRepo.dart';
import 'package:SimpleWeatherApp/showPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

TextEditingController searchController = new TextEditingController();
WeatherBloc weatherBloc;
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => WeatherBloc(WeatherRepo()),
        child: SearchPage(),
      ),
    );
  }
}


class SearchPage extends StatelessWidget {

  
  performSearch(String city) {
    weatherBloc.add(FetchWeather(city));
  }
  @override
  Widget build(BuildContext context) {
    weatherBloc = BlocProvider.of<WeatherBloc>(context);
    return Center(
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 32.0, right: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Search weather',
                    style: TextStyle(fontSize: 40.0, color: Colors.cyan)),
                BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    if (state is WeatherIsNotSearched) {
                      return Container(
                        child: Column(
                          children: [
                            TextField(
                              onSubmitted: (String value) => performSearch(value),
                              controller: searchController,
                              decoration: InputDecoration(
                                hintText: 'City name',
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 1.2,
                              height: 45.0,
                              child: RaisedButton(
                                color: Colors.cyan,
                                onPressed: () => performSearch(searchController.text),
                                child: Text(
                                  'Search',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 30.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }else if(state is WeatherIsLoading){
                      return CircularProgressIndicator();
                    }else if (state is WeatherIsLoaded){
                      return ShowPage(weather: state.getWeather, city: searchController.text);
                    }
                    return Text('Error');
                  },
                )
              ],
            ),
          ),
        );
  }
}

