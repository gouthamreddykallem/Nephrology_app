import 'package:flutter/material.dart';
import 'package:nephrology_app/shared/color.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsSection extends StatefulWidget {
  const ContactUsSection({super.key});

  @override
  State<ContactUsSection> createState() => _ContactUsSectionState();
}

class _ContactUsSectionState extends State<ContactUsSection>
    with SingleTickerProviderStateMixin {
  void _toggleExpand(int index) {
    setState(() {
      for (int i = 0; i < officeLocations.length; i++) {
        if (i == index) {
          officeLocations[i].isExpanded =
              !officeLocations[i].isExpanded; // Toggle selected section
        } else {
          officeLocations[i].isExpanded = false; // Collapse other sections
        }
      }
    });
  }

  Future<void> _launchPhone(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch $phoneUri';
    }
  }

  Future<void> _launchMaps(String address) async {
    final Uri mapsUri = Uri(
      scheme: 'https',
      host: 'maps.google.com',
      queryParameters: {
        'q': address,
      },
    );
    if (await canLaunchUrl(mapsUri)) {
      await launchUrl(mapsUri);
    } else {
      throw 'Could not launch $mapsUri';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          left: 20.0, right: 20.0, top: 20.0, bottom: 16.0),
      alignment: Alignment.center,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
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
                  color: grey,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: const Text("Contact",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    )),
              ),
              const SizedBox(
                width: 4.0,
              ),
              const Text(
                "Us",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                  color: darkGrey,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16.0,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text("Our Locations",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  color: darkGrey,
                )),
          ),
          const SizedBox(
            height: 16.0,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: officeLocations.length,
            itemBuilder: (context, index) {
              final location = officeLocations[index];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: location.isExpanded ? grey : lightGrey,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          location.name,
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color:
                                location.isExpanded ? Colors.white : darkGrey,
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: location.isExpanded
                              ? primaryColorLight
                              : Colors.white,
                          child: IconButton(
                            onPressed: () => _toggleExpand(index),
                            icon: Icon(
                              location.isExpanded ? Icons.remove : Icons.add,
                              color:
                                  location.isExpanded ? Colors.white : darkGrey,
                            ),
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
                          const SizedBox(height: 10.0),
                          Text(
                            location.address,
                            style: const TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Text(
                            'Phone: ${location.phone}',
                            style: const TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          // Display the list of office hours
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: location.officeHours.map((officeHour) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2.0),
                                child: Text(
                                  '${officeHour.days}: ${officeHour.hours}',
                                  style: const TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () => _launchMaps(location.address),
                                icon: const Icon(Icons.directions,
                                    color: Colors.white),
                                label: const Text(
                                  'Directions',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14.0),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      primaryColorLight, // Customize as needed
                                  minimumSize: const Size(100,
                                      40), // Adjust button size if necessary
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              ElevatedButton.icon(
                                onPressed: () => _launchPhone(location.phone),
                                icon: const Icon(Icons.call,
                                    color: primaryColorLight),
                                label: const Text(
                                  'Call',
                                  style: TextStyle(
                                      color: primaryColorLight, fontSize: 14.0),
                                ),
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: primaryColorLight,
                                  backgroundColor:
                                      Colors.white, // Icon and text color
                                  minimumSize: const Size(100,
                                      40), // Adjust button size if necessary
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      crossFadeState: location.isExpanded
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

class OfficeLocation {
  final String name;
  final String address;
  final String phone;
  final List<OfficeHours> officeHours;
  bool isExpanded;

  OfficeLocation({
    required this.name,
    required this.address,
    required this.phone,
    required this.officeHours,
    this.isExpanded = false,
  });
}

class OfficeHours {
  final String days;
  final String hours;

  OfficeHours({
    required this.days,
    required this.hours,
  });
}

List<OfficeLocation> officeLocations = [
  OfficeLocation(
    name: 'Fresno',
    address: '568 E. Herndon Ave. Suite 201\nFresno, California 93720',
    phone: '559-228-6600',
    officeHours: [
      OfficeHours(days: 'Monday - Friday', hours: '8:30 am - 5:00 pm'),
    ],
  ),
  OfficeLocation(
    name: 'Sanger',
    address: '800 \'N\' Street\nSanger, California 93657',
    phone: '559-228-6600',
    officeHours: [
      OfficeHours(days: 'By Appointment', hours: ''),
      OfficeHours(days: 'Tuesday', hours: '9:30 am - 1:30 pm'),
      OfficeHours(days: 'Wednesday', hours: '12:30 pm - 4:30 pm'),
    ],
  ),
  OfficeLocation(
    name: 'Selma',
    address: '1205 Evergreen St.\nSelma, California 93720',
    phone: '559-228-6600',
    officeHours: [
      OfficeHours(days: 'By Appointment', hours: ''),
      OfficeHours(days: 'Monday', hours: '12:30 pm - 4:30 pm'),
      OfficeHours(days: 'Friday', hours: '9:30 am - 12:30 pm'),
    ],
  ),
  OfficeLocation(
    name: 'Visalia',
    address: '233 E Caldwell Ave\nVisalia, California 93277',
    phone: '559-228-6600',
    officeHours: [
      OfficeHours(days: 'Monday - Friday', hours: '8:30 am - 5:00 pm'),
    ],
  ),
  OfficeLocation(
    name: 'Hanford',
    address: '900 N Douty Suite B\nHanford, California 93230',
    phone: '559-228-6600',
    officeHours: [
      OfficeHours(
          days: 'Every Wednesday of the First and Third Week of the Month.',
          hours: '8:00 am - 12:00 pm'),
    ],
  ),
  OfficeLocation(
    name: 'Bakersfield',
    address: '3933 Coffee Rd Suite B\nBakersfield, California 93308',
    phone: '661-588-9999',
    officeHours: [
      OfficeHours(days: 'Monday - Friday', hours: '8:30 am - 5:00 pm'),
    ],
  ),
  OfficeLocation(
    name: 'Delano',
    address: '432 Lexington St Ste A\nDelano, California 93215',
    phone: '661-588-9999',
    officeHours: [
      OfficeHours(days: 'Monday - Friday', hours: '8:30 am - 5:00 pm'),
    ],
  ),
  OfficeLocation(
    name: 'Lake Isabella',
    address: '6621 Lake Isabella Rd.\nLake Isabella, California 93240',
    phone: '661-588-9999',
    officeHours: [
      OfficeHours(days: 'Monday - Friday', hours: '8:30 am - 5:00 pm'),
    ],
  ),
  OfficeLocation(
    name: 'Tehachapi',
    address: '20041 W Valley Blvd #4\nTehachapi, California 93561',
    phone: '661-588-9999',
    officeHours: [
      OfficeHours(days: 'Monday - Friday', hours: '8:30 am - 5:00 pm'),
    ],
  ),
  OfficeLocation(
    name: 'Merced',
    address: '1140 Olivewood Dr.\nMerced, California 95348',
    phone: '559-228-6600',
    officeHours: [
      OfficeHours(days: 'Monday - Friday', hours: '8:30 am - 5:00 pm'),
    ],
  ),
  OfficeLocation(
    name: 'Los Banos',
    address: '1451 West Pacheco Blvd. STE E\nLos Banos, California 93635',
    phone: '559-228-6600',
    officeHours: [
      OfficeHours(days: 'Wednesday', hours: '8:30 am - 5:00 pm'),
    ],
  ),
];
