import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class Language {
  final String name;
  final String code;

  Language(this.name, this.code);
}

Future<Map<String, String>?> showLanguageBottomSheet(
    BuildContext context) async {
  List<Language> languages = [
    Language("English", "en"),
    Language("Spanish", "es"),
    Language("Chinese (Simplified)", "zh"),
    Language("Hindi", "hi"),
    Language("Arabic", "ar"),
    Language("French", "fr"),
    Language("Russian", "ru"),
    Language("Portuguese", "pt"),
    Language("Bengali", "bn"),
    Language("German", "de"),
  ];

  Map<String, String>? result = await showModalBottomSheet<Map<String, String>>(
    context: context,
    builder: (BuildContext context) {
      TextEditingController searchController = TextEditingController();
      List<Language> filteredLanguages = List.from(languages);
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            color: const Color(0xff3a3b3d),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "From",
                    style: TextStyle(
                      color: Color(0xffbdbec0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        hintText: "Search languages...",
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                      onChanged: (value) {
                        setState(() {
                          filteredLanguages = languages
                              .where((language) => language.name
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .toList();
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    "All Languages",
                    style: TextStyle(
                      color: Color(0xffbdbec0),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredLanguages.length,
                      itemBuilder: (context, index) {
                        final language = filteredLanguages[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context, {
                                "name": language.name,
                                "code": language.code,
                              });
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black,
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 12),
                                child: Text(
                                  language.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Color(0xffbdbec0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
  return result;
}

// This function returns true if the screen width is greater than 600 pixels (for tablets and web)
bool isLargeScreen(BuildContext context) {
  return MediaQuery.of(context).size.width > 600;
}
