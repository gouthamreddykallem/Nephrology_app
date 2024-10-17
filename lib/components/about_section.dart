import 'package:flutter/material.dart';
import 'package:nephrology_app/shared/color.dart';
import 'package:nephrology_app/utilities/utils.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection>
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "About",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 6.0,
              ),
              Container(
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: const Text("TNG",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      color: primaryColor,
                    )),
              ),
            ],
          ),
          const SizedBox(
            height: 16.0,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text("Brief Overview",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                )),
          ),
          const SizedBox(
            height: 10.0,
          ),
          GestureDetector(
            onTap: _toggleTextExpand,
            child: AnimatedCrossFade(
              duration: const Duration(milliseconds: 300),
              firstChild: Text(
                truncatedText,
                style: const TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 12.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
              secondChild: const Text(
                fullText,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 12.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
              crossFadeState: isTextExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
            ),
          ),
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
                              Utilities.urlLauncher(Uri.parse(section.link));
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
    title: 'Who We Are',
    content:
        'Since 1975, we have been committed to delivering exceptional kidney care in Central California. Our team provides comprehensive patient care both in our offices and hospitals, offering services such as lab testing, infusion therapy, dialysis education, dietitian classes, injection clinics, and transplant support.',
    buttonText: 'Learn More',
    link: 'https://www.thenephrologygroupinc.com/About-Us/Mission-and-Vision',
    isExpanded: true,
    icon: Icons.info_outline,
  ),
  Section(
    title: 'Our Providers',
    content:
        'Our dedicated team of board-certified nephrologists and experienced nurse practitioners deliver exceptional kidney care. We create personalized treatment plans tailored to each patient’s needs, ensuring the highest standard of care.',
    buttonText: 'Learn More',
    link: 'https://www.thenephrologygroupinc.com/CRM/Provider2',
    isExpanded: false,
    icon: Icons.medical_services,
  ),
  Section(
    title: 'Our Team',
    content:
        'Our dedicated administrative team ensures smooth operations and exceptional patient experiences. From scheduling appointments to managing records, our team is committed to supporting your healthcare journey.',
    buttonText: 'Learn More',
    link: 'https://www.thenephrologygroupinc.com/About-Us/Administration',
    isExpanded: false,
    icon: Icons.groups,
  ),
  Section(
    title: 'Events',
    content:
        'Stay connected with The Nephrology Group through our events. See upcoming events and community outreach activities.',
    buttonText: 'View Events',
    link: 'https://www.thenephrologygroupinc.com/Events',
    isExpanded: false,
    icon: Icons.event,
  ),
];
