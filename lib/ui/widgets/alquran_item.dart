import 'package:alquran/models/surah_detail_model.dart';
import 'package:alquran/models/surah_model.dart';
import 'package:alquran/shared/theme.dart';
import 'package:alquran/ui/pages/surah_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlquranItem extends StatelessWidget {
  final SurahListModel surah;
  final Color color;
  const AlquranItem({super.key, required this.surah, required this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                SurahDetailPage(nama: surah.namaLatin, nomor: surah.nomor),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(color: color),
        child: Row(
          children: [
            SizedBox(
              height: 45,
              width: 45,
              child: Stack(
                children: [
                  Image.asset("assets/bingkai.png"),
                  Center(
                    child: Text(
                      surah.nomor.toString(),
                      style: blackTextStyle.copyWith(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  surah.namaLatin,
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "${surah.tempatTurun}  | ${surah.jumlahAyat} Ayat",
                  style: blackTextStyle.copyWith(
                    fontSize: 14,
                    color: greyColor,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(surah.nama, style: blackTextStyle.copyWith(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class SurahDetailItem extends StatelessWidget {
  final Ayat ayat;
  final Color color;
  final void Function()? onTap;
  final void Function()? onPlay;
  final bool isPlay;

  const SurahDetailItem({
    super.key,
    required this.ayat,
    required this.color,
    this.onTap,
    this.onPlay,
    this.isPlay = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(color: color),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 45,
                  width: 45,
                  child: Stack(
                    children: [
                      Image.asset("assets/bingkai.png"),
                      Center(
                        child: Text(
                          ayat.nomorAyat.toString(),
                          style: blackTextStyle.copyWith(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    ayat.teksArab,
                    style: GoogleFonts.amiri(fontSize: 20, height: 3),
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    ayat.teksIndonesia,
                    style: blackTextStyle.copyWith(
                      fontSize: 14,
                      color: greyColor,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: CircleBorder(
                      side: BorderSide(
                        color: greyColor, // warna border
                        width: 1, // ketebalan border
                      ),
                    ),
                  ),
                  iconSize: 20,
                  onPressed: onPlay,
                  icon: Icon(
                    isPlay ? Icons.pause : Icons.play_arrow,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
