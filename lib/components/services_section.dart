import 'package:flutter/material.dart';
import 'package:nephrology_app/shared/color.dart';
import 'package:nephrology_app/utilities/utils.dart';

class ServicesSection extends StatefulWidget {
  const ServicesSection({super.key});

  @override
  State<ServicesSection> createState() => _ServicesSectionState();
}

class _ServicesSectionState extends State<ServicesSection>
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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.all(20.0),
      alignment: Alignment.center,
      width: double.infinity,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(22.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
              const SizedBox(
                width: 4.0,
              ),
              const Text("Services",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ))
            ],
          ),
          const SizedBox(
            height: 16.0,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text("Key Services Overview",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                )),
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
                margin: const EdgeInsets.symmetric(vertical: 6.0),
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
                            const SizedBox(height: 10.0),
                            Text(
                              section.title,
                              style: const TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        if (!section.isExpanded)
                          CircleAvatar(
                            radius: 30.0,
                            backgroundColor: lightBlue,
                            child: IconButton(
                              onPressed: () => _toggleExpand(index),
                              icon: Icon(section.isExpanded
                                  ? Icons.remove
                                  : Icons.add, color: primaryColor,),
                            ),
                          ),
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
                          // Display subservices as bullet points with icons
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: section.subservices.length,
                            itemBuilder: (context, subIndex) {
                              final subservice = section.subservices[subIndex];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      subservice.icon,
                                      color: Colors.white,
                                      size: 20.0,
                                    ),
                                    const SizedBox(width: 8.0),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            subservice.name,
                                            style: const TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            subservice.description,
                                            style: const TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
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
          Container(
            margin: const EdgeInsets.symmetric(vertical: 6.0),
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: grey,
              borderRadius: BorderRadius.circular(26.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: primaryColor,
                          child: Icon(
                            Icons.explore,
                            color: lightBlue,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          "Explore All Services",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 30.0,
                      backgroundColor: lightBlue,
                      child: IconButton(
                        onPressed: () {
                          Utilities.urlLauncher(Uri.parse(
                              "https://www.thenephrologygroupinc.com/Services"));
                        },
                        icon: const Icon(Icons.search_rounded, color: primaryColor,),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Subservice {
  final String name;
  final IconData icon;
  final String description;

  Subservice({
    required this.name,
    required this.icon,
    required this.description,
  });
}

class Section {
  final String title;
  final String content;
  final String buttonText;
  final String link;
  final IconData icon;
  final List<Subservice> subservices;
  bool isExpanded;

  Section({
    required this.title,
    required this.content,
    required this.buttonText,
    required this.link,
    required this.icon,
    this.isExpanded = false,
    this.subservices = const [],
  });
}

final List<Section> sections = [
  Section(
    title: 'Kidney Care',
    content:
        'Comprehensive care for all stages of kidney disease, from early diagnosis to advanced treatment options.',
    buttonText: 'Learn More',
    link:
        'https://www.thenephrologygroupinc.com/Services/Chronic-Kidney-Disease',
    icon: Icons.local_hospital, // Example icon
    isExpanded: true,
    subservices: [
      Subservice(
          name: 'Chronic Kidney Disease',
          icon: Icons.health_and_safety,
          description:
              'Managing CKD to prevent complications like hypertension and anemia.'),
      Subservice(
          name: 'End-Stage Renal Disease',
          icon: Icons.healing,
          description:
              'Offering dialysis and transplant management to support advanced kidney disease.'),
      Subservice(
          name: 'Kidney Stones',
          icon: Icons.grain,
          description:
              'Diagnosis and treatment for kidney stones with minimally invasive techniques.'),
      Subservice(
          name: 'Kidney Transplant',
          icon: Icons.autorenew,
          description:
              'Coordinating with top transplant centers for comprehensive pre and post-transplant care.'),
    ],
  ),
  Section(
    title: 'Vascular Health',
    content:
        'Specialized vascular care to ensure optimal blood flow and access for dialysis.',
    buttonText: 'Learn More',
    link: 'https://www.thenephrologygroupinc.com/Services/Vascular-Access',
    icon: Icons.favorite, // Example icon
    subservices: [
      Subservice(
          name: 'Vascular Disease Overview',
          icon: Icons.description,
          description:
              'Managing conditions affecting blood circulation to improve dialysis outcomes.'),
      Subservice(
          name: 'Vascular Access',
          icon: Icons.waves,
          description:
              'Creating and maintaining access points for hemodialysis.'),
      Subservice(
          name: 'Vascular Procedures',
          icon: Icons.build,
          description: 'Offering angioplasty, stenting, and other procedures.'),
      Subservice(
          name: 'Hypertension Management',
          icon: Icons.monitor_heart,
          description:
              'Certified care to manage high blood pressure, a leading cause of kidney disease.'),
      Subservice(
          name: 'Peripheral Artery Disease Program',
          icon: Icons.directions_walk,
          description:
              'Promoting healthier lifestyles to manage artery disease.'),
    ],
  ),
  Section(
    title: 'Dialysis Services',
    content:
        'In-clinic and home-based dialysis options tailored to suit your lifestyle.',
    buttonText: 'Learn More',
    link: 'https://www.thenephrologygroupinc.com/Services/Dialysis-Center',
    icon: Icons.local_pharmacy, // Example icon
    subservices: [
      Subservice(
          name: 'Dialysis Centers',
          icon: Icons.local_hospital,
          description:
              'Providing in-clinic hemodialysis and peritoneal dialysis options.'),
      Subservice(
          name: 'Home Dialysis Program',
          icon: Icons.home,
          description:
              'Enabling flexible and convenient home-based dialysis treatments.'),
      Subservice(
          name: 'Dialysis Options Education',
          icon: Icons.menu_book,
          description:
              'Guiding patients in choosing the right dialysis treatment.'),
    ],
  ),
  Section(
    title: 'Clinical Services',
    content:
        'Essential diagnostic and clinical support services to enhance kidney care.',
    buttonText: 'Learn More',
    link: 'https://www.thenephrologygroupinc.com/Services/Laboratory',
    icon: Icons.medical_services, // Example icon
    subservices: [
      Subservice(
          name: 'Laboratory',
          icon: Icons.science,
          description: 'Onsite lab services for timely and accurate tests.'),
      Subservice(
          name: 'Ultrasound',
          icon: Icons.visibility,
          description:
              'Advanced imaging for evaluating kidney and urinary health.'),
      Subservice(
          name: 'Anemia Management Clinic',
          icon: Icons.bloodtype,
          description:
              'Comprehensive care for managing anemia related to kidney disease.'),
      Subservice(
          name: 'Dietary Services',
          icon: Icons.restaurant,
          description: 'Customized nutrition plans to support kidney health.'),
    ],
  ),
];
