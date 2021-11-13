import 'package:flutter_request_bloc/repositories/base.dart';
import 'package:myanime/models/category.dart';
import 'package:myanime/services/top.dart';
import 'package:myanime/services/upcoming.dart';

/// Handles retrieve and transformation of [ComapnyInfo] from the API.
class UpcomingRepository
    extends BaseRepository<UpcomingService, CategoryModel> {
  const UpcomingRepository(UpcomingService service) : super(service);

  @override
  Future<CategoryModel> fetchData({int page}) async {
    final response = await service.getUpcoming(page);

    return CategoryModel.fromJson(response.data);
  }
}
