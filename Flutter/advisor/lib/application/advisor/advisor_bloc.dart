import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'advisor_event.dart';
part 'advisor_state.dart';

class AdvisorBloc extends Bloc<AdvisorEvent, AdvisorState> {
  AdvisorBloc() : super(AdvisorInitial()) {
    Future sleep1() {
      return Future.delayed(const Duration(seconds: 2), () => "1");
    }

    on<AdviceRequestEvent>((event, emit) async {
      emit(AdvisorStateLoading());

      //do something
      await sleep1(); //Fake Network req
      //get advice

      emit(AdvisorStateLoaded(advice: "Advice Test"));
    });
  }
}
