import 'package:flutter/material.dart';
import 'package:nephrology_app/shared/color.dart';
import 'package:nephrology_app/shared/detail.dart';

class ProviderPage extends StatefulWidget {
  final List<Detail> details;
  const ProviderPage({super.key, required this.details});

  @override
  State<ProviderPage> createState() => _ProviderPageState();
}

class _ProviderPageState extends State<ProviderPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String? name;
    String? imgPath;

    // Extract details from the list
    for (var detail in widget.details) {
      switch (detail.key) {
        case 'name':
          name = detail.value;
          break;
        case 'picture':
          imgPath = detail.value;
          break;
      }
    }
    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Hero(
                        tag: name!,
                        child: Image.asset(
                          imgPath!,
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.topCenter,
                          height: size.height * 0.6,
                        ),
                      ),
                      const SizedBox(height: 16.0), // Spacing below the image
                      Container(
                        decoration: const BoxDecoration(
                          color: primaryColorLight,
                          // borderRadius: const BorderRadius.only(
                          //   topLeft: Radius.circular(24.0),
                          //   topRight: Radius.circular(24.0),
                          // ),
                          borderRadius: BorderRadius.all(Radius.circular(24.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 24.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 40.0, // Adjusted for better visibility
            left: 16.0,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
