import 'package:flutter/material.dart';
import 'package:nephrology_app/pages/load_pdf_page.dart';
import 'package:nephrology_app/shared/color.dart';

class OnlineFormsPage extends StatelessWidget {
  const OnlineFormsPage({super.key});

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
            const Icon(Icons.picture_as_pdf, color: Colors.blueAccent),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(fontSize: 16, color: Colors.blueAccent),
              ),
            ),
          ],
        ),
      ),
    );
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
          "Online Forms",
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
          _buildSectionTitle("Patient Forms"),
          const Text(
            "(Please click on the links to download a PDF form)",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
          ),
          const SizedBox(height: 10),
          _buildFormLink(context, "Patient Information", "https://www.thenephrologygroupinc.com/Portals/0/Online%20Forms/Forms%201-7-2019/PatientInfo2019.pdf"),
          _buildFormLink(context, "Medical History", "https://www.thenephrologygroupinc.com/Portals/0/medical-history.pdf"),
          _buildFormLink(context, "Patient Satisfaction Survey", "https://www.thenephrologygroupinc.com/Portals/0/TNG%20Patient%20Survey%202023.pdf"),
          const SizedBox(height: 20),
          _buildSectionTitle("Physicians Forms"),
          const Text(
            "(Please click on the links to download a PDF form)",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
          ),
          const SizedBox(height: 10),
          _buildFormLink(context, "New Patient Referral Form", "https://www.thenephrologygroupinc.com/Portals/0/Online%20Forms/TNG%20NP%20referral%20form%208.23.pdf"),
          _buildFormLink(context, "Endocrinology Referral Form", "https://www.thenephrologygroupinc.com/Portals/0/Online%20Forms/Endocrine/Endocrine_Referral_Sheet_Editable.pdf"),
        ],
      ),
    );
  }
}
