import 'package:flutter/material.dart';

class FlutterRoundedButtonAction extends StatelessWidget {
  final String? textButtonNegative;
  final String? textButtonPositive;
  final String? textActionButton;
  final VoidCallback? onTapButtonNegative; // Default is "Cancel" button.
  final VoidCallback? onTapButtonPositive; // Default is "OK" button.
  final VoidCallback?
      onTapButtonAction; // Default is "Action" button which will be on the left.
  final TextStyle? textStyleButtonAction;
  final TextStyle? textStyleButtonPositive;
  final TextStyle? textStyleButtonNegative;
  final MaterialLocalizations localizations;
  final double borderRadius;
  final EdgeInsets? paddingActionBar;
  final Color? background;

  const FlutterRoundedButtonAction(
      {Key? key,
      required this.localizations,
      this.textButtonNegative,
      this.textButtonPositive,
      this.textActionButton,
      this.onTapButtonAction,
      this.onTapButtonPositive,
      this.onTapButtonNegative,
      this.textStyleButtonPositive,
      this.textStyleButtonNegative,
      this.textStyleButtonAction,
      required this.borderRadius,
      this.paddingActionBar,
      this.background})
      : super(key: key);

  List<Widget> _buildActionsButton() {
    final Widget negativeButton = TextButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius!),
                side: BorderSide(color: Color(0xff1D5DCF)))),
      ),
      child: Text(
        textButtonNegative ?? localizations.cancelButtonLabel,
        style: textStyleButtonNegative,
      ),
      onPressed: onTapButtonNegative,
    );

    final Widget positiveButton = TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xff1D5DCF)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius!),
                side: BorderSide(color: Color(0xff1D5DCF)))),
      ),
      child: Text(
        textButtonPositive ?? localizations.okButtonLabel,
        style: textStyleButtonPositive,
      ),
      onPressed: onTapButtonPositive,
    );

    if (textActionButton != null) {
      final Widget leftButton = TextButton(
        child: Text(textActionButton!, style: textStyleButtonAction),
        onPressed: onTapButtonAction,
      );
      return [
        leftButton,
        Row(children: <Widget>[negativeButton, positiveButton])
      ];
    }

    return [
      Expanded(
          child: Padding(
              padding: EdgeInsets.only(left: 20), child: negativeButton)),
      SizedBox(width: 11),
      Expanded(
          child: Padding(
              padding: EdgeInsets.only(right: 20), child: positiveButton))
    ];
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      padding: paddingActionBar,
      decoration: BoxDecoration(
          color: background,
          borderRadius: orientation == Orientation.landscape
              ? BorderRadius.only(bottomRight: Radius.circular(borderRadius))
              : BorderRadius.vertical(bottom: Radius.circular(borderRadius))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _buildActionsButton(),
      ),
    );
  }
}
