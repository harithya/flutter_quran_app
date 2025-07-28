import 'package:alquran/models/surah_detail_model.dart';
import 'package:alquran/models/surah_model.dart';
import 'package:alquran/models/tafsir_model.dart';
import 'package:alquran/shared/api.dart';

class QuranService {
  static final QuranService _instance = QuranService._internal();
  factory QuranService() => _instance;
  QuranService._internal();

  final Api _api = Api();

  Future<List<SurahListModel>> getSurah() async {
    final response = await _api.get("/v2/surat");
    return (response.data['data'] as List)
        .map((e) => SurahListModel.fromJson(e))
        .toList();
  }

  Future<SurahDetailModel> getSurahDetail(int nomor) async {
    final response = await _api.get("/v2/surat/$nomor");
    return SurahDetailModel.fromJson(response.data['data']);
  }

  Future<TafsirModel> getTafsir(int nomor) async {
    final response = await _api.get("/v2/tafsir/$nomor");
    return TafsirModel.fromJson(response.data['data']);
  }
}
