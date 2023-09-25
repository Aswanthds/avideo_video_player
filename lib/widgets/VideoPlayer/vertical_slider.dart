import 'package:flutter/material.dart';

class VerticalSlider extends StatefulWidget {
  final double value;
  final ValueChanged<double> onChanged;

  const VerticalSlider(
      {super.key, required this.value, required this.onChanged});

  @override
  State<VerticalSlider> createState() => _VerticalSliderState();
}

class _VerticalSliderState extends State<VerticalSlider> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Wrap(
        spacing: 0,
        runSpacing: 0,
        alignment: WrapAlignment.start,
        runAlignment: WrapAlignment.start,
        direction: Axis.horizontal,
        children: [
         
          Slider(
            value: widget.value,
            onChanged: widget.onChanged,
            min: 0.0,
            max: 1.0,
            divisions: 20,
            label: '${(widget.value * 20).round()}',
          ),
        ],
      ),
    );
  }
}
