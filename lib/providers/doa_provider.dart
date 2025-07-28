import 'package:alquran/models/doa_model.dart';
import 'package:alquran/services/doa_service.dart';
import 'package:flutter/material.dart';

class DoaProvider extends ChangeNotifier {
  List<DoaListModel> _doa = [];
  List<DoaListModel> get doa => _doa;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<void> getDoa() async {
    _isLoading = true;
    notifyListeners();
    try {
      _doa = await DoaService().getDoa();
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
