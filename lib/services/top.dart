import 'package:dio/dio.dart';
import 'package:flutter_request_bloc/services/base.dart';
import 'package:myanime/utils/url.dart';

class TopService extends BaseService<Dio> {
  const TopService(
    Dio client,
  ) : super(client);

  Future<Response> getTop(int page) async {
    print('Top');
    return client
        .get(Url.animeCategoryUrl(category: Category.airing, page: page));
  }
}
