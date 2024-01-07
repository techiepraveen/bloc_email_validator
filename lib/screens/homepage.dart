import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_field_bloc/bloc/sign_in_bloc.dart';
import 'package:text_field_bloc/bloc/sign_in_event.dart';
import 'package:text_field_bloc/bloc/sign_in_state.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController emaildController= TextEditingController();
  TextEditingController passwordController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
         title: const Text("Welcomes"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: ListView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()
            ),
            children: [
              BlocBuilder<SignInBloc, SignInState>(
                builder: (context, state) {
                  if(state is SignInErrorState){
                    return Text(state.errorMessage,
                    style: const TextStyle(color: Colors.red));

                  }
                  else{
                    return Container();
                  }
                  
                },
              ),
            const   SizedBox(height: 10,),
              TextField(
                controller: emaildController,
                onChanged: (val){
                  BlocProvider.of<SignInBloc>(context)
                  .add(SignInTextChangedEvent(
                   emaildController.text ,
                     passwordController.text));
                },
                decoration:const  InputDecoration(
                  hintText: "Email Address"
                ),
              ),
             const  SizedBox(height: 10,),
              TextField(
              controller: passwordController,
              onChanged: (val){
                  BlocProvider.of<SignInBloc>(context)
                  .add(SignInTextChangedEvent(
                   emaildController.text ,
                     passwordController.text));
                },
                decoration:const  InputDecoration(
                  hintText: "Password"
                ),
              ),
                
             const  SizedBox(height: 20,),
             BlocBuilder<SignInBloc, SignInState>
             (builder:(context,state){
              if(state is SignInLoadingState){
                return const  Center(child: CircularProgressIndicator());
              }
              return CupertinoButton(
               color: (state is SignInValidState)? Colors.blue:Colors.grey,
                 child:  const Text("sign In"), 
                onPressed: (){
                  if(state is SignInValidState){
                     BlocProvider.of<SignInBloc>(context)
                  .add(SignInSubmittedEvent(
                   emaildController.text ,
                     passwordController.text));
                  }
                }
                );
             }
             
              )
            ],
          ),
        ),
      ),
    );
  }
}