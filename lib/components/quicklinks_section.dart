import 'package:flutter/material.dart';
import 'package:nephrology_app/shared/color.dart';
import 'package:nephrology_app/utilities/utils.dart';

class QuickLinksSection extends StatefulWidget {
  const QuickLinksSection({super.key});

  @override
  State<QuickLinksSection> createState() => _QuickLinksSectionState();
}

class _QuickLinksSectionState extends State<QuickLinksSection>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      alignment: Alignment.center,
      width: double.infinity,
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
                child: const Text("Quick",
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
                "Links",
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
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 columns
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 1,
            ),
            itemCount: cardItems.length,
            itemBuilder: (context, index) {
              return CustomCard(cardItem: cardItems[index]);
            },
          ),
        ],
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final CardItem cardItem;

  const CustomCard({super.key, required this.cardItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: lightGrey, // You can customize this
        borderRadius: BorderRadius.circular(26.0),
      ),
      child: InkWell(
        onTap: cardItem.onPressed,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Center(
              child: CircleAvatar(
                radius: 36.0,
                backgroundColor: Colors.white, // Customize background
                child: Icon(
                  cardItem.icon,
                  color: primaryColor, // Customize icon color
                  size: 40.0,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              cardItem.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: "Poppins",
                fontSize: 12.0,
                fontWeight: FontWeight.normal,
                color: darkGrey, // Customize text color
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class CardItem {
  final String title;
  final IconData icon;
  final VoidCallback onPressed;

  CardItem({
    required this.title,
    required this.icon,
    required this.onPressed,
  });
}

List<CardItem> cardItems = [
  CardItem(
    title: 'Patient Portal',
    icon: Icons.medical_services, // Represents healthcare and patient services
    onPressed: () {
      Utilities.urlLauncher(Uri.parse(
          "https://www.myhealthrecord.com/Portal/SSO"));
    },
  ),
  CardItem(
    title: 'Make a Payment',
    icon: Icons.credit_card, // Represents financial transactions or payments
    onPressed: () {
      Utilities.urlLauncher(
          Uri(scheme: 'tel', path: '+1-559-228-6600'));
    },
  ),
  CardItem(
    title: 'CME',
    icon: Icons.menu_book, // Represents educational resources or learning
    onPressed: () {
      Utilities.urlLauncher(Uri.parse(
          "https://www.thenephrologygroupinc.com/Resources/CME"));
    },
  ),
  CardItem(
    title: 'Our Kidney Foundation',
    icon: Icons.volunteer_activism, // Represents charity, donations, or care
    onPressed: () {
      Utilities.urlLauncher(Uri.parse(
          "https://fresnonephrologykidneyfoundation.org"));
    },
  ),
];
