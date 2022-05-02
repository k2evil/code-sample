import 'package:digisina/features/home/domain/entity/home_page_parts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OptionButton extends StatelessWidget {
  const OptionButton({Key? key, this.option, this.isLoading: false, this.onTap})
      : super(key: key);

  final HomePageOption? option;
  final bool isLoading;
  final void Function(HomePageOption)? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !isLoading && onTap != null && option!.enabled
          ? () => onTap!(option!)
          : null,
      child: Container(
        foregroundDecoration: !(option?.enabled ?? true)
            ? BoxDecoration(
                color: Colors.grey,
                backgroundBlendMode: BlendMode.saturation,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              )
            : null,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor,
                blurRadius: 16,
                offset: Offset(0.0, 4.0),
                spreadRadius: 0.5,
              ),
            ]),
        child: !isLoading
            ? Center(
                child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.network(
                    option?.iconUrl ?? "",
                    fit: BoxFit.cover,
                    width: 30,
                    height: 30,
                    placeholderBuilder: (_) => SvgPicture.asset(
                      "assets/logo.svg",
                      width: 30,
                      height: 30,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    option?.title ?? "",
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ))
            : Container(),
      ),
    );
  }
}
