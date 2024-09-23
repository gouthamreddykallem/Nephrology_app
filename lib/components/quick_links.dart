import 'package:flutter/material.dart';
import 'package:nephrology_app/pages/online_forms_page.dart';
import 'package:nephrology_app/shared/color.dart';
import 'package:nephrology_app/utilities/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class QuickLinks extends StatefulWidget {
  const QuickLinks({super.key});

  @override
  State<QuickLinks> createState() => _QuickLinksState();
}

class _QuickLinksState extends State<QuickLinks>
    with SingleTickerProviderStateMixin {
  void _toggleExpand(int index) {
    setState(() {
      for (int i = 0; i < sections.length; i++) {
        if (i == index) {
          sections[i].isExpanded =
              !sections[i].isExpanded; // Toggle selected section
        } else {
          sections[i].isExpanded = false; // Collapse other sections
        }
      }
    });
  }

  bool isTextExpanded = false;

  void _toggleTextExpand() {
    setState(() {
      isTextExpanded = !isTextExpanded;
    });
  }

   Future<void> _launchPhone(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch phone $phoneUri';
    }
  }


  @override
  Widget build(BuildContext context) {
    const String fullText =
        "Since 1975, The Nephrology Group, Inc. has been Central California’s largest and most trusted nephrology practice. We have grown from one dedicated physician to a comprehensive team of board-certified nephrologists, nurse practitioners, renal dietitians, nurse educators, and social workers. We offer a wide range of services to support our patients, from in-office visits to hospital care.";

    const int truncatedLength =
        80; // Number of characters to show when truncated
    final String truncatedText = fullText.length > truncatedLength
        ? '${fullText.substring(0, truncatedLength)}...'
        : fullText;

    return Container(
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.only(left:20.0, right: 20.0, top: 20.0, bottom: 16.0),
      alignment: Alignment.center,
      width: double.infinity,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Quick Links",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 6.0,
              )
              // Container(
              //   padding: const EdgeInsets.all(6.0),
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(16.0),
              //   ),
              //   child: const Text("TNG",
              //       style: TextStyle(
              //         fontFamily: "Poppins",
              //         fontSize: 20.0,
              //         fontWeight: FontWeight.w500,
              //         fontStyle: FontStyle.italic,
              //         color: primaryColor,
              //       )),
              // ),
            ],
          ),
          const SizedBox(
            height: 16.0,
          ),
          // const Align(
          //   alignment: Alignment.centerLeft,
          //   child: Text("Brief Overview",
          //       style: TextStyle(
          //         fontFamily: "Poppins",
          //         fontSize: 20.0,
          //         fontWeight: FontWeight.w500,
          //         color: Colors.white,
          //       )),
          // ),
          // const SizedBox(
          //   height: 10.0,
          // ),
          // GestureDetector(
          //   onTap: _toggleTextExpand,
          //   child: AnimatedCrossFade(
          //     duration: const Duration(milliseconds: 300),
          //     firstChild: Text(
          //       truncatedText,
          //       style: const TextStyle(
          //         fontFamily: "Poppins",
          //         fontSize: 12.0,
          //         fontWeight: FontWeight.normal,
          //         color: Colors.white,
          //       ),
          //     ),
          //     secondChild: const Text(
          //       fullText,
          //       style: TextStyle(
          //         fontFamily: "Poppins",
          //         fontSize: 12.0,
          //         fontWeight: FontWeight.normal,
          //         color: Colors.white,
          //       ),
          //     ),
          //     crossFadeState: isTextExpanded
          //         ? CrossFadeState.showSecond
          //         : CrossFadeState.showFirst,
          //   ),
          // ),
          const SizedBox(
            height: 16.0,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: sections.length,
            itemBuilder: (context, index) {
              final section = sections[index];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: section.isExpanded ? grey : primaryColorLight,
                  borderRadius: BorderRadius.circular(26.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: primaryColor,
                              child: Icon(
                                section.icon,
                                color: lightBlue,
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              section.title,
                              style: const TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        if (!section.isExpanded)
                          CircleAvatar(
                            radius: 30.0,
                            backgroundColor: lightBlue,
                            child: IconButton(
                              onPressed: () => _toggleExpand(index),
                              icon: Icon(
                                section.isExpanded ? Icons.remove : Icons.add,
                                color: primaryColor,
                              ),
                            ),
                          )
                      ],
                    ),
                    AnimatedCrossFade(
                      duration: const Duration(milliseconds: 300),
                      firstChild: Container(), // Empty container when collapsed
                      secondChild: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            section.content,
                            style: const TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 12.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          ElevatedButton(
                            onPressed: () {
                              if(section.title=="Make a Payment"){
                                _launchPhone(section.link);
                              }
                              else if(section.title=="Online forms"){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const OnlineFormsPage();
                                    },
                                  ),
                                );
                              }
                              else{
                              Utilities.urlLauncher(Uri.parse(section.link));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: primaryColor,
                            ),
                            child: Text(section.buttonText),
                          ),
                        ],
                      ),
                      crossFadeState: section.isExpanded
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class Section {
  final String title;
  final String content;
  final String buttonText;
  final String link;
  final IconData icon;
  bool isExpanded;

  Section({
    required this.title,
    required this.content,
    required this.buttonText,
    required this.link,
    required this.icon,
    this.isExpanded = false,
  });
}

final List<Section> sections = [
  Section(
    title: 'Make a Payment',
    content:
        'If you need assistance making a payment or have questions about your dues, please call us.',
    buttonText: 'Call us',
    link: '+1-559-228-6600',
    isExpanded: true,
    icon: Icons.info_outline,
  ),
  Section(
    title: 'Visit Patient Portal',
    content:
        'Access your health records, manage appointments, or communicate with your care team.',
    buttonText: 'Visit Portal',
    link: 'https://www.myhealthrecord.com/Portal/SSO',
    isExpanded: false,
    icon: Icons.medical_services,
  ),
  Section(
    title: 'Online forms',
    content:
        'Find all related forms below',
    buttonText: 'Forms',
    link: 'https://www.thenephrologygroupinc.com/About-Us/Administration',
    isExpanded: false,
    icon: Icons.groups,
  ),
  // Section(
  //   title: 'Events',
  //   content:
  //       'Stay connected with The Nephrology Group through our events. See upcoming events and community outreach activities.',
  //   buttonText: 'View Events',
  //   link: 'https://www.thenephrologygroupinc.com/Events',
  //   isExpanded: false,
  //   icon: Icons.event,
  // ),
];
