import 'package:flutter/material.dart';
import 'package:nephrology_app/shared/color.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  Future<void> _launchPhone(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch $phoneUri';
    }
  }

  Future<void> _launchEmail(String emailAddress) async {
    final Uri emailUri = Uri(scheme: 'mailto', path: emailAddress);
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not launch $emailUri';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
          ),
        ),
        title: const Text(
          "Contact Us",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      backgroundColor: bgColor,
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        children: [
          Image.asset(
            "assets/background.jpg",
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
          const SizedBox(height: 20),
          const Text(
            "Discuss your treatment options, plan a visit or make an appointment with us.",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          _buildContactButton(
            icon: Icons.phone,
            label: "Call: 559-228-6600",
            color: Colors.blueAccent,
            onTap: () => _launchPhone('+1-559-228-6600'),
          ),
          const SizedBox(height: 20),
          _buildContactButton(
            icon: Icons.email,
            label: "Email Us",
            color: Colors.green,
            onTap: () => _launchEmail('info@thenephrologygroupinc.com'),
          ),
          const SizedBox(height: 20),
          _buildLocationCard(
            title: "Fresno Office Location",
            address: "568 E. Herndon Ave. Suite 201\nFresno, California 93720",
            phoneNumber: "559-228-6600",
          ),
          const SizedBox(height: 20),
          _buildHoursCard(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildContactButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationCard({
    required String title,
    required String address,
    required String phoneNumber,
  }) {
    return GestureDetector(
      onTap: () => _launchMaps(address),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(3, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              address,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Phone: $phoneNumber",
                  style: const TextStyle(fontSize: 16),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.directions,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHoursCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Office Hours",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            "Monday - Friday",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 5),
          Text(
            "8:30 am - 5:00 pm",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
