import 'package:magento_app/data/remote/weather_repository.dart';
import 'package:magento_app/domain/models/covid19_summary_response.dart';

class WeatherUseCase {
  final WeatherRepository weatherRepo;

  WeatherUseCase({required this.weatherRepo});
  
  Future<Covid19SummaryGlobalModel> getCovid19SummaryGlobal() async {

  }

}