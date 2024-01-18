// ignore_for_file: constant_identifier_names, inference_failure_on_function_return_type
import 'package:flutter/material.dart';
import '../../models/common/item.dart';
import '../../models/regex/regex_config.dart';
import '../../utils/utils.dart';
import 'basic_text_field.dart';

enum BorderType { NONE, OUTLINE }

class ACTextField extends StatelessWidget {
  const ACTextField({
    super.key,
    required this.controller,
    required this.listItem,
    required this.regexConfig,
    this.hintText,
    this.labelText,
    this.onChange,
    this.enabled = true,
    this.suffixIcon,
    this.focusNode,
    this.haveAsterisk = false,
    this.isError = false,
  });

  final TextEditingController controller;
  final List<Item> listItem;
  final RegexConfig regexConfig;
  final String? hintText;
  final String? labelText;
  final bool enabled;
  final bool haveAsterisk;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final Function(int?, String)? onChange;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return RawAutocomplete<Item>(
      focusNode: focusNode,
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) =>
              BasicTextField(
        regexConfig: regexConfig,
        controller: controller,
        focusNode: focusNode,
        hintText: hintText,
        labelText: labelText,
        onChange: onChange == null ? null : (p0) => onChange!(null, p0),
        enabled: enabled,
        suffixIcon: suffixIcon,
        haveAsterisk: haveAsterisk,
        isError: isError,
      ),
      onSelected: (option) {
        controller.text = option.ten ?? '';
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(4)),
            ),
            child: SizedBox(
              height: options.length > 4 ? 190 : options.length * 30.0,
              //width: MediaQuery.of(context).size.width, // <-- Right here !
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final option = options.elementAt(index);
                  return InkWell(
                    onTap: () {
                      onSelected(option);
                      if (focusNode != null) {
                        focusNode!.unfocus();
                      }
                      if (onChange != null) {
                        onChange!(option.id, option.ten ?? '');
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Text(option.ten ?? ''),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
      optionsBuilder: (textEditingValue) => listItem.where(
        (element) => Utils.convertVNtoEN(element.ten ?? '')
            .contains(Utils.convertVNtoEN(textEditingValue.text.trim())),
      ),
      textEditingController: controller,
    );
  }
}
