import 'package:flutter/material.dart';
import 'package:nephrology_app/shared/color.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ListView(
          children: [
            searchBar(context)

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

Widget _category() {
  return Column(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 8, right: 16, left: 16, bottom: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text("Category", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              "See All",
              style: TextStyles.titleNormal
                  .copyWith(color: Theme.of(context).primaryColor),
            ).p(8).ripple(() {})
          ],
        ),
      ),
      SizedBox(
        height: AppTheme.fullHeight(context) * .28,
        width: AppTheme.fullWidth(context),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            _categoryCard("Chemist & Drugist", "350 + Stores",
                color: LightColor.green, lightColor: LightColor.lightGreen),
            _categoryCard("Covid - 19 Specialist", "899 Doctors",
                color: LightColor.skyBlue, lightColor: LightColor.lightBlue),
            _categoryCard("Cardiologists Specialist", "500 + Doctors",
                color: LightColor.orange, lightColor: LightColor.lightOrange),
            _categoryCard("Dermatologist", "300 + Doctors",
                color: LightColor.green, lightColor: LightColor.lightGreen),
            _categoryCard("General Surgeon", "500 + Doctors",
                color: LightColor.skyBlue, lightColor: LightColor.lightBlue)
          ],
        ),
      ),
    ],
  );
}

Widget _categoryCard(String title, String subtitle,
    {Color color, Color lightColor}) {
  TextStyle titleStyle = TextStyles.title.bold.white;
  TextStyle subtitleStyle = TextStyles.body.bold.white;
  if (AppTheme.fullWidth(context) < 392) {
    titleStyle = TextStyles.body.bold.white;
    subtitleStyle = TextStyles.bodySm.bold.white;
  }
  return AspectRatio(
    aspectRatio: 6 / 8,
    child: Container(
      height: 280,
      width: AppTheme.fullWidth(context) * .3,
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: Offset(4, 4),
            blurRadius: 10,
            color: lightColor.withOpacity(.8),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
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
                    child: Text(title, style: titleStyle).hP8,
                  ),
                  SizedBox(height: 10),
                  Flexible(
                    child: Text(
                      subtitle,
                      style: subtitleStyle,
                    ).hP8,
                  ),
                ],
              ).p16
            ],
          ),
        ),
      ).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(20))),
    ),
  );
}