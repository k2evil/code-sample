import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'countdown_timer_controller.dart';
import 'current_remaining_time.dart';

typedef CountdownTimerWidgetBuilder = Widget Function(
    BuildContext context, CurrentRemainingTime? time);

/// A Countdown.
class CountdownTimer extends StatefulWidget {
  ///Widget displayed after the countdown
  final Widget endWidget;

  ///Used to customize the countdown style widget
  final CountdownTimerWidgetBuilder? widgetBuilder;

  ///Countdown controller, can end the countdown event early
  final CountdownTimerController? controller;

  ///Countdown text style
  final TextStyle? textStyle;

  ///Event called after the countdown ends
  final VoidCallback? onEnd;

  ///The end time of the countdown.
  final int? endTime;

  CountdownTimer({
    Key? key,
    this.endWidget = const Center(
      child: Text('The current time has expired'),
    ),
    this.widgetBuilder,
    this.controller,
    this.textStyle,
    this.endTime,
    this.onEnd,
  })  : assert(endTime != null || controller != null),
        super(key: key);

  @override
  _CountDownState createState() => _CountDownState();
}

class _CountDownState extends State<CountdownTimer> {
  late CountdownTimerController controller;

  CurrentRemainingTime? get currentRemainingTime =>
      controller.currentRemainingTime;

  Widget get endWidget => widget.endWidget;

  CountdownTimerWidgetBuilder get widgetBuilder =>
      widget.widgetBuilder ?? builderCountdownTimer;

  TextStyle? get textStyle => widget.textStyle;

  @override
  void initState() {
    super.initState();
    initController();
  }

  ///Generate countdown controller.
  initController() {
    controller = widget.controller ??
        CountdownTimerController(endTime: widget.endTime!, onEnd: widget.onEnd);
    if (controller.isRunning == false) {
      controller.start();
    }
    controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void didUpdateWidget(CountdownTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.endTime != widget.endTime ||
        widget.controller != oldWidget.controller) {
      controller.dispose();
      initController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widgetBuilder(context, currentRemainingTime);
  }

  Widget builderCountdownTimer(
      BuildContext context, CurrentRemainingTime? time) {
    if (time == null) {
      return endWidget;
    }

    List<Widget> countdownWidget = [];
    if (time.days != null) {
      countdownWidget.add(_countdownScope(time.days!, 'روز'));
      countdownWidget.add(_countdownScope(time.hours!, 'ساعت'));
      countdownWidget.add(_countdownScope(time.min!, 'دقیقه'));
    } else {
      countdownWidget.add(_countdownScope(time.hours!, 'ساعت'));
      countdownWidget.add(_countdownScope(time.min!, 'دقیقه'));
      countdownWidget.add(_countdownScope(time.sec!, 'ثانیه'));
    }

    // return Text(
    //   '$value${_padZero(time.hours)}  ساعت  ${_padZero(time.min)}  دقیقه',
    //   style: textStyle,
    //   textDirection: TextDirection.rtl,
    //   textAlign: TextAlign.end,
    // );

    return Row(children: countdownWidget);
  }

  Widget _countdownScope(int value, String title) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: AspectRatio(
        aspectRatio: 1 / 1.6,
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: LayoutBuilder(builder: (context, constraints) {
                var maxVal = max(constraints.maxWidth, constraints.maxHeight);
                return SizedBox(
                  height: maxVal,
                  width: maxVal,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: textStyle!.color!.withOpacity(.2),
                        ),
                        borderRadius:
                            BorderRadius.all(Radius.circular(maxVal / 2))),
                    child: Padding(
                      padding: const EdgeInsets.all(1),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          '${_padZero(value)}',
                          style: textStyle,
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            //Container(height: 1, color: Colors.grey),
            Expanded(
              flex: 4,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Center(
                  child: Text(
                    title,
                    style: textStyle!
                        .copyWith(fontSize: textStyle!.fontSize! * .6),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String _padZero(int? number) => (number ?? 0).toString().padLeft(2, '0');
}
