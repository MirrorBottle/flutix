import 'package:flutter/material.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:flutix/globals.dart';
import 'package:nb_utils/nb_utils.dart';

class InTheaterCard extends StatelessWidget {
  final Map<String, String> data;
  const InTheaterCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Padding(
          padding: const EdgeInsets.only(right: 10, top: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Material(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              clipBehavior: Clip.antiAlias,
              color: constPrimaryColor,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(data["image"]!),
                      fit: BoxFit.cover,
                    ),
                  ),
                  width: 320,
                  height: 170,
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 320,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(data["title"]!,
                      style: constSecondaryTextStyle.copyWith(
                          color: Colors.white, fontSize: 20)),
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
  final Map<String, String> data;
  const ComingSoonCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Padding(
          padding: const EdgeInsets.only(right: 10, top: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Material(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              clipBehavior: Clip.antiAlias,
              color: constPrimaryColor,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(data["image"]!),
                      fit: BoxFit.cover,
                    ),
                  ),
                  width: 140,
                  height: 170,
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 140,
              child: Text(data["title"]!,
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

    const List<Map<String, String>> banners = [
      {
        "title": "Paper Towns",
        "image":
            "https://www.themoviedb.org/t/p/original/1AEeyAoy5gN6pDoZLxRupPlCQzt.jpg"
      },
      {
        "title": "Godzilla",
        "image":
            "https://www.themoviedb.org/t/p/original/6CLNOzMXO9bvapDD8gsdwkJU4wN.jpg"
      },
      {
        "title": "Weathering with You",
        "image":
            "https://www.themoviedb.org/t/p/original/wRDyTXw5j0RN9M03xZlHYkoNLCI.jpg"
      },
      {
        "title": "Black Adam",
        "image":
            "https://www.themoviedb.org/t/p/original/lu9zNcGQKTGiKbbHpAsqxwrGy4W.jpg"
      },
      {
        "title": "Barbie",
        "image":
            "https://www.themoviedb.org/t/p/original/ctMserH8g2SeOAnCw5gFjdQF8mo.jpg"
      },
    ];

    const List<Map<String, String>> _inTheaters = [
      {
        "title": "Parasite",
        "vote": "85%",
        "image":
            "https://www.themoviedb.org/t/p/original/hiKmpZMGZsrkA3cdce8a7Dpos1j.jpg"
      },
      {
        "title": "La La Land",
        "vote": "79%",
        "image":
            "https://www.themoviedb.org/t/p/original/meGzYSwHzBWNQk9lYVNxdUrFqiC.jpg"
      },
      {
        "title": "The Big Short",
        "vote": "73%",
        "image":
            "https://www.themoviedb.org/t/p/original/ksPCyJsU1qogGR2At9RjPoxXUVp.jpg"
      },
      {
        "title": "Eureka Seven: Hi Evo",
        "vote": "63%",
        "image":
            "https://www.themoviedb.org/t/p/original/aLLTfRD7EfbE9GVyosknReARNHI.jpg"
      },
      {
        "title": "The Godfather",
        "vote": "87%",
        "image":
            "https://www.themoviedb.org/t/p/original/rSPw7tgCH9c6NqICZef4kZjFOQ5.jpg"
      },
    ];

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
                          banners[index]["image"]!,
                          fit: BoxFit.cover,
                        );
                      },
                      autoplay: true,
                      itemCount: banners.length,
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
                                        Text(
                                          banners[config.activeIndex]["title"]!,
                                          style:
                                              constSecondaryTextStyle.copyWith(
                                                  fontSize: 20.0,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
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
                              Text("Fahmi Fitnanda",
                                  style: constTextStyle.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 20)),
                              Text("IDR 280,000",
                                  style: constNumberTextStyle.copyWith(
                                      color: Colors.white, fontSize: 23))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, right: 10, left: 5),
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
                                      Text("Top Up",
                                          style: constTextStyle.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16))
                                    ],
                                  ),
                                ),
                                onTap: () {},
                              ),
                              GestureDetector(
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
                                onTap: () {},
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
                            children: _inTheaters
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
