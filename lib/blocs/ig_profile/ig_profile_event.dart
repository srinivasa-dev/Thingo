part of 'ig_profile_bloc.dart';

@immutable
abstract class IgProfileEvent extends Equatable {
  const IgProfileEvent();
}

class IgProfileAPIEvent extends IgProfileEvent {
  final String username;

  const IgProfileAPIEvent({required this.username});

  @override
  List<Object?> get props => [username];

}