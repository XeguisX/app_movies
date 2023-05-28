import 'package:http/http.dart' as http;

const String _apiKey = '8399d594c0aba6f33d31a04d6c74cc63';
const String _baseUrl = 'api.themoviedb.org';
const String _languaje = 'es-ES';

Future<String> httpGet(String endpoint, [int page = 1]) async {
  try {
    final url = Uri.https(_baseUrl, endpoint, {
      'api_key': _apiKey,
      'language': _languaje,
      'page': '$page',
    });

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Error al obtener datos: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Ocurrió un error al obtener datos: $e');
  }
}
