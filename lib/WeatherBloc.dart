import 'package:SimpleWeatherApp/WeatherModel.dart';
import 'package:SimpleWeatherApp/WeatherRepo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherEevent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];

}

class FetchWeather extends WeatherEevent{
  final city;

  FetchWeather(this.city);
   @override
  // TODO: implement props
  List<Object> get props => [city];
}

class ResetWeather extends WeatherEevent{

}

class WeatherState extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];

}

class WeatherIsNotSearched extends WeatherState{

}
class WeatherIsLoading extends WeatherState{
  
}
class WeatherIsLoaded extends WeatherState{
  final weather;

  WeatherIsLoaded(this.weather);
  WeatherModel get getWeather => weather;
  @override
  // TODO: implement props
  List<Object> get props => [weather];
  
}
class WeatherIsNotLoaded extends WeatherState{
  
}

class WeatherBloc extends Bloc<WeatherEevent, WeatherState>{
  WeatherRepo weatherRepo;
  WeatherBloc(this.weatherRepo);
  @override
  //implement initialState
  WeatherState get initialState => WeatherIsNotSearched();

  @override
  Stream<WeatherState> mapEventToState(WeatherEevent event) async*{
    //implement mapEventToState
    if(event is FetchWeather){
      yield WeatherIsLoading();
      try{
        WeatherModel weatherModel = await weatherRepo.getWeather(event.city);
        yield WeatherIsLoaded(weatherModel);
      }catch(_){
          yield WeatherIsNotLoaded();
      }
    }else if(event is ResetWeather){
      yield WeatherIsNotSearched();
    }
  }

}