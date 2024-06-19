import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nephrology_app/components/category_card.dart';
import 'package:nephrology_app/pages/education_page.dart';
import 'package:nephrology_app/shared/color.dart';
import 'package:nephrology_app/shared/data.dart';
import 'package:nephrology_app/shared/style.dart';
import 'package:nephrology_app/utilities/utils.dart';

enum ExpandState { collapsed, expanded1, expanded2 }

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  ExpandState _expandState = ExpandState.collapsed;

  void _toggleExpand(ExpandState state) {
    setState(() {
      if (_expandState == state) {
        _expandState = ExpandState.collapsed;
      } else {
        _expandState = state;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          searchBar(context),
          buildHeader(context),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: buildTile(
                      context,
                      Colors.green,
                      Colors.green.shade300,
                      "SERVICES",
                      "assets/kidneyIcon.svg",
                      () => _toggleExpand(ExpandState.expanded1),
                      _expandState == ExpandState.expanded1,
                      true),
                ),
                Expanded(
                  child: buildTile(
                      context,
                      Colors.green,
                      Colors.green.shade300,
                      "ABOUT US",
                      "assets/aboutus.svg",
                      () => _toggleExpand(ExpandState.expanded2),
                      _expandState == ExpandState.expanded2,
                      true),
                ),
              ],
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _expandState == ExpandState.collapsed
                ? const SizedBox.shrink()
                : AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: _expandState == ExpandState.expanded1
                        ? Container(
                            key: const ValueKey(ExpandState.expanded1),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: ListView(
                              shrinkWrap:
                                  true, // Make ListView take only the necessary space
                              physics:
                                  const NeverScrollableScrollPhysics(), // Disable scrolling inside the ListView
                              children: [
                                Category(
                                  title: "Kidney Services",
                                  categories: kidneyServices,
                                ),
                                Category(
                                  title: "Vascular Access",
                                  categories: vascularAccess,
                                ),
                              ],
                            ),
                          )
                        : Container(
                            key: const ValueKey(ExpandState.expanded2),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: ListView(
                              shrinkWrap:
                                  true, // Make ListView take only the necessary space
                              physics:
                                  const NeverScrollableScrollPhysics(), // Disable scrolling inside the ListView
                              children: [
                                Category(
                                  title: "About Us",
                                  categories: aboutUs,
                                ),
                              ],
                            ),
                          ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: buildTile(
                      context,
                      Colors.green,
                      Colors.green.shade300,
                      "PATIENT PORTAL",
                      "assets/medical.svg",
                      () => {
                            Utilities.urlLauncher(Uri.parse(
                                "https://www.myhealthrecord.com/Portal/SSO"))
                          },
                      false,
                      false),
                ),
                Expanded(
                  child: buildTile(
                      context,
                      Colors.green,
                      Colors.green.shade300,
                      "EDUCATION",
                      "assets/school.svg",
                      () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const EducationBody();
                                },
                              ),
                            )
                          },
                      false,
                      false),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget searchBar(BuildContext context) {
  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [primaryColorLight, primaryColor],
        begin: FractionalOffset(0.0, 0.0),
        end: FractionalOffset(0.0, 1.0),
        stops: [0.0, 1.0],
        tileMode: TileMode.clamp,
      ),
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(26),
        bottomLeft: Radius.circular(26),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),
        ),
        child: ListTile(
          leading: const Icon(
            Icons.search_rounded,
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

Widget buildHeader(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    alignment: Alignment.center,
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [primaryColorLight, primaryColorLight],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(0.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
            color: primaryColorLight,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                offset: const Offset(4, 4),
                blurRadius: 10,
                color: primaryColorLight.withOpacity(0.8),
              ),
            ],
          ),
          child: Column(
            children: [
              const Text(
                "WELCOME\nTO TNG",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: MediaQuery.of(context).size.height * .12,
                  child: Image.asset(
                    "assets/logo_2.jpg",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const Text(
                "The Nephrology Group, Inc. (TNG) is Central California’s largest Nephrology Practice. Since founded in 1975, our physicians are committed to providing quality care to patients with acute kidney",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildTile(
  BuildContext context,
  Color color,
  Color lightColor,
  String title,
  String iconPath,
  Function onTap,
  bool isExpanded,
  bool canExpand,
) {
  Widget iconWidget = SvgPicture.asset(
    iconPath,
    width: 48,
    height: 48,
    color: Colors.white.withOpacity(0.9),
  );
  return Column(
    children: <Widget>[
      SizedBox(
        height: isExpanded
            ? MediaQuery.of(context).size.height * .22
            : MediaQuery.of(context).size.height * .20,
        child: InkWell(
          onTap: onTap as void Function()?,
          child: AspectRatio(
            aspectRatio: 2 / 2,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(4, 4),
                      blurRadius: 10,
                      color: lightColor.withOpacity(0.8),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: -20,
                        right: -20,
                        child: CircleAvatar(
                          backgroundColor: lightColor,
                          radius: 60,
                          child: iconWidget,
                        ),
                      ),
                      if (canExpand)
                        Positioned(
                          bottom: 5,
                          right: 5,
                          child: CircleAvatar(
                            backgroundColor: lightColor,
                            radius: 20,
                            child: Icon(
                              size: 40.0,
                              isExpanded
                                  ? Icons.expand_less
                                  : Icons.expand_more,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      const SizedBox(height: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Flexible(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(title, style: titleStyle),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
