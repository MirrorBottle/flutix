import 'dart:convert';

import 'package:flutix/components/image_component.dart';
import 'package:flutix/models/movie.dart';
import 'package:flutix/models/user.dart';
import 'package:flutix/pages/wallet/wallet_screen.dart';
import 'package:flutix/pages/wallet/wallet_topup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:flutix/globals.dart';
import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:dio/dio.dart';

class InTheaterCard extends StatelessWidget {
  final MovieList data;
  const InTheaterCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Navigator.pushNamed(
            context,
            'movie-detail',
            arguments: {"id": data.id},
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 10, top: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ImageComponent(url: data.backdropPath, height: 170, width: 320),
            const SizedBox(height: 10),
            SizedBox(
              width: 320,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 180,
                    child: Text(data.title,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                        style: constSecondaryTextStyle.copyWith(
                            color: Colors.white, fontSize: 20)),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: constTernaryColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 4, bottom: 4),
                      child: Text("Buy Ticket",
                          style: constTextStyle.copyWith(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            )
          ]),
        ));
  }
}

class ComingSoonCard extends StatelessWidget {
  final MovieList data;
  const ComingSoonCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Navigator.pushNamed(
            context,
            'movie-detail',
            arguments: {"id": data.id},
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 10, top: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ImageComponent(url: data.posterPath, height: 170, width: 140),
            const SizedBox(height: 10),
            SizedBox(
              width: 140,
              child: Text(data.title,
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
                  style: constSecondaryTextStyle.copyWith(
                      color: Colors.white, fontSize: 20)),
            )
          ]),
        ));
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final dio = Dio();
  UserModel? _auth;

  late AnimationController _ColorAnimationController;
  late AnimationController _TextAnimationController;
  late Animation _colorTween, _iconColorTween;
  late Animation<Offset> _transTween;

  List<MovieList> _upcomings = [];
  List<MovieList> _populars = [];
  List<MovieList> _inTheaters = [];

  @override
  void initState() {
    _ColorAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));
    _colorTween = ColorTween(begin: Colors.transparent, end: Color(0xFFee4c4f))
        .animate(_ColorAnimationController);
    _iconColorTween = ColorTween(begin: Colors.grey, end: Colors.white)
        .animate(_ColorAnimationController);

    _TextAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));

    _transTween = Tween(begin: Offset(-10, 40), end: Offset(-10, 0))
        .animate(_TextAnimationController);
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add a custom header to the request
          options.headers['Authorization'] =
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0ODk2NzZmMGY5ODdhY2IxNTk5YTE4ZDQwMDgzYzI0MiIsInN1YiI6IjY0ZTE3ZGEzZTE5ZGU5MDEwMGU5MTkwZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.0WBoauQ1IOL14fRlRv8z9W9GrPLG2_lv0-Mst0dnh0g';
          return handler.next(options);
        },
      ),
    );

    _init();
    super.initState();
  }

  bool _scrollListener(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.axis == Axis.vertical) {
      _ColorAnimationController.animateTo(scrollInfo.metrics.pixels / 350);

      _TextAnimationController.animateTo(
          (scrollInfo.metrics.pixels - 350) / 50);
      return true;
    }
    return false;
  }

  void _init() async {
    EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.ring;
    EasyLoading.show(status: 'Loading..', maskType: EasyLoadingMaskType.black);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedAuth = prefs.getString('auth') ?? "{}";
    setState(() {
      _auth = UserModel.fromJson(json.decode(encodedAuth));
    });
    List<MovieList> _upcomingsData = await getUpcomingMovies();
    List<MovieList> _popularsData = await getPopularMovies();
    List<MovieList> _inTheatersData = await getInTheaterMovies();

    setState(() {
      _upcomings = _upcomingsData;
      _populars = _popularsData;
      _inTheaters = _inTheatersData;
    });
    EasyLoading.dismiss();
  }

  Future<List<MovieList>> getUpcomingMovies() async {
    final response = await dio.get(
        'https://api.themoviedb.org/3/movie/upcoming?language=en-US&page=1');
    List<MovieList> _items = response.data['results'].map<MovieList>((_item) {
      return MovieList.fromJson(_item);
    }).toList();
    return _items.take(6).toList();
  }

  Future<List<MovieList>> getPopularMovies() async {
    final response = await dio.get(
        'https://api.themoviedb.org/3/movie/popular?language=en-US&page=1');
    List<MovieList> _items = response.data['results'].map<MovieList>((_item) {
      return MovieList.fromJson(_item);
    }).toList();
    return _items.take(8).toList();
  }

  Future<List<MovieList>> getInTheaterMovies() async {
    final response = await dio.get(
        'https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=1');
    List<MovieList> _items = response.data['results'].map<MovieList>((_item) {
      return MovieList.fromJson(_item);
    }).toList();
    return _items.take(8).toList();
  }

  @override
  Widget build(BuildContext context) {
    const categories = [
      "Horror",
      "Action",
      "Drama",
      "Romance",
      "Musical",
      "Thriller",
      "Mystery",
      "Crime"
    ];
    final TabController _tabController =
        TabController(length: categories.length, vsync: this);

    final List<Tab> tabs =
        categories.map<Tab>((category) => Tab(child: Text(category))).toList();

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: constPrimaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        titleSpacing: 5,
        title: const Image(
          image: AssetImage('assets/images/logo_full_trans.png'),
          height: 45,
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Colors.black, Colors.transparent]),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: TabBar(
                    isScrollable: true,
                    labelStyle: constSecondaryTextStyle.copyWith(
                        fontWeight: FontWeight.w900),
                    unselectedLabelColor: Colors.white,
                    tabs: tabs,
                    controller: _tabController,
                    indicator: const BoxDecoration()),
              ),
              IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                padding: const EdgeInsets.only(left: 10, right: 20),
                tooltip: "Pencarian",
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 230),
          width: MediaQuery.of(context).size.width,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // * BANNER
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 370,
                  child: Expanded(
                    child: Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return Image.network(
                          _populars[index].posterPath,
                          fit: BoxFit.cover,
                        );
                      },
                      autoplay: true,
                      itemCount: _populars.length,
                      pagination: SwiperPagination(
                          margin: const EdgeInsets.all(0.0),
                          builder: SwiperCustomPagination(builder:
                              (BuildContext context,
                                  SwiperPluginConfig config) {
                            return ConstrainedBox(
                              child: Container(
                                decoration: const BoxDecoration(
                                    //渐变 从下至上颜色渐变（封面下播放、点赞、时长那栏文字）
                                    gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [
                                      Colors.black54,
                                      Colors.transparent
                                    ]) // 从下面是黑到上面透明
                                    ),
                                // color: Colors.white,
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 240,
                                          child: Text(
                                              _populars.isNotEmpty
                                                  ? _populars[
                                                          config.activeIndex]
                                                      .title
                                                  : '-',
                                              overflow: TextOverflow.fade,
                                              maxLines: 1,
                                              softWrap: false,
                                              style: constSecondaryTextStyle
                                                  .copyWith(
                                                      fontSize: 20.0,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child:
                                                const DotSwiperPaginationBuilder(
                                                        color: Colors.black26,
                                                        activeColor:
                                                            Colors.white,
                                                        size: 5.0,
                                                        activeSize: 5.0)
                                                    .build(context, config),
                                          ),
                                        )
                                      ],
                                    )),
                              ),
                              constraints:
                                  const BoxConstraints.expand(height: 50.0),
                            );
                          })),
                    ),
                  ),
                ),

                // * CARD AND ACCOUNT
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(20.0),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: constSecondaryColor,
                          gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: <Color>[
                                constPrimaryColor,
                                constSecondaryColor
                              ])),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(_auth != null ? _auth!.name : '-',
                                  style: constTextStyle.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 20)),
                              Text(_auth != null ? _auth!.balanceFormat! : '-',
                                  style: constNumberTextStyle.copyWith(
                                      color: Colors.white, fontSize: 23))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const WalletTopup()),
                                          );
                                        },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8, right: 10, left: 5),
                                  child: Column(
                                    children: [
                                      Container(
                                          width: 25,
                                          height: 25,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color: Colors.white,
                                          ),
                                          child: const Icon(
                                            Icons.arrow_upward,
                                            size: 18,
                                          )),
                                      const SizedBox(height: 10),
                                      Text(
                                        "Top Up",
                                        style: constTextStyle.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                        
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const WalletScreen()),
                                          );
                                        },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, left: 10),
                                  child: Column(
                                    children: [
                                      Container(
                                          width: 25,
                                          height: 25,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color: Colors.white,
                                          ),
                                          child: const Icon(
                                            Icons.history,
                                            size: 18,
                                          )),
                                      const SizedBox(height: 10),
                                      Text("History",
                                          style: constTextStyle.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      )),
                ),
                // * NOW PLAYING
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("In Theaters",
                            style: constHeadingStyle.copyWith(
                                color: Colors.white)),
                        SizedBox(
                          height: 220,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: _inTheaters
                                .map((data) => InTheaterCard(data: data))
                                .toList(),
                          ),
                        ),
                      ]),
                ),
                // * COMING SOON
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Coming Soon",
                            style: constHeadingStyle.copyWith(
                                color: Colors.white)),
                        SizedBox(
                          height: 220,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: _upcomings
                                .map((data) => ComingSoonCard(data: data))
                                .toList(),
                          ),
                        ),
                      ]),
                ),
                const SizedBox(height: 40),
                // * PROMO
              ]),
        ),
      ),
    );
  }
}
