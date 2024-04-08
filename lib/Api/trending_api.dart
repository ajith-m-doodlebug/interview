import 'package:dio/dio.dart';
import 'package:interview_app/Classes/gifs_response_class.dart';

Future<GifsResponseClass> trendingAPI({
  required int offset,
}) async {
  try {
    Dio dio = Dio();

    Response response = await dio.get(
        "https://api.giphy.com/v1/gifs/trending?api_key=T2rpoPgZGG1i3CZ0KhpVEAUnz7zV7rJ5&limit=10&offset=$offset&rating=g&bundle=messaging_non_clips");

    GifsResponseClass gifsResponseClass =
        GifsResponseClass.fromJson(response.data);

    return gifsResponseClass;
  } catch (e) {
    rethrow;
  }
}
