import 'package:flutter/material.dart';
import 'package:nephrology_app/shared/color.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> with SingleTickerProviderStateMixin {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 152.0, bottom: 4.0),
      alignment: Alignment.center,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [primaryColor, primaryColorLight],
          begin: FractionalOffset(0.0, 0.0),
          end: FractionalOffset(0.0, 1.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
        color: primaryColorLight,
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
      child: Stack(
        children: [
          // Positioned arcs
          Positioned(
            top: -50,
            left: -80,
            child: CircleAvatar(
              radius: 100,
              backgroundColor: Colors.white.withOpacity(0.1),
            ),
          ),
          Positioned(
            top: 50,
            right: 40,
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white.withOpacity(0.1),
            ),
          ),
          Positioned(
            top: 400,
            left: -80,
            child: CircleAvatar(
              radius: 150,
              backgroundColor: Colors.white.withOpacity(0.1),
            ),
          ),
          Positioned(
            top: 300,
            right: -80,
            child: CircleAvatar(
              radius: 100,
              backgroundColor: Colors.white.withOpacity(0.1),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
              child: Column(
                children: [
                  if (isExpanded) ...[
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
                  ],
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, bottom: 8.0, top: 16.0),
                    child: Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        width: isExpanded
                            ? MediaQuery.of(context).size.height * .24
                            : MediaQuery.of(context).size.height * .12,
                        height: isExpanded
                            ? MediaQuery.of(context).size.height * .24
                            : MediaQuery.of(context).size.height * .12,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: isExpanded
                              ? MediaQuery.of(context).size.height * .12
                              : MediaQuery.of(context).size.height * .06,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ClipOval(
                              child: Image.asset(
                                "assets/logo_2.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (isExpanded) ...[
                    const SizedBox(height: 8.0),
                    const Text(
                      "The Nephrology Group, Inc. (TNG) is Central California’s largest Nephrology Practice. Since founded in 1975, our physicians are committed to providing quality care to patients with acute kidney",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                  ],
                  InkWell(
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: Icon(
                      size: 40.0,
                      isExpanded
                          ? Icons.arrow_drop_up_sharp
                          : Icons.arrow_drop_down_sharp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
