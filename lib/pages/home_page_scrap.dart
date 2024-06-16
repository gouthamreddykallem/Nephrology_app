import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:nephrology_app/components/floating_buttons.dart';

final List<String> imgList = [
  // 'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  // 'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  // 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  // 'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  // 'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'assets/background.jpg'
];

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          ImageSection(
            image: 'assets/background.jpg',
          ),
          ButtonSection(),
          TextSection(
              description: 'Welcome to The Nephrology Group, Inc. '
                  'If you have an upcoming appointment or need to be scheduled urgently, questions or any concerns, contact us at 559-228-6600.'
                  'The Nephrology Group, Inc. (TNG) is Central California’s largest Nephrology Practice. Since founded in 1975, our physicians are committed to providing quality care to patients with acute kidney failure, hypertension, chronic kidney disease, polycystic kidney disease, hemodialysis, peritoneal dialysis and other kidney related illnesses. Our physicians are available 24/7/365 for urgent consultations and referrals, hospital or in clinic. In addition to our multiple office locations, we have an Ambulatory Surgery Center which offer services to our pre-dialysis and dialysis patients. '),
          // MapBody(),
        ],
      ),
    );
  }
}

class ImageSection extends StatelessWidget {
  const ImageSection({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    // #docregion image-asset
    return ValueListenableBuilder(
      builder: (context, value, g) {
        return const SlidingImage();
      },
      valueListenable: ValueNotifier(2),
    );

    // Image.asset(
    //   image,
    //   width: 600,
    //   height: 240,
    //   fit: BoxFit.cover,
    // );
    // #enddocregion image-asset
  }
}

class SlidingImage extends StatelessWidget {
  const SlidingImage({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
      ),
      items: imageSliders,
    );
  }
}

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          margin: const EdgeInsets.all(5.0),
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: <Widget>[
                  Image.asset(item, fit: BoxFit.cover, width: 1000.0),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(200, 0, 0, 0),
                            Color.fromARGB(0, 0, 0, 0)
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: const Text(
                        'The Nephrology Group',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ))
    .toList();

class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(
          fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
      iconColor: Colors.blue,
      backgroundColor: Colors.blue,
    );
    // final Color color = Theme.of(context).primaryColor;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      // mainAxisSpacing: 8.0,
      children: [
        const SizedBox(height: 5), // Spacing between buttons
        ElevatedButton(
          style: style,
          // Button 1 style and properties
          onPressed: () {
            FloatingButtons.urlLauncher(
                Uri.parse('https://www.myhealthrecord.com/Portal/SSO'));
          },
          child: const Text('PATIENT PORTAL'),
        ),
        const SizedBox(height: 5), // Spacing between buttons
        ElevatedButton(
          style: style,
          // Button 2 style and properties
          onPressed: () {
            FloatingButtons.urlLauncher(Uri.parse(
                'https://www.thenephrologygroupinc.com/Portals/0/Online%20Forms/Forms%202-12-2018/NewPatientRF.pdf?ver=2018-02-16-140849-517'));
          },
          child: const Text('REFER A PATIENT'),
        ),
        // const SizedBox(height: 16), // Spacing between buttons
      ],
    );
  }
}

class TextSection extends StatelessWidget {
  const TextSection({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Text(
        description,
        softWrap: true,
      ),
    );
  }
}
