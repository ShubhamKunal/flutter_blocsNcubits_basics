import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum InternetStateEnum { Initial, Lost, Gained }

class InternetCubit extends Cubit<InternetStateEnum> {
  Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? connectivityListener;
  InternetCubit() : super(InternetStateEnum.Initial) {
    connectivityListener = _connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.mobile) {
        emit(InternetStateEnum.Gained);
        print("Mobile Connection");
      } else if (event == ConnectivityResult.wifi) {
        emit(InternetStateEnum.Gained);
        print("Wifi Connection");
      } else if (event == ConnectivityResult.none) {
        emit(InternetStateEnum.Lost);
      }
    });
  }
  @override
  Future<void> close() {
    connectivityListener?.cancel();
    return super.close();
  }
}
