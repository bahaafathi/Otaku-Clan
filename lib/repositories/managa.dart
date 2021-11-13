import 'package:flutter_request_bloc/repositories/base.dart';
import 'package:myanime/models/category.dart';
import 'package:myanime/models/manga.dart';
import 'package:myanime/services/manga.dart';
import 'package:myanime/services/ova.dart';

class MangaRepository extends BaseRepository<MangaService, Manga> {
  const MangaRepository(MangaService service) : super(service);

  @override
  Future<Manga> fetchData({int page = 1}) async {
    final response = await service.getManga(page);

    return Manga.fromJson(response.data);
  }
}
