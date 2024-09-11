import 'package:racetracer/src/domain/entries/oauth/oauth_attributes.dart';
import 'package:racetracer/src/infrastructure/datasources/remote/config_data_source.dart';
import 'package:racetracer/src/presentation/constants/api_constant.dart';

class ConfigRepository {
  final ConfigDataSource configDataSource = ConfigDataSource();

  Future<OauthAtrributes> setupOauthConfig(String hostIP) async {
    Map<String, dynamic> response =
        await configDataSource.getConfigurations(hostIP);
    final OauthAtrributes oauthAtrributes =
        OauthAtrributes.fromJson(response['oauth']);
    return oauthAtrributes;
  }

  /// sets gitlab project id
  Future<void> setupGitlabConfig(String hostIP) async {
    Map<String, dynamic> response =
        await configDataSource.getConfigurations(hostIP);

    ApiConstants.setProjectId(response['gitlab']['project_id']);
    ApiConstants.setGitlabUrl(response['gitlab']['url']);
  }
}
