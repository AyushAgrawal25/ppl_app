import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ppl_app/Utils/RegExps.dart';
import 'package:ppl_app/UserInterface/Themes/AppColorScheme.dart';

class NeuFormFieldError extends StatelessWidget {
  String value;
  bool toShowError;
  bool isTextFieldFocussed;
  String? errorText;
  NeuFormFieldErrorType formFieldType;
  final TextAlign textAlign;
  NeuFormFieldError(
      {required this.value,
      required this.formFieldType,
      this.errorText,
      this.isTextFieldFocussed: false,
      this.toShowError: false,
      this.textAlign: TextAlign.left});

  @override
  Widget build(BuildContext context) {
    if (this.isTextFieldFocussed) {
      return Container(
        height: 0,
        width: 0,
      );
    }

    bool isValid = false;
    String error = "";
    switch (this.formFieldType) {
      case NeuFormFieldErrorType.email:
        if ((this.value == null) || (this.value == "")) {
          error = "Email is required.";
        } else {
          error = "Invalid Email Entered.";
          if (RegExpsCollections.email.hasMatch(this.value)) {
            isValid = true;
          }
        }
        break;
      case NeuFormFieldErrorType.decimal:
        if (this.value == "") {
          error = "This field is required";
        } else {
          error = "Invalid decimal value.";
          if (RegExpsCollections.decimal.hasMatch(this.value)) {
            isValid = true;
          }
        }
        break;
      case NeuFormFieldErrorType.number:
        if (this.value == "") {
          error = "This field is required";
        } else {
          error = "Invalid number.";
          if (RegExpsCollections.number.hasMatch(this.value)) {
            isValid = true;
          }
        }
        break;
      case NeuFormFieldErrorType.alphaNumeric:
        if (this.value == "") {
          error = "This field is required.";
        } else {
          error = "Invalid Format";
          if (RegExpsCollections.alphaNumeric.hasMatch(this.value)) {
            isValid = true;
          }
        }
        break;
      case NeuFormFieldErrorType.firstName:
        if ((this.value == null) || (this.value == "")) {
          error = "First name is required.";
        } else {
          error = "Invalid Name Format";
          if (RegExpsCollections.onlyAlphabets.hasMatch(this.value)) {
            isValid = true;
          }
        }
        break;
      case NeuFormFieldErrorType.lastName:
        if ((this.value == null) || (this.value == "")) {
          error = "Last name is required.";
        } else {
          error = "Invalid Name Format";
          if (RegExpsCollections.onlyAlphabets.hasMatch(this.value)) {
            isValid = true;
          }
        }
        break;
      case NeuFormFieldErrorType.password:
        error = "Invalid Password.";
        if (this.value != null) {
          if ((this.value.length >= 8) && (this.value.length <= 13)) {
            isValid = true;
            if (!RegExpsCollections.oneLowerCase.hasMatch(this.value)) {
              error = "Atleast one Lower Case letter";
              isValid = false;
            } else if (!RegExpsCollections.oneUpperCase.hasMatch(this.value)) {
              error = "Atleast one Upper Case letter";
              isValid = false;
            } else if (!RegExpsCollections.oneDigit.hasMatch(this.value)) {
              error = "Atleast one digit.";
              isValid = false;
            }
          } else {
            if (this.value.length > 13) {
              error = "Should not contain more than 13 characters.";
            } else {
              error = "Should contain atleast 8 characters.";
            }
          }
        } else {
          isValid = true;
        }
        break;
      case NeuFormFieldErrorType.username:
        if ((this.value == null) || (this.value == "")) {
          error = "Username is required.";
        } else {
          error = "Invalid Username Format";
          if (RegExpsCollections.userName.hasMatch(this.value)) {
            isValid = true;
          }
        }
        break;
      case NeuFormFieldErrorType.noType:
        error = (this.errorText != null) ? this.errorText! : "Error";
        break;
    }

    if (!toShowError) {
      if ((this.value == null) || (this.value == "")) {
        isValid = true;
      }
    }

    if (this.errorText != null) {
      error = this.errorText!;
    }

    if (this.formFieldType == NeuFormFieldErrorType.noType) {
      isValid = this.toShowError;
    }
    if (!isValid) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 7.5),
        alignment: Alignment.centerRight,
        child: Text(
          error,
          style: GoogleFonts.notoSans(
            fontSize: 12,
            color: AppColorScheme.lightErrorGreyColor,
          ),
          textScaleFactor: 1.0,
          textAlign: this.textAlign,
        ),
      );
    } else {
      return Container(
        height: 0,
        width: 0,
      );
    }
  }
}

// TODO: add phone number type also with reg exp.
enum NeuFormFieldErrorType {
  email,
  firstName,
  lastName,
  password,
  username,
  decimal,
  number,
  alphaNumeric,
  noType
}
