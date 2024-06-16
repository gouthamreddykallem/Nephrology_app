import 'package:flutter/material.dart';
import 'package:nephrology_app/pages/buttons_section.dart';
// import 'package:nephrology_app/pages/bodies/home_body_scrap.dart';
import 'package:nephrology_app/shared/color.dart';

import '../../shared/data.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ListView(
          children: [
            searchBar(context),
            const ButtonSection(),
            category(context, "Kidney Services", kidneyServices),
            category(context, "Vascular Access", kidneyServices)
          ],
        )
    );
  }
}

Widget searchBar(BuildContext context) {
  return Container(
    decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [
              primaryColorLight,
              primaryColor
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(26),
            bottomLeft: Radius.circular(26))),
    child: Padding(
      padding:
      const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),
        ),
        child: ListTile(
          leading: const Icon(
            Icons.search,
            color: secondaryColor,
          ),
          title: TextField(
            textInputAction: TextInputAction.search,
            onSubmitted: (pattern) {},
            decoration: const InputDecoration(
              hintText: "Search",
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget category(BuildContext context, String title, List<Map<String, String>> kidneyServices) {
  return Column(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 8, right: 16, left: 16, bottom: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {
                // Add your onTap functionality here
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "See All",
                  style: TextStyle(
                    fontSize: 16.0, // Adjust the font size as needed
                    fontWeight: FontWeight.normal,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height * .28,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: kidneyServices.length,
          itemBuilder: (context, index) {
            var category = kidneyServices[index];
            return categoryCard(
              context,
              category["title"]!,
              category["subtitle"]!,
              color: Color(int.parse(category["color"]!)),
              lightColor: Color(int.parse(category["lightColor"]!)),
            );
          },
        ),
      ),
    ],
  );
}

Widget categoryCard(BuildContext context, String title, String subtitle,
    {required Color color, required Color lightColor}) {
  TextStyle titleStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white);
  TextStyle subtitleStyle = const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white);

  if (MediaQuery.of(context).size.width < 392) {
    titleStyle = const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white);
    subtitleStyle = const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white);
  }

  return AspectRatio(
    aspectRatio: 6 / 8,
    child: Container(
      height: 280,
      width: MediaQuery.of(context).size.width * .3,
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: const Offset(4, 4),
            blurRadius: 10,
            color: lightColor.withOpacity(.8),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: InkWell(
          onTap: () {
            // Add your onTap functionality here
          },
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Container(
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: -20,
                  left: -20,
                  child: CircleAvatar(
                    backgroundColor: lightColor,
                    radius: 60,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(title, style: titleStyle),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(subtitle, style: subtitleStyle),
                      ),
                    ),
                  ],
                ),
              ],
            ).padding(const EdgeInsets.all(16)),
          ),
        ),
      ),
    ),
  );
}

extension WidgetPadding on Widget {
  Widget padding([EdgeInsetsGeometry? insets]) => Padding(
    padding: insets ?? const EdgeInsets.all(0),
    child: this,
  );
}