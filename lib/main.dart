import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(const AppView()),
    blocObserver: AppBlocObserver(),
  );
}

class AppBlocObserver extends BlocObserver {}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CounterPage(),
    );
  }
}

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterBloc(),
      child: const CounterView(),
    );
  }
}

class CounterView extends StatelessWidget {
  const CounterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<CounterBloc, int>(
              builder: (context, count) {
                return Text('$count', style: const TextStyle(fontSize: 50));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    context.read<CounterBloc>().add(CounterIncrement2Pressed());
                  },
                  child: const Text(
                    '+2',
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<CounterBloc>().add(CounterIncrement1Pressed());
                  },
                  child: const Text(
                    '+1',
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<CounterBloc>().add(ConuterResetPressed());
                  },
                  child: const Text(
                    '0',
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<CounterBloc>().add(CounterDecrement1Pressed());
                  },
                  child: const Text(
                    '-1',
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<CounterBloc>().add(CounterDecrement2Pressed());
                  },
                  child: const Text(
                    '-2',
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(),
                ),
              ],
            )
          ]),
    );
  }
}

abstract class CounterEvent {}

class CounterIncrement1Pressed extends CounterEvent {}

class CounterIncrement2Pressed extends CounterEvent {}

class CounterDecrement1Pressed extends CounterEvent {}

class CounterDecrement2Pressed extends CounterEvent {}

class ConuterResetPressed extends CounterEvent {}

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterIncrement1Pressed>((event, emit) => emit(state + 1));
    on<CounterIncrement2Pressed>((event, emit) => emit(state + 2));
    on<CounterDecrement1Pressed>((event, emit) => emit(state - 1));
    on<CounterDecrement2Pressed>((event, emit) => emit(state - 2));
    on<ConuterResetPressed>((event, emit) => emit(0));
  }
}
