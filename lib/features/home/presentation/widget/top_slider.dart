import 'package:carousel_slider/carousel_slider.dart';
import 'package:digisina/features/home/domain/entity/home_page_parts.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeTopSlider extends StatefulWidget {
  const HomeTopSlider({
    Key? key,
    this.isLoading: false,
    this.cornerRadius: 16.0,
    this.slides: const [],
    this.aspectRatio: 16 / 9,
  }) : super(key: key);

  final bool isLoading;
  final double cornerRadius;
  final List<HomePageSlide>? slides;
  final double aspectRatio;

  @override
  _HomeTopSliderState createState() => _HomeTopSliderState();
}

class _HomeTopSliderState extends State<HomeTopSlider> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return widget.isLoading
        ? AspectRatio(
            aspectRatio: widget.aspectRatio,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius:
                    BorderRadius.all(Radius.circular(widget.cornerRadius)),
              ),
            ),
          )
        : Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CarouselSlider(
                items: widget.slides
                    ?.map<Widget>(
                      (e) => ClipRRect(
                        borderRadius: BorderRadius.all(
                            Radius.circular(widget.cornerRadius)),
                        child: FadeInImage.assetNetwork(
                          image: e.imageUrl,
                          placeholder: "assets/place_holder.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                    disableCenter: true,
                    aspectRatio: widget.aspectRatio,
                    viewportFraction: 1.0,
                    autoPlay: true,
                    autoPlayCurve: Curves.easeOutExpo,
                    onPageChanged: (index, _) {
                      setState(() {
                        _index = index;
                      });
                    }),
              ),
              DotsIndicator(
                position: _index.toDouble(),
                dotsCount: widget.slides?.length ?? 0,
                decorator: DotsDecorator(
                    color: Colors.white,
                    activeColor: Colors.white,
                    size: Size.square(5.0),
                    activeSize: Size.square(10.0),
                    spacing:
                        EdgeInsets.symmetric(horizontal: 3, vertical: 8.0)),
              ),
            ],
          );
  }
}
