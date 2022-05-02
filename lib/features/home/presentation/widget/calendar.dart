import 'package:digisina/cores/appIcons/app_icons.dart';
import 'package:digisina/cores/widget/countdown/flutter_countdown_timer.dart';
import 'package:digisina/cores/widget/textAnimate/animated_text.dart';
import 'package:digisina/cores/widget/textAnimate/fade.dart';
import 'package:digisina/features/home/domain/entity/home_page_parts.dart';
import 'package:flutter/material.dart';

class CalendarEvent extends StatelessWidget {
  const CalendarEvent({
    Key? key,
    this.calendar,
    this.isLoading: false,
    this.height: 80,
    this.cornerRadius: 16,
  }) : super(key: key);

  final List<HomePageCalendar?>? calendar;
  final bool isLoading;
  final double height;
  final double cornerRadius;

  @override
  Widget build(BuildContext context) {
    return !isLoading
        ? AspectRatio(
            aspectRatio: 328 / 95,
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(cornerRadius)),
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).shadowColor,
                      blurRadius: 16,
                      offset: Offset(0.0, 6.0),
                      spreadRadius: 0),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 6,
                    child: Container(
                      color: Theme.of(context).primaryColorLight,
                      padding: EdgeInsets.only(top: 2.0),
                      child: Row(
                        children: [
                          SizedBox(width: 15.0),
                          Icon(AppIcons.calendar,
                              color: Theme.of(context)
                                  .accentTextTheme
                                  .headline5
                                  ?.color),
                          SizedBox(width: 8.0),
                          DefaultTextStyle(
                            style: Theme.of(context).accentTextTheme.headline5!,
                            child: AnimatedTextKit(
                              repeatForever: true,
                              pause: Duration(seconds: 5),
                              animatedTexts: List<FadeAnimatedText>.generate(
                                  calendar?.length ?? 0,
                                  (index) => FadeAnimatedText(
                                        calendar!.elementAt(index)?.dayString ??
                                            "",
                                      )),
                              onTap: () {
                                print("Tap Event");
                              },
                            ),
                          ),
                          Expanded(
                              child: DefaultTextStyle(
                            textAlign: TextAlign.start,
                            style: Theme.of(context).accentTextTheme.headline6!,
                            child: AnimatedTextKit(
                              repeatForever: true,
                              pause: Duration(seconds: 5),
                              animatedTexts: List<FadeAnimatedText>.generate(
                                calendar?.length ?? 0,
                                (index) => FadeAnimatedText(
                                  "",
                                  widget:
                                      (calendar!.elementAt(index)?.remainings ??
                                                  0) >
                                              0
                                          ? Directionality(
                                              textDirection: TextDirection.ltr,
                                              child: CountdownTimer(
                                                endWidget: Container(),
                                                textStyle: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors
                                                        .greenAccent.shade100),
                                                endTime: DateTime.now()
                                                        .millisecondsSinceEpoch +
                                                    calendar!
                                                            .elementAt(index)!
                                                            .remainings *
                                                        1000,
                                              ),
                                            )
                                          : Container(),
                                ),
                              ),
                            ),
                          )),
                          SizedBox(width: 3.0),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      width: double.infinity,
                      color: Theme.of(context).cardColor,
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Center(
                          child: DefaultTextStyle(
                        style: Theme.of(context).textTheme.bodyText1!,
                        child: AnimatedTextKit(
                          repeatForever: true,
                          pause: Duration(seconds: 5),
                          animatedTexts: List<FadeAnimatedText>.generate(
                              calendar?.length ?? 0,
                              (index) => FadeAnimatedText(
                                    calendar!.elementAt(index)?.dayMessage ??
                                        "",
                                    textAlign: TextAlign.center,
                                  )),
                          onTap: () {
                            print("Tap Event");
                          },
                        ),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container(
            height: height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(cornerRadius)),
                color: Colors.black),
          );
  }
}
