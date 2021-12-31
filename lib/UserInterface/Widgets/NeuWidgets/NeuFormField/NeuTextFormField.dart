import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ppl_app/UserInterface/Themes/AppColorScheme.dart';

class NeuTextFormField extends StatefulWidget {
  Function(String?)? onChange;
  Function(String?)? validator;
  Function()? onTap;
  FocusNode? focusNode;
  String? value;
  FontWeight labelTextFontWeight;
  double? width;
  bool obscureText;
  bool autoFocus;
  double fontSize;
  bool isReadOnly;
  EdgeInsets? margin;
  EdgeInsets? padding;
  EdgeInsets contentPadding;
  TextInputType keyboardType;
  List<TextInputFormatter>? inputFormatters;
  bool showClearButton;
  Widget? prefixIcon;
  Widget? suffixIcon;
  int? maxLines;
  int? minLines;
  TextEditingController? controller;
  String? hintText;

  NeuTextFormField(
      {Key? key,
      this.labelTextFontWeight: FontWeight.w400,
      this.onChange,
      this.validator,
      this.width,
      this.fontSize: 14,
      this.margin,
      this.focusNode,
      this.suffixIcon,
      this.obscureText: false,
      this.autoFocus: false,
      this.onTap,
      this.padding,
      this.keyboardType: TextInputType.text,
      this.contentPadding: defContentPadding,
      this.value,
      this.prefixIcon,
      this.inputFormatters,
      this.showClearButton: false,
      this.isReadOnly: false,
      this.minLines,
      this.controller,
      this.hintText,
      this.maxLines})
      : super(key: key);

  //Default Values
  static const EdgeInsets defContentPadding =
      EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15);
  @override
  _NeuTextFormFieldState createState() => _NeuTextFormFieldState();
}

class _NeuTextFormFieldState extends State<NeuTextFormField> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      _textEditingController = widget.controller!;
    } else {
      _textEditingController = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.value != null) {
      _textEditingController.text = widget.value!;
    }
    return ClayContainer(
      depth: -15,
      customBorderRadius: BorderRadius.circular(7.5),
      color: AppColorScheme.bgColor,
      spread: 5,
      child: Container(
        width: widget.width,
        child: TextFormField(
          controller: _textEditingController,
          minLines: widget.minLines,
          maxLines: widget.maxLines,
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType,
          autofocus: widget.autoFocus,
          focusNode: widget.focusNode,
          onTap: widget.onTap,
          validator: (value) {
            print(value);
            if (widget.validator != null) {
              return widget.validator!(value);
            }
            return null;
          },
          onChanged: (value) {
            if (widget.onChange != null) {
              widget.onChange!(value);
            }
          },
          readOnly: widget.isReadOnly,
          style: GoogleFonts.notoSans(
              color: AppColorScheme.textColor,
              fontSize:
                  widget.fontSize / MediaQuery.of(context).textScaleFactor),
          decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              // filled: true,
              prefixIcon: widget.prefixIcon,
              suffix: (widget.showClearButton)
                  ? IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        _textEditingController.clear();
                      },
                    )
                  : Container(
                      height: 0,
                      width: 0,
                    ),
              suffixIcon: widget.suffixIcon,
              contentPadding: widget.contentPadding,
              alignLabelWithHint: true,
              isDense: true,
              hintText: widget.hintText,
              hintStyle: GoogleFonts.notoSans(color: AppColorScheme.textColor)),
          inputFormatters:
              (widget.inputFormatters != null) ? widget.inputFormatters : [],
        ),
      ),
    );
  }
}

// border-radius: 22px;
// background: #fafafa;
// box-shadow: inset 14px 14px 13px #eeeeee,
//             inset -14px -14px 13px #ffffff;
