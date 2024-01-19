// ignore_for_file: cast_nullable_to_non_nullable

import 'package:base_3_16_7/utils/locale/app_localization.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants/app_theme.dart';
import '../../constants/dimens.dart';
import '../../utils/utils.dart';
import '../divider/divider.dart';
import 'build_dropdown_item.dart';

class DropdownItem extends Equatable {
  const DropdownItem({required this.content});

  final String content;

  @override
  List<Object?> get props => [content];
}

class DropdownItemWithId {
  const DropdownItemWithId(this.id, this.content);
  final int id;
  final String content;
}

class SelectDropList extends StatefulWidget {
  const SelectDropList({
    super.key,
    required this.content,
    required this.hintText,
    required this.listItem,
    required this.onChange,
    this.enable = true,
    this.haveBorder = true,
    this.usingSearch = true,
  });
  final List<DropdownItem> listItem;
  final ValueChanged<int> onChange;
  final bool enable;
  final String content;
  final String hintText;
  final bool haveBorder;
  final bool usingSearch;

  @override
  State<SelectDropList> createState() => _SelectDropListState();
}

class _SelectDropListState extends State<SelectDropList>
    with SingleTickerProviderStateMixin {
  TextEditingController searchEditCtrl = TextEditingController();

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedItems =
        widget.content.split('|').map((e) => e.trim()).toList();
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        searchInnerWidget: widget.usingSearch ? _buildSearch(context) : null,
        searchInnerWidgetHeight: widget.usingSearch ? Dimens.dimens_50 : null,
        searchController: widget.usingSearch ? searchEditCtrl : null,
        searchMatchFn: (item, searchValue) {
          return Utils.nonUnicode(item.value ?? '')
              .toLowerCase()
              .contains(searchValue.toLowerCase());
        },
        hint: Text(
          widget.hintText,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onTertiaryContainer,
                fontWeight: AppThemeData.regular,
              ),
          overflow: TextOverflow.ellipsis,
        ),
        selectedItemBuilder: (context) {
          return widget.listItem.map((e) {
            return Align(
              alignment: Alignment.centerLeft,
              child: Text(
                selectedItems.join(', '),
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      fontWeight: AppThemeData.medium,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList();
        },
        items: widget.listItem
            .toSet()
            .map(
              (item) => DropdownMenuItem<String>(
                enabled: widget.enable,
                value: item.content.trim(),
                child: BuildDropdownItem(
                  content: item.content.trim(),
                  status: selectedItems.contains(item.content),
                ),
              ),
            )
            .toList(),
        value: widget.content == ''
            ? null
            : widget.content.split('|').map((e) => e.trim()).last,
        onChanged: (value) {
          final content = widget.listItem
              .firstWhere(
                (element) =>
                    element.content.toLowerCase().trim() ==
                    (value as String).toLowerCase(),
              )
              .content;
          final index = widget.listItem.indexWhere((element) =>
              element.content.toLowerCase().trim() ==
              content.toLowerCase().trim());
          widget.onChange(index);
        },
        icon: SvgPicture.asset(
          Assets.icDropDown,
          width: Dimens.dimens_24,
          height: Dimens.dimens_24,
        ),
        buttonHeight: Dimens.dimens_48,
        buttonPadding: const EdgeInsets.only(right: Dimens.dimens_14),
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.dimens_12),
          border: widget.haveBorder
              ? Border.all(
                  color: Theme.of(context).colorScheme.onTertiaryContainer,
                )
              : null,
          color: Theme.of(context).colorScheme.surface,
        ),
        itemHeight: Dimens.dimens_40,
        itemPadding: const EdgeInsets.only(
            left: Dimens.dimens_14, right: Dimens.dimens_14),
        dropdownMaxHeight: Dimens.dimens_200,
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.dimens_12),
          color: Theme.of(context).colorScheme.surface,
        ),
        dropdownElevation: Dimens.dimens_02.toInt(),
        scrollbarRadius: const Radius.circular(Dimens.dimens_40),
        scrollbarThickness: Dimens.dimens_06,
        scrollbarAlwaysShow: true,
      ),
    );
  }

  Widget _buildSearch(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Icon(
                Icons.search,
                color: Theme.of(context).colorScheme.onTertiaryContainer,
                size: Dimens.dimens_20,
              ),
            ),
            Expanded(
              child: TextField(
                controller: searchEditCtrl,
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      fontWeight: AppThemeData.regular,
                    ),
                // onChanged: _onChangedSearch,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintText: 'search'.tr(context),
                  hintStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color:
                            Theme.of(context).colorScheme.onTertiaryContainer,
                        fontWeight: AppThemeData.regular,
                      ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  isDense: true,
                ),
              ),
            ),
          ],
        ),
        const CustomDivider(height: 0.75),
      ],
    );
  }
}
