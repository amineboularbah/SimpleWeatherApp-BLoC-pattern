import 'package:SimpleWeatherApp/WeatherModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherRepo{
  Future<WeatherModel> getWeather(String cityName) async{
    final result = await http.get('https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=f351a86a7a570edafd3f9f5d352e6daf');
    if(result.statusCode == 200){
      return parsedJson(result.body);
    }else{
      throw Exception();
    }
  }
  WeatherModel parsedJson(final response){
    final jsonDec = json.decode(response);
    final jsonWeather = jsonDec['main'];
    return WeatherModel.fromJson(jsonWeather);
  }
}