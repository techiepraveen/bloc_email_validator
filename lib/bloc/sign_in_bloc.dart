import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_field_bloc/bloc/sign_in_event.dart';
import 'package:text_field_bloc/bloc/sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState>{
  SignInBloc():super(SignInInitialState()){
    on<SignInTextChangedEvent>((event, emit) 
    {
      if(
      EmailValidator.validate(event.email)==false){
        emit(SignInErrorState("please enter a valid email"));
      }
      else if(event.password.length <8){
         emit(SignInErrorState("please enter a valid password"));
      }
      else{
        emit(SignInValidState());
      }
    }
    );
    on<SignInSubmittedEvent>((event, emit) {
      emit(SignInLoadingState());

    });
  }
}