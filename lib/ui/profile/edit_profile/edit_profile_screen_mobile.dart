
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:theshowplayer/blocs/common_blocs/authentication/authentication_bloc.dart';
import 'package:theshowplayer/constants/dimens.dart';
import 'package:theshowplayer/constants/enum/exten_strings.dart';
import 'package:theshowplayer/di/service_locator.dart';
import 'package:theshowplayer/models/channels/argument_update_channel_info.dart';
import 'package:theshowplayer/models/channels/channel_info_data.dart';
import 'package:theshowplayer/models/common/country_data.dart';
import 'package:theshowplayer/ui/profile/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:theshowplayer/utils/loading/loading_process_builder.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';
import 'package:theshowplayer/utils/utils.dart';
import 'package:theshowplayer/widgets/button/common_button.dart';

import '../../../constants/app_theme.dart';
import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
import '../../../constants/enum/gender.dart';
import '../../../utils/regex/regex.dart';
import '../../../widgets/ChooseImage/ChooseImage.dart';
import '../../../widgets/appbar/appbar_view_not_logo.dart';
import '../../../widgets/button/cs_icon_button.dart';
import '../../../widgets/divider/divider.dart';
import '../../../widgets/dropdown/select_drop_list.dart';
import '../../../widgets/image/cache_image.dart';
import '../../../widgets/input/basic_text_field.dart';


class EditProfileScreenMobile extends StatefulWidget {
  const EditProfileScreenMobile({super.key});

  @override
  State<EditProfileScreenMobile> createState() => _EditProfileScreenMobileState();
}

class _EditProfileScreenMobileState extends State<EditProfileScreenMobile> {

  late final _controller = BlocProvider.of<EditProfileBloc>(context, listen: false);

  final _formEditProfileKey = GlobalKey<FormState>();

  final _firstNameEdtCtrl = TextEditingController();
  final _lastNameEdtCtrl = TextEditingController();
  final _userNameEdtCtrl = TextEditingController();
  final _emailAddressEdtCtrl = TextEditingController();
  final _ageEdtCtrl = TextEditingController();
  final _donationPayPalEmailEdtCtrl = TextEditingController();
  final _bioEdtCtrl = TextEditingController();
  final _facebookEdtCtrl = TextEditingController();
  final _googleEdtCtrl = TextEditingController();
  final _twitterEdtCtrl = TextEditingController();
  final _instagramEdtCtrl = TextEditingController();

  Gender? _selectedGender;
  Country? _selectedCountry;

  String? _avatarImg;
  String? _coverImg;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.add(const EditProfileEvent.loaded());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarViewNotLogo(
        title: 'profile_mg0'.tr(context).split(' ').map((e) => e.capitalize).join(' '),
        actions: [ _actionEditAndSaveProfile(context) ],
      ),
      body: SafeArea(
        child: MultiBlocListener(
          listeners: [
            BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                state.whenOrNull(
                  authenticated: (_, __, ___, ____) async {
                    await LoadingProcessBuilder.closeProgressDialog();
                  },
                );
              },
            ),
            BlocListener<EditProfileBloc, EditProfileState>(
              listener: (context, state) {
                state.whenOrNull(
                  loading: LoadingProcessBuilder.showProgressDialog,
                  initial: (_, __) async {
                    await LoadingProcessBuilder.closeProgressDialog();
                  },
                  fail: (errors) async {
                    Utils.showToast(context, errors ?? 'Error', status: false);
                    await LoadingProcessBuilder.closeProgressDialog();
                  },
                  success: (message) async {
                    Utils.showToast(context, message ?? 'Update profile successful');
                    await LoadingProcessBuilder.closeProgressDialog().then((_) {
                      sl<AuthenticationBloc>().add(const AuthenticationEvent.loadedApp());
                    });
                  },
                );
              },
            ),
          ],
          child: BlocBuilder<EditProfileBloc, EditProfileState>(
            buildWhen: (previous, current) => current is EditProfileInitialState && current != previous,
            builder: (context, state) {
              var listGender = <Gender>[];
              var listCountrise = <Country>[];
              if (state is EditProfileInitialState) {
                listGender = state.listGenders ?? [];
                listCountrise = state.countries ?? [];
              }

              return BlocBuilder<AuthenticationBloc, AuthenticationState>(
                buildWhen: (previous, current) => current is Authenticated && current != previous,
                builder: (context, authState) {
                  var channelInfo = ChannelInfoData();
                  if (authState is Authenticated) {
                    channelInfo = authState.channelInfoData ?? ChannelInfoData();
                  }

                  return Stack(
                    children: [
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _buildHeader(context, channelInfo),
                              Gap(ScreenUtil().setHeight(Dimens.dimens_24)),
                              _buildBody(context, listGender, listCountrise, channelInfo),
                              Gap(ScreenUtil().setHeight(Dimens.dimens_50)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, List<Gender> listGender, List<Country> listCountrise, ChannelInfoData channelInfo) {
    return Form(
      key: _formEditProfileKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAboutYou(context, listGender, listCountrise, channelInfo),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimens.dimens_16),
              child: _divider(context),
            ),
            _buildSocial(context, channelInfo),
          ],
        ),
      ),
    );
  }

  Column _buildAboutYou(BuildContext context, List<Gender> listGender, List<Country> listCountrise, ChannelInfoData channelInfo) {
    _firstNameEdtCtrl.text = channelInfo.firstName ?? '';
    _lastNameEdtCtrl.text = channelInfo.lastName ?? '';
    _userNameEdtCtrl.text = channelInfo.username ?? '';
    _emailAddressEdtCtrl.text = channelInfo.email ?? '';
    _selectedGender = channelInfo.gender == null
      ? null
      : listGender.firstWhere(
        (element) => element.key == channelInfo.gender,
        orElse: () => Gender.male,
      );
    _ageEdtCtrl.text = channelInfo.age == null ? '' : channelInfo.age.toString();
    _selectedCountry = (channelInfo.countryId == null || channelInfo.countryName == null)
      ? null
      : Country(id: channelInfo.countryId, value: channelInfo.countryName);
    _donationPayPalEmailEdtCtrl.text = channelInfo.donationPaypalEmail ?? '';
    _bioEdtCtrl.text = channelInfo.about ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title(title: 'profile_mg11'.tr(context)),
        Gap(ScreenUtil().setHeight(Dimens.dimens_12)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: BasicTextField(
                controller: _firstNameEdtCtrl,
                regexConfig: RegexConstant.none,
                keyboardType: TextInputType.text,
                borderRadius: Dimens.dimens_12,
                hintText: 'profile_mg13'.tr(context),
              ),
            ),
            Gap(ScreenUtil().setWidth(Dimens.dimens_12)),
            Expanded(
              child: BasicTextField(
                controller: _lastNameEdtCtrl,
                regexConfig: RegexConstant.none,
                keyboardType: TextInputType.text,
                borderRadius: Dimens.dimens_12,
                hintText: 'profile_mg14'.tr(context),
              ),
            ),
          ],
        ),
        Gap(ScreenUtil().setHeight(Dimens.dimens_16)),
        BasicTextField(
          controller: _userNameEdtCtrl,
          regexConfig: RegexConstant.notEmpty,
          keyboardType: TextInputType.text,
          borderRadius: Dimens.dimens_12,
          enabled: false,
          fillColor: Theme.of(context).colorScheme.surfaceTint,
          hintText: 'profile_mg15'.tr(context),
        ),
        Gap(ScreenUtil().setHeight(Dimens.dimens_16)),
        BasicTextField(
          controller: _emailAddressEdtCtrl,
          regexConfig: RegexConstant.email,
          keyboardType: TextInputType.text,
          borderRadius: Dimens.dimens_12,
          hintText: 'profile_mg16'.tr(context),
        ),
        Gap(ScreenUtil().setHeight(Dimens.dimens_16)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: BlocBuilder<EditProfileBloc, EditProfileState>(
                buildWhen: (previous, current) => current is EditProfileGenderState && current != previous,
                builder: (context, genderState) {
                  if (genderState is EditProfileGenderState) {
                    _selectedGender = genderState.gender;
                  }

                  return SelectDropList(
                    content: _selectedGender == null ? '' : _selectedGender!.name.tr(context),
                    hintText: 'profile_mg17'.tr(context),
                    usingSearch: false,
                    listItem: listGender.map((e) => DropdownItem(content: e.name.tr(context))).toList(),
                    onChange: (index) {
                      if (_selectedGender == listGender[index]) {
                        _controller.add(const EditProfileEvent.choosedGender(gender: null));
                        return;
                      }
                      _controller.add(EditProfileEvent.choosedGender(gender: listGender[index]));
                    },
                  );
                },
              ),
            ),
            Gap(ScreenUtil().setWidth(Dimens.dimens_12)),
            Expanded(
              child: BasicTextField(
                controller: _ageEdtCtrl,
                regexConfig: RegexConstant.none,
                keyboardType: TextInputType.number,
                borderRadius: Dimens.dimens_12,
                hintText: 'profile_mg18'.tr(context),
              ),
            ),
          ],
        ),
        Gap(ScreenUtil().setHeight(Dimens.dimens_16)),
        BlocBuilder<EditProfileBloc, EditProfileState>(
          buildWhen: (previous, current) => current is EditProfileCountryState && current != previous,
          builder: (context, countryState) {
            if (countryState is EditProfileCountryState) {
              _selectedCountry = countryState.country;
            }

            return SelectDropList(
              content: _selectedCountry == null ? '' : _selectedCountry?.value ?? '',
              hintText: 'profile_mg19'.tr(context),
              usingSearch: true,
              listItem: listCountrise.map((e) => DropdownItem(content: e.value ?? '')).toList(),
              onChange: (index) {
                if (_selectedCountry == listCountrise[index]) {
                  _controller.add(const EditProfileEvent.choosedCountry(country: null));
                  return;
                }
                _controller.add(EditProfileEvent.choosedCountry(country: listCountrise[index]));
              },
            );
          },
        ),
        Gap(ScreenUtil().setHeight(Dimens.dimens_16)),
        BasicTextField(
          controller: _donationPayPalEmailEdtCtrl,
          regexConfig: RegexConstant.none,
          keyboardType: TextInputType.text,
          borderRadius: Dimens.dimens_12,
          hintText: 'profile_mg20'.tr(context),
        ),
        Gap(ScreenUtil().setHeight(Dimens.dimens_16)),
        BasicTextField(
          controller: _bioEdtCtrl,
          regexConfig: RegexConstant.none,
          keyboardType: TextInputType.text,
          borderRadius: Dimens.dimens_12,
          maxLines: 5,
          minLines: 1,
          hintText: 'profile_mg21'.tr(context),
        ),
      ],
    );
  }

  Column _buildSocial(BuildContext context, ChannelInfoData channelInfo) {
    _facebookEdtCtrl.text = channelInfo.facebook ?? '';
    _googleEdtCtrl.text = channelInfo.google ?? '';
    _twitterEdtCtrl.text = channelInfo.twitter ?? '';
    _instagramEdtCtrl.text = channelInfo.instagram ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title(title: 'profile_mg12'.tr(context)),
        Gap(ScreenUtil().setHeight(Dimens.dimens_12)),
        BasicTextField(
          controller: _facebookEdtCtrl,
          regexConfig: RegexConstant.none,
          keyboardType: TextInputType.text,
          borderRadius: Dimens.dimens_12,
          hintText: 'facebook'.tr(context),
        ),
        Gap(ScreenUtil().setHeight(Dimens.dimens_16)),
        BasicTextField(
          controller: _googleEdtCtrl,
          regexConfig: RegexConstant.none,
          keyboardType: TextInputType.text,
          borderRadius: Dimens.dimens_12,
          hintText: 'google'.tr(context),
        ),
        Gap(ScreenUtil().setHeight(Dimens.dimens_16)),
        BasicTextField(
          controller: _twitterEdtCtrl,
          regexConfig: RegexConstant.none,
          keyboardType: TextInputType.text,
          borderRadius: Dimens.dimens_12,
          hintText: 'twitter'.tr(context),
        ),
        Gap(ScreenUtil().setHeight(Dimens.dimens_16)),
        BasicTextField(
          controller: _instagramEdtCtrl,
          regexConfig: RegexConstant.none,
          keyboardType: TextInputType.text,
          borderRadius: Dimens.dimens_12,
          hintText: 'instagram'.tr(context),
        ),
      ],
    );
  }

  Text _title({ required String title }) {
    return Text(
      title,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
        color: Theme.of(context).colorScheme.onTertiaryContainer,
        fontWeight: AppThemeData.semiBold,
      ),
    );
  }

  CustomDivider _divider(BuildContext context) => CustomDivider(height: 1, color: Theme.of(context).colorScheme.surfaceTint);

  Widget _buildHeader(BuildContext context, ChannelInfoData channelInfo) {
    return Column(
      children: [
        _buildPersonalCoverPhoto(context, channelInfo),
        Gap(ScreenUtil().setHeight(Dimens.dimens_16)),
        _avatar(context, channelInfo),
      ],
    );
  }

  Widget _buildPersonalCoverPhoto(BuildContext context, ChannelInfoData channelInfo) {
    final size = Size(double.infinity, ScreenUtil().setHeight(Dimens.dimens_100));

    _coverImg = channelInfo.fullCover;

    final image = Stack(
      children: [
        CacheImage(
          image: _coverImg ?? '',
          size: Size(double.infinity, ScreenUtil().setHeight(Dimens.dimens_100)),
          borderRadius: 0,
        ),
        _fogLayer(size),
        Positioned(top: Dimens.dimens_08, right: Dimens.dimens_12, child: _buildCamera(context)),
      ],
    );

    return image;
  }

  Container _fogLayer(Size size, { double? borderRadius }) {
    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        color: AppColors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
      ),
    );
  }

  Widget _avatar(BuildContext context, ChannelInfoData channelInfo) {
    final size = ScreenUtil().setWidth(Dimens.dimens_80);

    _avatarImg = channelInfo.avatar;

    return Stack(
      children: [
        CacheImage(
          image: _avatarImg ?? '',
          size: Size(size, size),
          borderRadius: size / 2,
          imageBuilder: (context, imageProvider) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Theme.of(context).colorScheme.primary),
                shape: BoxShape.circle,
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            );
          },
          errorLoadingImage: Assets.icAvatarDefault,
        ),
        _fogLayer(Size(size, size), borderRadius: size / 2),
        Positioned.fill(child: Center(child: _buildCamera(context))),
      ],
    );
  }

  CsIconButton _buildCamera(BuildContext context) {
    return CsIconButton(
      image: Assets.icCameraPicture,
      height: Dimens.dimens_25,
      color: Theme.of(context).colorScheme.surfaceVariant,
      onPress: () async {
        final chooseImage = ChooseImage(
          context: context,
          isCrop: true,
          // onShowLoading: DialogUtils.showLoading(),
          // onHideLoading: DialogUtils.hideLoading(),
          onChooseImage: (file) async {
            // await _handleChangeAvatar(file.path);
          },
        );

        await chooseImage.show();
      },
    );
  }

  Widget _actionEditAndSaveProfile(BuildContext context) {
    return CommonButton(
      onPress: _handleLogicSaveInfo,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding),
        child: Text(
          'password_mg5'.tr(context),
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Theme.of(context).colorScheme.outline,
            fontWeight: AppThemeData.medium,
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogicSaveInfo() async {
    if (!_formEditProfileKey.currentState!.validate()) {
      return;
    }
    _controller.add(
      EditProfileEvent.saved(
        argumentUpdateChannelInfo: ArgumentUpdateChannelInfo(
          firstName: _firstNameEdtCtrl.text.trim(),
          lastName: _lastNameEdtCtrl.text.trim(),
          email: _emailAddressEdtCtrl.text.trim(),
          userName: _userNameEdtCtrl.text.trim(),
          gender: _selectedGender == null ? null : _selectedGender!.key,
          age: _ageEdtCtrl.text.trim().isEmpty ? null : int.parse(_ageEdtCtrl.text.trim()),
          countryId: _selectedCountry?.id,
          donationPayPalEmail: _donationPayPalEmailEdtCtrl.text.trim(),
          about: _bioEdtCtrl.text.trim(),
          facebook: _facebookEdtCtrl.text.trim(),
          google: _googleEdtCtrl.text.trim(),
          twitter: _twitterEdtCtrl.text.trim(),
          instagram: _instagramEdtCtrl.text.trim(),
        ),
      ),
    );
  }

}
