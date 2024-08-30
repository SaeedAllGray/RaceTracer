import 'package:racetracer/src/domain/entries/oauth/oauth_attributes.dart';
import 'package:racetracer/src/infrastructure/datasources/remote/config_data_source.dart';

class ConfigRepository {
  final ConfigDataSource configDataSource = ConfigDataSource();

  Future<OauthAtrributes> setupConfigurations(String hostIP) async {
    Map<String, dynamic> response =
        await configDataSource.getConfigurations(hostIP);
    final OauthAtrributes oauthAtrributes = OauthAtrributes.fromJson(response);
    return oauthAtrributes;
  }
}
