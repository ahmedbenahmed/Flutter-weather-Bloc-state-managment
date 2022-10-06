import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_state.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherCubit extends Cubit<WeatherState> {
  String? cityName;

  WeatherCubit(WeatherState initialState) : super(initialState);
  WeatherModel? weatherData;
  getWeather(String name) async {
    cityName = name;
    emit(WeatherLoadingState());
    WeatherService service = WeatherService();
    try {
      weatherData = await service.getWeather(cityName: cityName!);
      emit(WeatherSuccessState());
    } catch (e) {
      emit(WeatherErrorState());
    }
  }
}
