import 'package:flutter/material.dart';
import 'package:nephrology_app/pages/online_forms_page.dart';
import 'package:nephrology_app/shared/color.dart';
import 'package:nephrology_app/utilities/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:nephrology_app/pages/load_pdf_page.dart';

class QuickLinks extends StatefulWidget {
  const QuickLinks({Key? key}) : super(key: key);

  @override
  State<QuickLinks> createState() => _QuickLinksState();
}

class _QuickLinksState extends State<QuickLinks> with SingleTickerProviderStateMixin {
  void _toggleExpand(int index) {
    setState(() {
      for (int i = 0; i < sections.length; i++) {
        if (i == index) {
          sections[i].isExpanded = !sections[i].isExpanded;
        } else {
          sections[i].isExpanded = false;
        }
      }
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

  void _handleItemTap(int index) {
    if (sections[index].isExpanded) {
      setState(() {
        sections[index].isExpanded = false;
      });
    } else {
      _toggleExpand(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 16.0),
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
              SizedBox(width: 6.0),
            ],
          ),
          const SizedBox(height: 16.0),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: sections.length,
            itemBuilder: (context, index) {
              final section = sections[index];
              return GestureDetector(
                onTap: () => _handleItemTap(index),
                child: Container(
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
                              const SizedBox(height: 10.0),
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
                        firstChild: Container(),
                        secondChild: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10.0),
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
                            if (section.title == "Online forms")
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildFormLink(context, "Patient Information", "https://www.thenephrologygroupinc.com/Portals/0/Online%20Forms/Forms%201-7-2019/PatientInfo2019.pdf"),
                                  _buildFormLink(context, "Medical History", "https://www.thenephrologygroupinc.com/Portals/0/medical-history.pdf"),
                                  _buildFormLink(context, "Patient Satisfaction Survey", "https://www.thenephrologygroupinc.com/Portals/0/TNG%20Patient%20Survey%202023.pdf"),
                                ],
                              ),
                            ElevatedButton(
                              onPressed: () {
                                if (section.title == "Make a Payment") {
                                  _launchPhone(section.link);
                                } else if (section.title == "Online forms") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const OnlineFormsPage(),
                                    ),
                                  );
                                } else {
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
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFormLink(BuildContext context, String label, String url) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return LoadPdfPage(
                url: url,
                title: label,
              );
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          children: [
            const Icon(Icons.picture_as_pdf, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          ],
        ),
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
    content: 'If you need assistance making a payment or have questions about your dues, please call us.',
    buttonText: 'Call us',
    link: '+1-559-228-6600',
    isExpanded: true,
    icon: Icons.info_outline,
  ),
  Section(
    title: 'Visit Patient Portal',
    content: 'Access your health records, manage appointments, or communicate with your care team.',
    buttonText: 'Visit Portal',
    link: 'https://www.myhealthrecord.com/Portal/SSO',
    isExpanded: false,
    icon: Icons.medical_services,
  ),
  Section(
    title: 'Online forms',
    content: 'Find all related forms below',
    buttonText: 'All Forms',
    link: 'https://www.thenephrologygroupinc.com/About-Us/Administration',
    isExpanded: false,
    icon: Icons.groups,
  ),
];