import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  final Color backgroundColor;
  final double width;
  final List<Color> colors;
  const CustomSlider(
      {Key key,
      this.backgroundColor,
      @required this.width,
      @required this.colors})
      : super(key: key);
  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  final GlobalKey containerKey = GlobalKey();
  double sliderPos = 0.0, startDx, endDx;
  Color sliderBgColor;

  @override
  void initState() {
    super.initState();
    endDx = widget.width;
    sliderBgColor = widget.colors[0];

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      startDx = _getContainerOffset() + 20.0;
      setState(() {
        endDx = startDx + widget.width;
      });
    });
    // widget.colors.add(widget.backgroundColor);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      width: widget.width,
      alignment: Alignment.center,
      child: Stack(
        // alignment: Alignment.center,
        children: [
          Container(
            key: containerKey,
            margin: const EdgeInsets.only(bottom: 6.0, top: 5),
            height: 26.0,
            decoration: BoxDecoration(
                color: widget.backgroundColor,
                // gradient: LinearGradient(colors: widget.colors, stops: stops),
                borderRadius: const BorderRadius.all(Radius.circular(20.0))),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            margin: EdgeInsets.only(
                bottom: 6.0, top: 5, right: endDx - 75 - sliderPos),
            height: 26.0,
            decoration: BoxDecoration(
                color: sliderBgColor,
                // gradient: LinearGradient(colors: widget.colors, stops: stops),
                borderRadius: const BorderRadius.all(Radius.circular(20.0))),
          ),
          GestureDetector(
            onHorizontalDragUpdate: onHorizontalDrag,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              height: 30.0,
              width: 30.0,
              margin: EdgeInsets.only(left: sliderPos, top: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  onHorizontalDrag(DragUpdateDetails details) {
    double dx = details.globalPosition.dx;

    if (dx > startDx && dx < endDx - 30) {
      final double a = (dx / (startDx + widget.width) * (widget.colors.length));
      sliderBgColor = widget.colors[a.truncate()];

      sliderBgColor = sliderBgColor.withAlpha(_getDecimalPart(a));

      // print(a);
      this.setState(() {
        sliderPos = dx - startDx;
      });
    }
  }

  double _getContainerOffset() {
    RenderBox box = containerKey.currentContext.findRenderObject();
    return box.localToGlobal(Offset.zero).dx;
  }

  int _getDecimalPart(double num) {
    int decimal = int.tryParse(num.toString().split(".")[1].substring(0, 2));
    int oldRange = 99 - 0;
    int newRange = 255 - 170;
    int newValue = ((((decimal - 0) * newRange) / oldRange) + 170).truncate();
    // print("$decimal : $newValue");
    return newValue;
  }
}
