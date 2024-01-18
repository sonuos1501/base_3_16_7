// ignore_for_file: constant_identifier_names, inference_failure_on_function_return_type, avoid_multiple_declarations_per_line


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:theshowplayer/constants/dimens.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';

import '../../constants/app_theme.dart';
import '../../models/regex/regex_config.dart';

enum BorderType { NONE, OUTLINE }

class BasicTextField extends StatelessWidget {


  const BasicTextField({super.key,
    this.borderRadius,
    this.disabledColor,
    this.controller,
    this.confirmController,
    this.prefixIcon,
    this.suffixIcon,
    this.textStyle,
    this.labelStyle,
    this.hintStyle,
    this.fillColor,
    this.focusNode,
    this.borderNone = false,
    this.enabled = true,
    this.maxLength,
    this.hintText,
    this.maxLines = 1,
    this.minLines = 1,
    this.contentPadding,
    this.textInputFormatter = r'.',
    this.textError,
    required this.regexConfig,
    this.textAlign = TextAlign.left,
    this.isPassword = false,
    this.textInputAction = TextInputAction.done,
    this.keyboardType,
    this.focus = true,
    this.onChange,
    this.labelText,
    this.suffixText,
    this.labelName,
    this.readOnly,
    this.autoFocus,
    this.borderType,
    this.subLabel,
    this.label,
    this.inputFormatters,
    this.initialValue,
    this.subRegexConfigs,
    this.haveAsterisk = false,
    this.isError = false,
    this.colorBorder,
    this.colorBorderEnable,
    this.validator,
    this.autovalidateMode,
    this.errorMaxLines,
    this.filled = true,
  });
  final TextEditingController? controller;
  final TextEditingController? confirmController;
  final Color? disabledColor;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextStyle? textStyle, labelStyle, hintStyle;
  final bool enabled;
  final int? maxLength;
  final double? borderRadius;
  final int minLines;
  final int maxLines;
  final String textInputFormatter;
  final String? hintText;
  final RegexConfig regexConfig;
  final Color? fillColor;
  final List<RegexConfig>? subRegexConfigs;
  final bool isPassword;
  final TextInputAction textInputAction;
  final TextInputType? keyboardType;
  final bool focus;
  final Function(String)? onChange;
  final String? labelText;
  final String? labelName;
  final bool? readOnly;
  final bool? autoFocus;
  final BorderType? borderType;
  final String? subLabel;
  final String? suffixText;
  final Widget? label;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;
  final EdgeInsetsGeometry? contentPadding;
  final TextAlign textAlign;
  final bool borderNone;
  final FocusNode? focusNode;
  final bool haveAsterisk, filled;
  final bool isError;
  final String? textError;
  final Color? colorBorder, colorBorderEnable;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autovalidateMode;
  final int? errorMaxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      autofocus: autoFocus ?? false,
      onChanged: onChange,
      controller: controller,
      enabled: enabled,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      obscureText: isPassword,
      readOnly: readOnly ?? false,
      style: textStyle ?? Theme.of(context).textTheme.labelMedium!.copyWith(
        color: Theme.of(context).colorScheme.surfaceVariant,
        fontWeight: AppThemeData.medium,
      ),
      textAlignVertical: TextAlignVertical.center,
      textAlign: textAlign,
      focusNode: focusNode,
      autovalidateMode: autovalidateMode ?? AutovalidateMode.onUserInteraction,
      validator: validator ?? (value) {
        value = value?.trim() ?? '';
        // final label = labelName ?? labelText ?? 'input_mg0'.tr(context);
        if ((subRegexConfigs ?? []).isNotEmpty) {
          for (var i = 0; i < subRegexConfigs!.length; i++) {
            if (!subRegexConfigs![i].getRegExp.hasMatch(value)) {
              return subRegexConfigs![i].errorText.tr(context);
            }
          }
        }
        if (!regexConfig.getRegExp.hasMatch(value)) {
          return regexConfig.errorText.tr(context);
        }
        if (confirmController != null && confirmController!.text.trim().compareTo(value) != 0) {
          return 'input_mg1'.tr(context);
        }
        return null;
      },
      minLines: minLines,
      maxLines: maxLines,
      maxLength: maxLength,
      inputFormatters: inputFormatters ??
        [
          if (maxLength != null) LengthLimitingTextInputFormatter(maxLength),
          FilteringTextInputFormatter.allow(RegExp(textInputFormatter)),
        ],
      decoration: InputDecoration(
        errorText: textError ?? (isError ? '' : null),
        errorMaxLines: errorMaxLines ?? Dimens.dimens_30.toInt(),
        label: labelText == null ? null : RichText(
          text: TextSpan(
            text: labelText ?? '',
            style: labelStyle ?? Theme.of(context).textTheme.bodyMedium,
            children: haveAsterisk ? const [
              TextSpan(
                text: ' *',
                style: TextStyle(
                  color: Colors.red,
                ),
              )
            ] : null,
          ),
        ),
        //labelText: labelText ?? '' + (subLabel ?? ''),
        suffixText: suffixText,
        suffixStyle: const TextStyle(
          color: Colors.red,
        ),
        fillColor: fillColor ?? Theme.of(context).colorScheme.surface,
        filled: filled,
        isCollapsed: true,
        errorStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.error, height: isError ? 0 : null),
        hintText: hintText,
        hintStyle: hintStyle ?? Theme.of(context).textTheme.labelMedium!.copyWith(
          color: Theme.of(context).colorScheme.onTertiaryContainer,
          fontWeight: AppThemeData.regular,
        ),
        contentPadding: contentPadding ?? const EdgeInsets.fromLTRB(17, 14, 30, 14),
        disabledBorder: borderNone ? InputBorder.none : _setInputBorder(color: colorBorder ?? Theme.of(context).colorScheme.onTertiaryContainer),
        enabledBorder: borderNone ? InputBorder.none : _setInputBorder(color: colorBorderEnable ?? Theme.of(context).colorScheme.onTertiaryContainer),
        focusedBorder: focus
          ? borderNone ? InputBorder.none : _setInputBorder(color: colorBorder ?? Theme.of(context).colorScheme.outline)
          : borderNone ? InputBorder.none : _setInputBorder(color: colorBorder ?? Theme.of(context).colorScheme.outline),
        errorBorder: borderNone ? InputBorder.none : _setInputBorder(color: Theme.of(context).colorScheme.error.withOpacity(0.6)),
        focusedErrorBorder:  borderNone ? InputBorder.none : _setInputBorder(color: Theme.of(context).colorScheme.error),
        border: borderNone ? InputBorder.none : _setInputBorder(color: Colors.transparent),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        isDense: true,
        prefixIconConstraints: const BoxConstraints(maxHeight: Dimens.dimens_40, minHeight: Dimens.dimens_24),
        suffixIconConstraints: const BoxConstraints(maxHeight: Dimens.dimens_40, minHeight: Dimens.dimens_35),
      ),
    );
  }

  OutlineInputBorder _setInputBorder({
    required Color color,
    double? width,
  }) {
    switch (borderType) {
      case BorderType.OUTLINE:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? Dimens.dimens_10),
          borderSide: BorderSide(width: width ?? 1, color: color),
        );
      case BorderType.NONE:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? Dimens.dimens_10),
          borderSide: BorderSide(width: width ?? 1, color: Colors.transparent),
        );
      // ignore: no_default_cases
      default:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? Dimens.dimens_10),
          borderSide: BorderSide(width: width ?? 1, color: color),
        );
    }
  }
}
