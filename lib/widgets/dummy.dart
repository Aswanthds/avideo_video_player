import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_app/constants.dart';

class CustomVideoProgressIndicator extends StatefulWidget {
  const CustomVideoProgressIndicator(
    this.controller, {
    super.key,
    required this.allowScrubbing,
    required this.current,
    required this.duration,
  });

  final VideoPlayerController controller;
  final bool allowScrubbing;
  final double current, duration;

  @override
  State<CustomVideoProgressIndicator> createState() =>
      _CustomVideoProgressIndicatorState();
}

class _CustomVideoProgressIndicatorState
    extends State<CustomVideoProgressIndicator> {
  _CustomVideoProgressIndicatorState() {
    listener = () {
      if (!mounted) {
        return;
      }
      setState(() {});
    };
  }

  late VoidCallback listener;

  VideoPlayerController get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    controller.addListener(listener);
  }

  @override
  void deactivate() {
    controller.removeListener(listener);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    Widget progressIndicator;

    if (controller.value.isInitialized) {
      final int duration = controller.value.duration.inMilliseconds;
      final int position = controller.value.position.inMilliseconds;

      int maxBuffering = 0;
      for (final DurationRange range in controller.value.buffered) {
        final int end = range.end.inMilliseconds;
        if (end > maxBuffering) {
          maxBuffering = end;
        }
      }

      double sliderValue = duration > 0 ? (position / duration) : 0.0;

      progressIndicator = Column(
        children: [
          Slider(
            onChanged: ((value) {
              final seekPosition = (value * duration).toInt();
              controller.seekTo(Duration(milliseconds: seekPosition));
            }),
            value: sliderValue,
            activeColor: kColorIndigo,
            inactiveColor: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDuration(widget.controller.value.position),
                  style: const TextStyle(color: kColorWhite),
                ),
                Text(
                  _formatDuration(widget.controller.value.duration),
                  style: const TextStyle(
                      color: kColorWhite, fontFamily: 'OpenSans'),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      progressIndicator = Slider(
        onChanged: ((value) {}),
        value: 0.0,
        activeColor: kColorIndigo,
        inactiveColor: kcolorblack54,
      );
    }

    final Widget paddedProgressIndicator = Padding(
      padding: const EdgeInsets.only(top: 0),
      child: progressIndicator,
    );

    if (widget.allowScrubbing) {
      return VideoScrubber(
        controller: controller,
        child: paddedProgressIndicator,
      );
    } else {
      return paddedProgressIndicator;
    }
  }

  String _formatDuration(Duration duration) {
    String formattedHours = '';
    String formattedMinutes = '';
    String formattedSeconds = '';

    try {
      int hours = duration.inHours;
      int minutes = duration.inMinutes.remainder(60);
      int seconds = duration.inSeconds.remainder(60);

      if (hours > 0) {
        formattedHours = '${hours.toString().padLeft(2, '0')}:';
      }

      formattedMinutes = minutes.toString().padLeft(2, '0');
      formattedSeconds = seconds.toString().padLeft(2, '0');
    } catch (e) {
      debugPrint('Exception $e');
    }

    return '$formattedHours$formattedMinutes:$formattedSeconds';
  }
}
