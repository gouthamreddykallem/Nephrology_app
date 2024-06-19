import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nephrology_app/components/category_card.dart';
import 'package:nephrology_app/shared/color.dart';
import 'package:nephrology_app/shared/data.dart';
import 'package:nephrology_app/utilities/utils.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
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
                  child: Category(
                    title: "Services",
                    categories: kidneyServices,
                    iconPath: "assets/kidneyIcon.svg",
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Category(
                    title: "About Us",
                    categories: aboutUs,
                    iconPath: "assets/aboutus.svg",
                  ),
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
        begin: FractionalOffset(0.0, 0.0),  // Top center
        end: FractionalOffset(0.0, 1.0),    // Bottom center
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

Widget buildButton(BuildContext context, String text) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: primaryColor,
      shadowColor: Colors.blueAccent,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    ),
    onPressed: () {
      if (text == "PATIENT PORTAL") {
        Utilities.urlLauncher(
            Uri.parse("https://www.myhealthrecord.com/Portal/SSO"));
      } else {
        Utilities.urlLauncher(Uri.parse(
            "https://www.thenephrologygroupinc.com/Portals/0/Online%20Forms/Forms%202-12-2018/NewPatientRF.pdf?ver=2018-02-16-140849-517"));
      }
    },
    child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
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
              //colors: [primaryColorLight, secondaryColor],
              colors: [primaryColorLight, primaryColorLight],
              begin: FractionalOffset(0.0, 0.0),  // Top center
              end: FractionalOffset(0.0, 1.0),    // Bottom center
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
                  color: Colors.black,
                  fontSize: 40.0,
                  fontFamily: 'TimesNewRoman',
                  fontWeight: FontWeight.w700, // Use the corresponding weight
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
                  color: Colors.black54,
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
