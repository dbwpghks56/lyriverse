import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lyriverse/core/network/data_source/http_client.dart';
import 'package:lyriverse/core/network/models/http_response.dart';
import 'package:lyriverse/spotify_auth/data/data_source/spotify_auth_data_source.dart';
import 'package:lyriverse/spotify_auth/data/dto/spotify_token_dto.dart';

class SpotifyAuthDataSourceImpl implements SpotifyAuthDataSource {
  final HttpClient _httpClient;
  final String _remoteUrl;

  const SpotifyAuthDataSourceImpl({
    required HttpClient httpClient,
    required String remoteUrl,
  }) : _httpClient = httpClient,
       _remoteUrl = remoteUrl;

  @override
  Future<SpotifyTokenDto> getAccessToken() async {
    final String basicToken = 'Basic ${dotenv.env['SPOTIFY_BASIC_TOKEN']}';

    final HttpResponse response = await _httpClient.post(
      _remoteUrl,
      data: {
        'grant_type': 'client_credentials',
      },
      headers: {
        'Authorization': basicToken,
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );

    return SpotifyTokenDto.fromJson(response.data);
  }
}
