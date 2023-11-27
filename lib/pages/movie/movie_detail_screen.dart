import 'package:dio/dio.dart';
import 'package:flutix/components/button_component.dart';
import 'package:flutix/models/movie.dart';
import 'package:flutix/pages/auth/sign_up_screen.dart';
import 'package:flutix/pages/home/home_screen.dart';
import 'package:flutix/pages/home/main_screen.dart';
import 'package:flutix/pages/order/order_date.dart';
import 'package:flutix/providers/ticket_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutix/globals.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class CastCard extends StatelessWidget {
  final MovieDetailCast data;
  const CastCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Padding(
          padding: const EdgeInsets.only(right: 15, top: 10),
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
                      image: NetworkImage(data.profilePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                  width: 100,
                  height: 130,
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 100,
              child: Text(data.name,
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
                  style: constSecondaryTextStyle.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              width: 100,
              child: Text(data.character,
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
                  style: constSecondaryTextStyle.copyWith(
                      color: Colors.white, fontSize: 14)),
            )
          ]),
        ));
  }
}

List<Widget> buildStarRating(double rating) {
  // Ensure the rating is within the valid range (0 to 5)
  rating = rating / 2;

  // Determine the number of full stars, half stars, and gray stars
  int fullStars = rating.floor();
  int halfStars = ((rating - fullStars)).round();
  int grayStars = 5 - fullStars - halfStars;

  // Create a list of star icons
  List<Widget> starIcons = [];

  // Add full stars
  starIcons.addAll(List.generate(
      fullStars, (index) => const Icon(Icons.star, color: constTernaryColor)));

  // Add half star if needed
  starIcons.addAll(List.generate(
      halfStars, (index) => const Icon(Icons.star_half, color: constTernaryColor)));

  // Add gray stars only if there are positive grayStars
  starIcons.addAll(List.generate(grayStars > 0 ? grayStars : 0,
      (index) => const Icon(Icons.star, color: Colors.grey)));

  // Return a row of star icons
  return starIcons;
}

class MovieDetailScreen extends StatefulWidget {
  final Map<String, dynamic>? args;
  const MovieDetailScreen({this.args, Key? key}) : super(key: key);

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  final dio = Dio();
  MovieDetail? _movie;
  List<MovieDetailCast> _casts = [];
  @override
  void initState() {
    super.initState();
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
  }

  void _init() async {
    EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.ring;
    EasyLoading.show(status: 'Loading..', maskType: EasyLoadingMaskType.black);
    final movieResponse = await dio.get(
        "https://api.themoviedb.org/3/movie/${widget.args!['id']}?language=en-US");
    final castResponse = await dio.get(
        "https://api.themoviedb.org/3/movie/${widget.args!['id']}/credits?language=en-US");
    MovieDetail movieData = MovieDetail.fromJson(movieResponse.data);
    List<MovieDetailCast> castData =
        castResponse.data['cast'].map<MovieDetailCast>((_item) {
      return MovieDetailCast.fromJson(_item);
    }).toList();
    setState(() {
      _movie = movieData;
      _casts = castData.take(6).toList();
    });
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: constPrimaryColor,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        automaticallyImplyLeading: false,
        leading: const Padding(
          padding: EdgeInsets.only(top: 18.0, bottom: 18),
          child: BackButton(),
        ),
      ),
      body: _movie != null
          ? Stack(
              clipBehavior: Clip.none,
              children: [
                // * BACKDROP
                Positioned(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(_movie!.backdropPath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    top: 0),

                // * BACKDROP OVERLAY

                Positioned(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: <Color>[
                              constPrimaryColor,
                              Colors.transparent
                            ]),
                      ),
                    ),
                    top: 0),
                // * POSTER
                Positioned(
                    top: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Material(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            clipBehavior: Clip.antiAlias,
                            color: constPrimaryColor,
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(_movie!.posterPath),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              width: 130,
                              height: 195,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: Text(_movie!.title,
                                      style: constHeadingStyle.copyWith(
                                          color: Colors.white, fontSize: 28)),
                                ),
                                const SizedBox(height: 10),
                                Text(_movie!.language,
                                    style: constSecondaryTextStyle.copyWith(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 5),
                                Text(
                                    "${_movie!.releaseDate} • ${_movie!.runtime ~/ 60}h ${_movie!.runtime % 60}m",
                                    style: constSecondaryTextStyle.copyWith(
                                        color: Colors.white, fontSize: 15)),
                                const SizedBox(height: 15),
                                Row(
                                  children: [
                                    Text(_movie!.voteAverage.toString(),
                                        style: constNumberTextStyle.copyWith(
                                            color: constTernaryColor,
                                            fontSize: 20)),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    ...buildStarRating(_movie!.voteAverage),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )),

                // * MAIN CONTENT
                Positioned(
                    top: 320,
                    bottom: 60,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(20.0),
                      height: 1000,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0)),
                        color: constPrimaryColor,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Overview",
                                style: constHeadingStyle.copyWith(
                                    color: Colors.white, fontSize: 22)),
                            const SizedBox(height: 15),
                            Text(_movie!.overview,
                                style: const TextStyle(
                                    color: Colors.white, height: 1.4)),
                            const SizedBox(height: 10),
                            Wrap(
                              children: [
                                ..._movie!.genres
                                    .map((genre) => Container(
                                          padding: const EdgeInsets.all(8),
                                          margin: const EdgeInsets.only(
                                              right: 5, top: 5),
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            color: constSecondaryColor,
                                          ),
                                          child: Text(
                                            genre,
                                            style: constSecondaryTextStyle
                                                .copyWith(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                        ))
                                    .toList(),
                              ],
                            ),
                            const SizedBox(height: 30),
                            Text("Cast",
                                style: constHeadingStyle.copyWith(
                                    color: Colors.white, fontSize: 22)),
                            const SizedBox(height: 15),
                            SizedBox(
                              height: 250,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: _casts
                                    .map((data) => CastCard(data: data))
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                        onTap: () {
                          Provider.of<TicketProvider>(context, listen: false)
                              .changeMovieData(
                                  movieBackdrop: _movie!.backdropPath,
                                  movieId: _movie!.id,
                                  movieLanguage: _movie!.language,
                                  moviePoster: _movie!.posterPath,
                                  movieTitle: _movie!.title,
                                  movieVote: _movie!.voteAverage);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const OrderDateScreen()),
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: constSecondaryColor,
                          ),
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          child: Text("Ready to Roll?",
                              style: constTextStyle.copyWith(
                                  color: constTernaryColor,
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold)),
                        )))
              ],
            )
          : const Placeholder(),
    );
  }
}
