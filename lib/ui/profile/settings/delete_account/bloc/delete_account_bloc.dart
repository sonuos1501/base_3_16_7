import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_account_event.dart';
part 'delete_account_state.dart';
part 'delete_account_bloc.freezed.dart';

class DeleteAccountBloc extends Bloc<DeleteAccountEvent, DeleteAccountState> {
  DeleteAccountBloc() : super(const DeleteAccountState.initial()) {
    on<SawPassword>(_sawPassword);
  }

  Future<void> _sawPassword(SawPassword event, Emitter<DeleteAccountState> emit) async {
    return emit(DeleteAccountState.seePassword(seePassword: event.sawPassword));
  }

}
