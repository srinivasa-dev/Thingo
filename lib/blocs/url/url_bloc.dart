import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:thingo/models/url_model.dart';
import 'package:thingo/service/url_service.dart';

part 'url_event.dart';
part 'url_state.dart';

class UrlBloc extends Bloc<UrlEvent, UrlState> {
  final UrlService _urlService;

  UrlBloc(this._urlService) : super(UrlInitial()) {
    on<UrlEvent>((event, emit) {
      on<UrlAPIEvent>((event, emit) async {
        if(event is UrlAPIEvent) {
          emit(UrlLoadingState());
          var urlResponse = await _urlService.getUrl(event.url);
          var data = json.decode(urlResponse.body);

          if(data['ok'] == true) {
            emit(UrlLoadedState(urlModel: UrlModel.fromJson(data['result'])));
          } else {
            ScaffoldMessenger.of(event.context).showSnackBar(
              SnackBar(
                content: Text(
                  data['error'].toString().split(',').first,
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
            emit(UrlErrorState(error: data['error'].toString().split(',').first));
          }
        }
      });
    });
  }
}
