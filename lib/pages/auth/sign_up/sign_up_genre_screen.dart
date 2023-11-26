import 'package:flutix/components/button_component.dart';
import 'package:flutix/models/user.dart';
import 'package:flutix/providers/sign_up_provider.dart';
import 'package:flutix/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutix/globals.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

import 'package:provider/provider.dart';

class SelectCard extends StatelessWidget {
  final Map<String, String> data;
  final bool isSelected;
  void Function() onPressed;
  SelectCard(
      {Key? key,
      this.isSelected = false,
      required this.data,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 20),
      child: Material(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        clipBehavior: Clip.antiAlias,
        elevation: 1,
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
              height: 115,
              width: 100,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(
                  left: 22, right: 22, bottom: 15, top: 15),
              decoration: BoxDecoration(
                color: constPrimaryColor,
                image: isSelected
                    ? null
                    : DecorationImage(
                        image: NetworkImage(data["image"]!),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                        colorFilter: ColorFilter.mode(
                            constPrimaryColor.withOpacity(0.7),
                            BlendMode.darken),
                      ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(data["name"]!,
                      style: GoogleFonts.raleway(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.white))
                ],
              )),
        ),
      ),
    ));
  }
}

class SignUpGenreScreen extends StatefulWidget {
  final VoidCallback voidCallback;
  const SignUpGenreScreen({Key? key, required this.voidCallback})
      : super(key: key);

  @override
  State<SignUpGenreScreen> createState() => _SignUpGenreScreenState();
}

class _SignUpGenreScreenState extends State<SignUpGenreScreen> {
  final List<List<Map<String, String>>> _languages = [
    [
      {"name": "ID", "image": "https://flagcdn.com/w320/id.png"},
      {"name": "US", "image": "https://flagcdn.com/w320/us.png"},
    ],
    [
      {"name": "JP", "image": "https://flagcdn.com/w320/jp.png"},
      {"name": "KR", "image": "https://flagcdn.com/w320/kr.png"}
    ]
  ];
  final List<List<Map<String, String>>> _genres = [
    [
      {"name": "Action", "image": "https://source.unsplash.com/random?Movie&1"},
      {"name": "Horror", "image": "https://source.unsplash.com/random?Movie&2"},
    ],
    [
      {"name": "Drama", "image": "https://source.unsplash.com/random?Movie&3"},
      {"name": "Fantasy", "image": "https://source.unsplash.com/random?Movie&4"}
    ],
    [
      {
        "name": "Romance",
        "image": "https://source.unsplash.com/random?Movie&5"
      },
      {
        "name": "Musicals",
        "image": "https://source.unsplash.com/random?Movie&6"
      }
    ]
  ];

  String selectedLanguage = '';
  List<String> selectedGenres = [];
  bool loading = false;

  void _handleSubmit() async {
    setState(() {
      loading = true;
    });
    UserModel user = Provider.of<SignUpProvider>(context, listen: false).user;
    await AuthService.signUp(user);
    setState(() {
      loading = false;
    });
    widget.voidCallback();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpProvider>(builder: (context, signUpData, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10.0,
          ),
          Text("Your Language", style: constHeadingStyle),
          const SizedBox(
            height: 20.0,
          ),
          ..._languages
              .map<Widget>((_languageRow) => Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ..._languageRow
                          .map<Widget>((_language) => SelectCard(
                                key: ObjectKey(_language),
                                data: _language,
                                isSelected:
                                    selectedLanguage == _language['name'],
                                onPressed: () {
                                  setState(() {
                                    selectedLanguage = _language['name']!;
                                  });
                                  Provider.of<SignUpProvider>(context,
                                          listen: false)
                                      .changeLanguage(_language['name']!);
                                },
                              ))
                          .toList(),
                    ],
                  ))
              .toList(),
          Text("Your Genre", style: constHeadingStyle),
          const SizedBox(
            height: 20.0,
          ),
          ..._genres
              .map<Widget>((_genreRow) => Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ..._genreRow
                          .map<Widget>((_genre) => SelectCard(
                                key: ObjectKey(_genre),
                                data: _genre,
                                isSelected:
                                    selectedGenres.contains(_genre['name']),
                                onPressed: () {
                                  if (selectedGenres
                                      .contains(_genre['name']!)) {
                                    setState(() {
                                      selectedGenres.remove(_genre['name']!);
                                    });
                                  } else {
                                    setState(() {
                                      selectedGenres.add(_genre['name']!);
                                    });
                                  }
                                  Provider.of<SignUpProvider>(context,
                                          listen: false)
                                      .changeGenres(selectedGenres);
                                },
                              ))
                          .toList(),
                    ],
                  ))
              .toList(),
          const SizedBox(
            height: 20.0,
          ),
          ButtonIconComponent(
            loading: loading,
            buttontext: 'Continue',
            onPressed: _handleSubmit,
          ),
          // ),
        ],
      );
    });
  }
}
