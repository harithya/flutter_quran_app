import 'package:alquran/providers/surah_provider.dart';
import 'package:alquran/shared/theme.dart';
import 'package:alquran/ui/widgets/alquran_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SurahDetailPage extends StatelessWidget {
  final String nama;
  final int nomor;
  const SurahDetailPage({super.key, required this.nama, required this.nomor});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SurahProvider(),
      child: SurahDetailBody(nama: nama, nomor: nomor),
    );
  }
}

class SurahDetailBody extends StatefulWidget {
  final String nama;
  final int nomor;
  const SurahDetailBody({super.key, required this.nama, required this.nomor});

  @override
  State<SurahDetailBody> createState() => _SurahDetailBodyState();
}

class _SurahDetailBodyState extends State<SurahDetailBody> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SurahProvider>().getSurahDetail(widget.nomor);
      context.read<SurahProvider>().getTafsir(widget.nomor);
    });
  }

  void _showTafsir(int ayat) {
    final tafsirSurah = context.read<SurahProvider>().tafsir;
    if (tafsirSurah?.tafsir != null) {
      final tafsirAyat = tafsirSurah!.tafsir.where(
        (element) => element.ayat == ayat,
      );
      showModalBottomSheet(
        context: context,
        showDragHandle: true,
        backgroundColor: Colors.white,
        constraints: BoxConstraints(minHeight: 200),
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                tafsirAyat.first.teks,
                style: blackTextStyle.copyWith(fontSize: 14, color: greyColor),
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        centerTitle: true,

        title: Text(
          widget.nama,
          style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),
        ),
      ),
      body: Consumer<SurahProvider>(
        builder: (_, value, __) {
          // final surahDetail = value.surahDetail;
          if (value.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (value.errorMessage.isNotEmpty) {
            return Center(child: Text(value.errorMessage));
          }

          if (!value.isLoading && value.surahDetail?.nama.isNotEmpty == true) {
            final surahDetail = value.surahDetail!;
            return ListView.builder(
              itemCount: surahDetail.ayat.length,
              itemBuilder: (context, index) {
                return SurahDetailItem(
                  ayat: surahDetail.ayat[index],
                  color: index % 2 == 0 ? Colors.grey.shade100 : Colors.white,
                  onTap: () => _showTafsir(surahDetail.ayat[index].nomorAyat),
                );
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}
