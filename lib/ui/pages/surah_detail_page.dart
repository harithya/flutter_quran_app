import 'package:alquran/providers/surah_provider.dart';
import 'package:alquran/shared/theme.dart';
import 'package:alquran/ui/widgets/alquran_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';

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
  late AudioPlayer player = AudioPlayer();
  int? ayatPlayAudio;
  bool isPlay = false;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    player.setReleaseMode(ReleaseMode.stop);
    player.onPlayerComplete.listen(_handleOnPlayerComplete);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SurahProvider>().getSurahDetail(widget.nomor);
      context.read<SurahProvider>().getTafsir(widget.nomor);
    });
  }

  void _handleOnPlayerComplete(event) {
    if (!mounted) return;
    final surahProvider = Provider.of<SurahProvider>(context, listen: false);
    final ayat = surahProvider.surahDetail?.ayat;

    try {
      final findNextAyat = ayat?.firstWhere(
        (element) => element.nomorAyat == (ayatPlayAudio ?? 1) + 1,
      );
      if (findNextAyat != null) {
        _playAudio(findNextAyat.audio['01']!, findNextAyat.nomorAyat);
      } else {
        setState(() {
          isPlay = false;
          ayatPlayAudio = null;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Tidak ada ayat selanjutnya")));
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  Future<void> _playAudio(String audio, int ayat) async {
    if (isPlay && ayat == ayatPlayAudio) {
      player.stop();
      setState(() {
        isPlay = false;
        ayatPlayAudio = null;
      });
    } else if (isPlay && ayatPlayAudio != ayat) {
      await player.stop();
      await player.play(UrlSource(audio));
      setState(() {
        isPlay = true;
        ayatPlayAudio = ayat;
      });
    } else {
      await player.play(UrlSource(audio));
      setState(() {
        isPlay = true;
        ayatPlayAudio = ayat;
      });
    }
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
                  isPlay:
                      isPlay &&
                      ayatPlayAudio == surahDetail.ayat[index].nomorAyat,
                  onPlay: () => _playAudio(
                    surahDetail.ayat[index].audio['01']!,
                    surahDetail.ayat[index].nomorAyat,
                  ),
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
