import 'package:dio/dio.dart';
import 'package:flutter_request_bloc/services/base.dart';
import 'package:myanime/utils/url.dart';

class MangaService extends BaseService<Dio> {
  const MangaService(Dio client) : super(client);

  Future<Response> getManga(int page) async {
    print('Mnaga');
    return client.get(Url.mangaCategoryUrl(page: page));
  }
}
