import 'package:dio/dio.dart';
import 'package:flutter_request_bloc/services/base.dart';
import 'package:myanime/utils/url.dart';

class UpcomingService extends BaseService<Dio> {
  const UpcomingService(Dio client) : super(client);

  Future<Response> getUpcoming(int page) async {
    await Future.delayed(const Duration(seconds: 1));
    print('Upcoming');
    return client.get(Url.animeCategoryUrl(category: Category.upcoming,page:page ));
  }
}
