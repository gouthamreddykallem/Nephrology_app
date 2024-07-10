import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nephrology_app/components/build_categories.dart';
import 'package:nephrology_app/components/build_services.dart';
import 'package:nephrology_app/components/header.dart';
import 'package:nephrology_app/pages/contact_us_page.dart';
import 'package:nephrology_app/pages/payments_page.dart';
import 'package:nephrology_app/pages/load_pdf_page.dart';
import 'package:nephrology_app/shared/color.dart';
import 'package:nephrology_app/shared/data.dart';
import 'package:nephrology_app/shared/style.dart';
import 'package:nephrology_app/utilities/utils.dart';

var expandWidgetsHome = <bool>[false, false];

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  void _toggleExpand(int index) {
    setState(() {
      expandWidgetsHome[index] = !expandWidgetsHome[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          Stack(
            children: [
              const Header(),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: quickButtons(context),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: searchBar(context),
              ),
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
          buildTile(context, Colors.blue, "ABOUT US", "assets/aboutus.svg", 48,
              () => _toggleExpand(0), expandWidgetsHome[0], true),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: expandWidgetsHome[0]
                  ? BuildCategories(
                      categories: aboutUs,
                      drawLinesOnRight: false,
                      cardColor: primaryColor,
                    )
                  : const SizedBox.shrink(),
            ),
          ),
          buildTile(context, Colors.blue, "SERVICES", "assets/kidneyIcon.svg",
              48, () => {_toggleExpand(1)}, expandWidgetsHome[1], true),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: expandWidgetsHome[1]
                  ? const BuildServices()
                  : const SizedBox.shrink(),
            ),
          ),
          buildTile(
            context,
            Colors.blue,
            "MAKE A PAYMENT",
            "assets/payment.svg",
            42,
            () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const PaymentsPage();
                  },
                ),
              )
            },
            false,
            false,
          ),
          buildTile(
            context,
            Colors.blue,
            "CONTACT US",
            "assets/contact_us.svg",
            30,
            () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const ContactUsPage();
                  },
                ),
              )
            },
            false,
            false,
          ),
          const SizedBox(
            height: 50.0,
          ),
        ],
      ),
    );
  }
}

Widget searchBar(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      color: lightCyan,
      borderRadius: const BorderRadius.only(
        bottomRight: Radius.circular(26),
        bottomLeft: Radius.circular(26),
      ),
      boxShadow: [
        BoxShadow(
          offset: const Offset(4, 4),
          blurRadius: 10,
          color: primaryColorLight.withOpacity(0.8),
        ),
      ],
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

Widget buildTile(
  BuildContext context,
  Color color,
  String title,
  String iconPath,
  double iconSize,
  Function onTap,
  bool isExpanded,
  bool canExpand,
) {
  Widget iconWidget = SvgPicture.asset(
    iconPath,
    width: iconSize,
    height: iconSize,
    colorFilter: ColorFilter.mode(
      Colors.white.withOpacity(0.9),
      BlendMode.srcIn,
    ),
  );
  return Column(
    children: <Widget>[
      SizedBox(
        height: MediaQuery.of(context).size.height * .09,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
          child: Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(4, 4),
                  blurRadius: 10,
                  color: color.withOpacity(0.9),
                ),
              ],
            ),
            child: InkWell(
              onTap: onTap as void Function()?,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: -20,
                      bottom: -20,
                      left: -20,
                      child: CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(0.25),
                        radius: 60,
                        child: iconWidget,
                      ),
                    ),
                    if (canExpand)
                      Positioned(
                        bottom: 0,
                        top: 0,
                        right: 5,
                        child: CircleAvatar(
                          backgroundColor: Colors.white.withOpacity(0.25),
                          radius: 20,
                          child: Icon(
                            size: 40.0,
                            isExpanded ? Icons.expand_less : Icons.expand_more,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    Center(
                      child: Text(title, style: titleStyle),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget quickButtons(BuildContext context) {
  return Container(
    padding:
        const EdgeInsets.only(top: 98.0, bottom: 16.0, left: 16.0, right: 16.0),
    alignment: Alignment.center,
    width: double.infinity,
    decoration: const BoxDecoration(
      color: lightCyan,
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(26),
        bottomLeft: Radius.circular(26),
      ),
      boxShadow: [
        BoxShadow(
          offset: Offset(4, 4),
          blurRadius: 10,
          color: Colors.black38,
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: buildButton(
              context,
              "PATIENT PORTAL",
              () => {
                    Utilities.urlLauncher(
                        Uri.parse("https://www.myhealthrecord.com/Portal/SSO"))
                  }),
        ),

        const SizedBox(width: 16), // Adjust spacing as needed
        Expanded(
          child: buildButton(
              context,
              "REFER A PATIENT",
              () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const LoadPdfPage(
                            url:
                                "https://www.thenephrologygroupinc.com/Portals/0/Online%20Forms/Forms%202-12-2018/NewPatientRF.pdf",
                            title: "Refer a Patient",
                          );
                        },
                      ),
                    )
                  }),
        ),
      ],
    ),
  );
}

Widget buildButton(BuildContext context, String title, Function onTap) {
  return ElevatedButton(
    onPressed: onTap as void Function()?,
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: primaryColor, // Set the text color
      textStyle: const TextStyle(
        fontSize: 20, // Set the font size
        fontWeight: FontWeight.bold, // Set the font weight
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // Adjust as needed
      ),
    ),
    child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(title, textAlign: TextAlign.center)),
  );
}
