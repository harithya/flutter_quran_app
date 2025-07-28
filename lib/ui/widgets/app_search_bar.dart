import 'package:alquran/shared/theme.dart';
import 'package:flutter/material.dart';

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            style: blackTextStyle,
            decoration: InputDecoration(
              hintText: "Cari Surah ...",
              hintStyle: blackTextStyle.copyWith(fontSize: 16),
              filled: true,
              labelStyle: blackTextStyle.copyWith(fontSize: 16),
              fillColor: Color.fromARGB(206, 236, 236, 236),
              constraints: BoxConstraints(minHeight: 40, maxHeight: 40),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.transparent),
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
      ],
    );
  }
}
