import 'package:flutter/material.dart';
import 'package:nephrology_app/components/category_card.dart';
import 'package:nephrology_app/shared/color.dart';
import 'package:nephrology_app/shared/data.dart';
import 'package:nephrology_app/utilities/utils.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ListView(
      children: [
        searchBar(context),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildButton(context, 'PATIENT PORTAL'),
              buildButton(context, 'REFER A PATIENT'),
            ],
          ),
        ),
        Category(title: "Kidney Services", categories: kidneyServices),
        Category(title: "Vascular Access", categories: vascularAccess),
        Category(title: "About Us", categories: aboutUs),
      ],
    ));
  }
}

Widget searchBar(BuildContext context) {
  return Container(
    decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [primaryColorLight, primaryColor],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(26), bottomLeft: Radius.circular(26))),
    child: Padding(
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 10),
      child: Container(
        // height: 50,
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
      backgroundColor: primaryColor, // Text color
      shadowColor: Colors.blueAccent, // Shadow color
      elevation: 8, // Elevation for 3D effect
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Rounded corners
      ),
      padding:
          const EdgeInsets.symmetric(horizontal: 24, vertical: 16), // Padding
    ),
    onPressed: () {
      if(text=="PATIENT PORTAL"){
        Utilities.urlLauncher(Uri.parse("https://www.myhealthrecord.com/Portal/SSO"));
      }
      else{
        Utilities.urlLauncher(Uri.parse("https://www.thenephrologygroupinc.com/Portals/0/Online%20Forms/Forms%202-12-2018/NewPatientRF.pdf?ver=2018-02-16-140849-517"));
      }
      // Button pressed action
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('$text pressed')),
      // );
    },
    child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold))
  );
}
