import 'package:bloc_concepts/blocs/internet_bloc/internet_bloc.dart';
import 'package:bloc_concepts/blocs/internet_bloc/internet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Center(
        child: SafeArea(
          child: BlocConsumer<InternetBloc, InternetState>(
            listener: (context, state) {
              if (state is InternetGainedState) {
                showSnackbar(context, "Internet is back!", Colors.green);
              } else if (state is InternetLostState) {
                showSnackbar(context, "Internet is gone :(", Colors.red);
              } else {
                showSnackbar(context, "Connecting!", Colors.black);
              }
            },
            builder: (context, state) {
              //FOR UI
              if (state is InternetGainedState) {
                return BigText(text: "Internet is connected");
              } else if (state is InternetLostState) {
                return BigText(text: "Internet has been disconnected");
              } else {
                return BigText(text: "Loading....");
              }
            },
          ),
          // child: Center(
          //   child: BlocBuilder<InternetBloc, InternetState>(
          //     builder: (context, state) {
          //       if (state is InternetGainedState) {
          //         return const Text("Internet is connected");
          //       } else if (state is InternetLostState) {
          //         return const Text("Internet has been disconnected");
          //       } else {
          //         return const Text("Loading....");
          //       }
          //     },
          //   ),
          // ),
        ),
      ),
    );
  }

  void showSnackbar(BuildContext context, String message, Color bgColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: bgColor,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

class BigText extends StatelessWidget {
  String text;
  BigText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}
