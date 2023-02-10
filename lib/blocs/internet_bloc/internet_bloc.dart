import 'dart:async';
import 'package:bloc_concepts/blocs/internet_bloc/internet_event.dart';
import 'package:bloc_concepts/blocs/internet_bloc/internet_state.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? connectivityListener;

  InternetBloc() : super(InternetInitialState()) {
    on<InternetLostEvent>((event, emit) => emit(InternetLostState()));
    on<InternetGainedEvent>((event, emit) => emit(InternetGainedState()));

    connectivityListener = _connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.mobile) {
        add(InternetGainedEvent());
        print("Using Mobile Internet");
      } else if (event == ConnectivityResult.wifi) {
        add(InternetGainedEvent());
        print("Using Wifi Internet");
      } else {
        add(InternetLostEvent());
        print("No Internet");
      }
    });
  }
  @override
  Future<void> close() {
    connectivityListener?.cancel();
    return super.close();
  }
}
