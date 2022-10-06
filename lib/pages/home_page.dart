import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/search_page.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/bloc/weather_cubit.dart';
import 'package:weather_app/bloc/weather_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void updateUi() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SearchPage(
                  updateUi: updateUi,
                );
              }));
            },
            icon: Icon(Icons.search),
          ),
        ],
        title: Text('Weather App'),
      ),
      body: BlocBuilder<WeatherCubit, WeatherState>(builder: (context, state) {
        if (state is WeatherInitialState) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'there is no weather 😔 start',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                Text(
                  'searching now 🔍',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                )
              ],
            ),
          );
        } else if (state is WeatherSuccessState) {
          return Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                BlocProvider.of<WeatherCubit>(context)
                    .weatherData!
                    .getThemeColor(),
                BlocProvider.of<WeatherCubit>(context)
                    .weatherData!
                    .getThemeColor()[300]!,
                BlocProvider.of<WeatherCubit>(context)
                    .weatherData!
                    .getThemeColor()[100]!,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(
                  flex: 3,
                ),
                Text(
                  BlocProvider.of<WeatherCubit>(context).cityName!,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'updated at : ${BlocProvider.of<WeatherCubit>(context).weatherData!.date.hour.toString()}:${BlocProvider.of<WeatherCubit>(context).weatherData!.date.minute.toString()}',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(BlocProvider.of<WeatherCubit>(context)
                        .weatherData!
                        .getImage()),
                    Text(
                      BlocProvider.of<WeatherCubit>(context)
                          .weatherData!
                          .temp
                          .toInt()
                          .toString(),
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                            'maxTemp :${BlocProvider.of<WeatherCubit>(context).weatherData!.maxTemp.toInt()}'),
                        Text(
                            'minTemp : ${BlocProvider.of<WeatherCubit>(context).weatherData!.minTemp.toInt()}'),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                Text(
                  BlocProvider.of<WeatherCubit>(context)
                      .weatherData!
                      .weatherStateName,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(
                  flex: 5,
                ),
              ],
            ),
          );
        } else if (state is WeatherLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Center(
            child: Text('No state'),
          );
        }
      }),
    );
  }
}
