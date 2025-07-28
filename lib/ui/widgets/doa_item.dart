import 'package:alquran/models/doa_model.dart';
import 'package:alquran/shared/theme.dart';
import 'package:flutter/material.dart';

class DoaItem extends StatelessWidget {
  final DoaListModel doa;
  final Color color;
  const DoaItem({super.key, required this.doa, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    doa.id.toString(),
                    style: blackTextStyle.copyWith(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doa.nama,
                  style: blackTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  doa.grup,
                  style: blackTextStyle.copyWith(
                    fontSize: 12,
                    color: greyColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
