import 'state_provider.dart';
import 'dart:async';

class StateBloc{
  StreamController animationController = StreamController();
final StateProvider provider=StateProvider();
Stream get animationSatus=>animationController.stream;

void toggleAnimation(bool b){
  b?
  provider.toggleAnimationtrue():provider.toggleAnimationfalse();
  animationController.sink.add(provider.isAnimating);
}
void dispost(){
  animationController.close();
}

}

final stateBloc=StateBloc(); 