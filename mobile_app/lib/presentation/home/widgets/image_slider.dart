import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/configs/assets/app_image.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ImageSliderState();
  }
}

class _ImageSliderState extends State<ImageSlider> {
  final List<String> images = [
    'https://theme.hstatic.net/200000902933/1001263601/14/slideshow_1.jpg?v=275',
    'https://theme.hstatic.net/200000902933/1001263601/14/slideshow_2.jpg?v=275',
    'https://theme.hstatic.net/200000902933/1001263601/14/slideshow_3.jpg?v=275',
    'https://theme.hstatic.net/200000902933/1001263601/14/slideshow_4.jpg?v=275',
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (var imageUrl in images) {
        precacheImage(NetworkImage(imageUrl), context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: images.length,
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
      ),
      itemBuilder: (context, index, realIdx) {
        return GestureDetector(
          onTap: () {},
          child: Center(
              child: Image.network(images[index],
                  fit: BoxFit.fill, height: 200.h, width: 800.w, errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Image.asset(AppImages.imageNotFound, height: 150.h, width: 700.w),
                    );
                  },)),
        );
      },
    );
  }
}
