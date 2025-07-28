import 'package:alquran/providers/doa_provider.dart';
import 'package:alquran/providers/surah_provider.dart';
import 'package:alquran/shared/theme.dart';
import 'package:alquran/ui/widgets/home_page/doa_tab.dart';
import 'package:alquran/ui/widgets/home_page/surah_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SurahProvider()),
        ChangeNotifierProvider(create: (context) => DoaProvider()),
      ],
      child: SurahBody(),
    );
  }
}

class SurahBody extends StatefulWidget {
  const SurahBody({super.key});

  @override
  State<SurahBody> createState() => _SurahBodyState();
}

class _SurahBodyState extends State<SurahBody> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SurahProvider>().getSurah();
      context.read<DoaProvider>().getDoa();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGreyColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text(
          "Al Quran",
          style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.bookmark_outline),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: false,
          indicatorSize: TabBarIndicatorSize.tab,
          labelStyle: blackTextStyle.copyWith(
            fontSize: 16,
            color: primaryColor,
            fontWeight: bold,
          ),
          unselectedLabelStyle: blackTextStyle.copyWith(
            fontSize: 16,
            color: greyColor,
            fontWeight: regular,
          ),
          dividerColor: Colors.transparent,
          tabs: <Widget>[
            Tab(text: "Surah"),
            Tab(text: "Doa Doa"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [SurahTab(), DoaTab()],
      ),
    );
  }
}
