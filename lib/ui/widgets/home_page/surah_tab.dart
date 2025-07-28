import 'package:alquran/providers/surah_provider.dart';
import 'package:alquran/ui/widgets/alquran_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SurahTab extends StatelessWidget {
  const SurahTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SurahProvider>(
      builder: (_, value, __) {
        final surah = value.surah;
        if (value.isLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (value.errorMessage.isNotEmpty) {
          return Center(child: Text(value.errorMessage));
        }
        if (value.surah.isNotEmpty) {
          return ListView.builder(
            itemCount: value.surah.length,
            itemBuilder: (context, index) {
              return AlquranItem(
                surah: surah[index],
                color: index % 2 == 0 ? Colors.grey.shade100 : Colors.white,
              );
            },
          );
        }
        return Container();
      },
    );
  }
}
