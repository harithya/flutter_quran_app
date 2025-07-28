import 'package:alquran/models/doa_model.dart';
import 'package:alquran/shared/api.dart';

class DoaService {
  static final DoaService _instance = DoaService._internal();
  factory DoaService() => _instance;
  DoaService._internal();

  final Api _api = Api();

  Future<List<DoaListModel>> getDoa() async {
    final response = await _api.get("/doa");
    return (response.data['data'] as List)
        .map((e) => DoaListModel.fromJson(e))
        .toList();
  }
}
