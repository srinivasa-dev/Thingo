part of 'url_bloc.dart';

abstract class UrlEvent extends Equatable {
  const UrlEvent();
}

class UrlInitialEvent extends UrlEvent {

  const UrlInitialEvent();

  @override
  List<Object?> get props => [];

}

class UrlAPIEvent extends UrlEvent {
  final String url;
  final BuildContext context;

  const UrlAPIEvent({required this.url, required this.context});

  @override
  List<Object?> get props => [url, context];

}
