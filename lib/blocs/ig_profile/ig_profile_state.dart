// ignore_for_file: must_be_immutable

part of 'ig_profile_bloc.dart';

@immutable
abstract class IgProfileState extends Equatable {
  const IgProfileState();
}

class IgProfileInitState extends IgProfileState {
  @override
  List<Object> get props => [];
}

class IgProfileLoadingState extends IgProfileState {
  @override
  List<Object> get props => [];
}

class IgProfileLoadedState extends IgProfileState {

  IgProfileModel profile;
  IgProfileLoadedState({required this.profile});

  @override
  List<Object?> get props => [profile];

}
