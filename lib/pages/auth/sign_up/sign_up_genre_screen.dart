import 'package:flutix/components/button_component.dart';
import 'package:flutter/material.dart';
import 'package:flutix/globals.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

class SelectCard extends StatelessWidget {
  final Map<String, String> data;
  final bool isSelected;
  const SelectCard({Key? key, this.isSelected = false, required this.data})
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
          onTap: () {},
          child: Container(
              height: 115,
              width: 100,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(
                  left: 22, right: 22, bottom: 15, top: 15),
              decoration: BoxDecoration(
                color: constPrimaryColor,
                image: isSelected ? null : DecorationImage(
                  image: NetworkImage(data["image"]!),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  colorFilter: ColorFilter.mode(
                          constPrimaryColor.withOpacity(0.7), BlendMode.darken),
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
      {"name": "Bahasa", "image": "https://flagcdn.com/w320/id.png"},
      {"name": "English", "image": "https://flagcdn.com/w320/us.png"},
    ],
    [
      {"name": "Japanese", "image": "https://flagcdn.com/w320/jp.png"},
      {"name": "Korean", "image": "https://flagcdn.com/w320/kr.png"}
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
      {"name": "Romance", "image": "https://source.unsplash.com/random?Movie&5"},
      {"name": "Musicals", "image": "https://source.unsplash.com/random?Movie&6"}
    ]
  ];

  var _selectedGenres = [];

  @override
  Widget build(BuildContext context) {
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
                              isSelected: Random().nextBool(),
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
                              isSelected: Random().nextBool()))
                        .toList(),
                  ],
                ))
            .toList(),
        const SizedBox(
          height: 20.0,
        ),
        ButtonIconComponent(
          buttontext: 'Continue',
          onPressed: widget.voidCallback,
        ),
        // ),
      ],
    );
  }
}
