// ignore_for_file: must_be_immutable

part of 'url_bloc.dart';

abstract class UrlState extends Equatable {
  const UrlState();
}

class UrlInitial extends UrlState {
  @override
  List<Object> get props => [];
}

class UrlLoadingState extends UrlState {
  @override
  List<Object> get props => [];
}

class UrlLoadedState extends UrlState {

  UrlModel urlModel;
  UrlLoadedState({required this.urlModel});

  @override
  List<Object?> get props => [urlModel];

}

class UrlErrorState extends UrlState {

  String error;
  UrlErrorState({required this.error});

  @override
  List<Object?> get props => [error];

}
