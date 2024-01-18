part of 'delete_account_bloc.dart';

@freezed
class DeleteAccountState with _$DeleteAccountState {
  const factory DeleteAccountState.initial() = DeleteAccountInitialState;
  const factory DeleteAccountState.loading() = DeleteAccountLoadingState;
  const factory DeleteAccountState.fail() = DeleteAccountFailState;
  const factory DeleteAccountState.success() = DeleteAccountSuccessState;

  const factory DeleteAccountState.seePassword({ @Default(false) bool seePassword }) = DeleteAccountSeePasswordState;
}
