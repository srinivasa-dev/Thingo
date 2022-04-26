import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thingo/models/ig_profile_model.dart';
import 'package:thingo/service/ig_profile_service.dart';
import 'package:meta/meta.dart';

part 'ig_profile_event.dart';
part 'ig_profile_state.dart';

class IgProfileBloc extends Bloc<IgProfileEvent, IgProfileState> {

  final IgProfileService _igProfileService;

  IgProfileBloc(this._igProfileService) : super(IgProfileInitState()) {
    on<IgProfileAPIEvent>((event, emit) async {
      if(event is IgProfileAPIEvent) {
        emit(IgProfileLoadingState());
        var igProfile = await _igProfileService.getIgProfile(event.username);
        var data = json.decode(igProfile.body);

        emit(IgProfileLoadedState(profile: IgProfileModel.fromJson(data)));
      }
    });
  }
}
