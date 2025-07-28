import 'package:alquran/models/surah_detail_model.dart';
import 'package:alquran/models/surah_model.dart';
import 'package:alquran/models/tafsir_model.dart';
import 'package:alquran/services/quran_service.dart';
import 'package:flutter/material.dart';

class SurahProvider extends ChangeNotifier {
  List<SurahListModel> _surah = [];
  List<SurahListModel> get surah => _surah;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  SurahDetailModel? _surahDetail;
  SurahDetailModel? get surahDetail => _surahDetail;

  TafsirModel? _tafsir;
  TafsirModel? get tafsir => _tafsir;

  Future<void> getSurah() async {
    _isLoading = true;
    notifyListeners();
    try {
      _surah = await QuranService().getSurah();
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getSurahDetail(int nomor) async {
    _isLoading = true;
    notifyListeners();
    try {
      _surahDetail = await QuranService().getSurahDetail(nomor);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getTafsir(int nomor) async {
    _isLoading = true;
    notifyListeners();
    try {
      _tafsir = await QuranService().getTafsir(nomor);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
