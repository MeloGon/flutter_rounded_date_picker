import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/src/era_mode.dart';
import 'package:flutter_rounded_date_picker/src/material_rounded_date_picker_style.dart';

class FlutterRoundedDatePickerHeader extends StatelessWidget {
  const FlutterRoundedDatePickerHeader(
      {Key? key,
      this.selectedDate,
      required this.mode,
      required this.onModeChanged,
      required this.orientation,
      required this.era,
      required this.borderRadius,
      this.imageHeader,
      this.description = "",
      this.fontFamily,
      this.asset,
      this.style,
      this.title = 'title'})
      : super(key: key);

  final DateTime? selectedDate;
  final DatePickerMode mode;
  final ValueChanged<DatePickerMode> onModeChanged;
  final Orientation orientation;
  final MaterialRoundedDatePickerStyle? style;
  final String? title;
  final String? asset;

  /// Era custom
  final EraMode era;

  /// Border
  final double borderRadius;

  ///  Header
  final ImageProvider? imageHeader;

  /// Header description
  final String description;

  /// Font
  final String? fontFamily;

  void _handleChangeMode(DatePickerMode value) {
    if (value != mode) onModeChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    final ThemeData themeData = Theme.of(context);
    final TextTheme headerTextTheme = themeData.primaryTextTheme;
    Color? dayColor;
    Color? yearColor;
    switch (themeData.primaryColorBrightness) {
      case Brightness.light:
        dayColor = mode == DatePickerMode.day ? Colors.black87 : Colors.black54;
        yearColor =
            mode == DatePickerMode.year ? Colors.black87 : Colors.black54;
        break;
      case Brightness.dark:
        dayColor = mode == DatePickerMode.day ? Colors.white : Colors.white70;
        yearColor = mode == DatePickerMode.year ? Colors.white : Colors.white70;
        break;
    }

    if (style?.textStyleDayButton?.color != null) {
      style?.textStyleDayButton =
          style?.textStyleDayButton?.copyWith(color: dayColor);
    }

    if (style?.textStyleDayButton?.fontFamily != null) {
      style?.textStyleDayButton =
          style?.textStyleDayButton?.copyWith(fontFamily: fontFamily);
    }

    final TextStyle dayStyle = style?.textStyleDayButton ??
        headerTextTheme.headline4!
            .copyWith(color: dayColor, fontFamily: fontFamily);
    final TextStyle yearStyle = style?.textStyleYearButton ??
        headerTextTheme.subtitle1!
            .copyWith(color: yearColor, fontFamily: fontFamily);

    Color? backgroundColor;
    if (style?.backgroundHeader != null) {
      backgroundColor = style?.backgroundHeader;
    } else {
      switch (themeData.brightness) {
        case Brightness.dark:
          backgroundColor = themeData.backgroundColor;
          break;
        case Brightness.light:
          backgroundColor = themeData.primaryColor;
          break;
      }
    }

    EdgeInsets padding;
    MainAxisAlignment mainAxisAlignment;
    switch (orientation) {
      case Orientation.landscape:
        padding = style?.paddingDateYearHeader ?? EdgeInsets.all(8.0);
        mainAxisAlignment = MainAxisAlignment.start;
        break;
      case Orientation.portrait:
      default:
        padding = style?.paddingDateYearHeader ?? EdgeInsets.all(16.0);
        mainAxisAlignment = MainAxisAlignment.center;
        break;
    }

    final Widget yearButton = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.close,
              color: Color(0xff1D5DCF),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              asset == null ? Icon(Icons.date_range) : Image.asset(asset!),
              SizedBox(
                width: 9,
              ),
              Text(
                title!,
                style: yearStyle,
              ),
            ],
          )
        ],
      ),
    );

    BorderRadius borderRadiusData = BorderRadius.only(
      topLeft: Radius.circular(borderRadius),
      topRight: Radius.circular(borderRadius),
    );

    if (orientation == Orientation.landscape) {
      borderRadiusData = BorderRadius.only(
        topLeft: Radius.circular(borderRadius),
        bottomLeft: Radius.circular(borderRadius),
      );
    }

    return Container(
      decoration: BoxDecoration(
        image: imageHeader != null
            ? DecorationImage(image: imageHeader!, fit: BoxFit.cover)
            : null,
        color: backgroundColor,
        borderRadius: borderRadiusData,
      ),
      padding: padding,
      child: Column(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          yearButton,
          const SizedBox(height: 4.0),
          Visibility(
            visible: description.isNotEmpty,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                description,
                style: TextStyle(
                  color: yearColor,
                  fontSize: 12,
                  fontFamily: fontFamily,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _DateHeaderButton extends StatelessWidget {
  const _DateHeaderButton({
    Key? key,
    this.onTap,
    this.color,
    this.child,
  }) : super(key: key);

  final VoidCallback? onTap;
  final Color? color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Material(
      type: MaterialType.button,
      color: color,
      child: InkWell(
        borderRadius: kMaterialEdges[MaterialType.button],
        highlightColor: theme.highlightColor,
        splashColor: theme.splashColor,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: child,
        ),
      ),
    );
  }
}
