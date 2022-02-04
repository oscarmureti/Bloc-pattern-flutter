import 'dart:async';

enum CounterAction {
  Increment,
  Decrement,
  Reset,
}

class CounterBlock {
  int counter = 0;
//stream controlers
  final _stateStreamController = StreamController<int>();
  StreamSink<int> get CounterSink => _stateStreamController.sink;
  Stream<int> get CounterStream => _stateStreamController.stream;

//event stream controlers
  final _eventStreamController = StreamController<CounterAction>();
  StreamSink<CounterAction> get eventSink => _eventStreamController.sink;
  Stream<CounterAction> get eventStream => _eventStreamController.stream;

  // creating a constructor
  CounterBlock() {
    eventStream.listen((event) {
      if (event == CounterAction.Increment) {
        counter++;
      } else if (event == CounterAction.Decrement) {
        if (counter > 0) {
          counter--;
        } else {
          counter = 0;
        }
      } else {
        counter = 0;
      }
      CounterSink.add(counter);
    });
  }
  //prevent memory leak
  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}
