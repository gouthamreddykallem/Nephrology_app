import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nephrology_app/pages/all_providers_page.dart';
import 'package:nephrology_app/pages/provider_page.dart';
import 'package:nephrology_app/shared/detail.dart';
import 'package:nephrology_app/shared/style.dart';

class Providers extends StatelessWidget {
  final String title;
  final List<List<Detail>> providers;

  const Providers({super.key, required this.providers, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Text(
                title,
                style: picTitleStyle,
                maxLines: 2, // Allow the text to span up to 2 lines
                overflow:
                    TextOverflow.ellipsis, // Handle overflow with an ellipsis
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AllProvidersPage(
                        title: title,
                        details: providers,
                      );
                    },
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "See All",
                  style: TextStyle(
                    fontSize: 18.0, // Adjust the font size as needed
                    fontWeight: FontWeight.normal,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .28,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: min(providers.length, 5),
            itemBuilder: (context, index) {
              var provider = providers[index];
              return ProviderCard(
                details: provider,
              );
            },
          ),
        ),
      ],
    );
  }
}

class ProviderCard extends StatelessWidget {
  final List<Detail> details;

  const ProviderCard({
    super.key,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    String? name;
    String? imgPath;
    // Extract details from the list
    for (var detail in details) {
      switch (detail.key) {
        case 'name':
          name = detail.value;
          break;
        case 'picture':
          imgPath = detail.value;
          break;
      }
    }

    return AspectRatio(
      aspectRatio: 6 / 10,
      child: Padding(
        padding:
            const EdgeInsets.all(5.0), // Add padding around the entire card
        child: ClipRRect(
          // borderRadius: BorderRadius.circular(20),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProviderPage(details: details),
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Image.asset(
                    imgPath!,
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 10.0),
                  child: Text(
                    name!,
                    style: picStyle, // Ensure picStyle is defined correctly
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
