import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/constants.dart';
import '../../layout/main_layout/cubit/layout_cubit.dart';
import '../../layout/main_layout/layout.dart';
import '../../widgets/def_text_form_filed.dart';
import '../../widgets/loading_button.dart';
import '../signup_screen/signup_screen.dart';
import 'cubit/signin_cubit.dart';
import 'cubit/signin_states.dart';




class SigninScreen extends StatelessWidget {
  SigninScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true
    );
    return BlocProvider(
      create: (context)=>SigninCubit(),
      child: BlocConsumer<SigninCubit,SigninStates>(
        listener: (context,state){
          if(state is SigninSuccessState){
            defToast2(
              msg: 'Successfully Signin',
              context: context,
              dialogType: DialogType.success
            ).then((value) {
              LayoutCubit.get(context).getUserData();
              LayoutCubit.get(context).getAdminData();
              navigateToReplacement(context,  const MainLayout());
            });

          }
          if(state is SigninErrorState){
            defToast2(
              msg: state.error.toString(),
                context: context,
                dialogType: DialogType.error
            );
          }
        },
        builder: (context,state){
          SigninCubit cubit = SigninCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.symmetric(horizontal: 40,vertical: 20),
                          child: Image.asset('assets/logo2.png'),
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent,
                            borderRadius: BorderRadius.circular(5) 
                          ),
                        ),
                        const Text("Signin",
                          style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                          ),),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text("Boost your banking skills with",
                          style: TextStyle(
                              fontSize: 17
                          ),),
                        Text('Banker\'s Lounge.',style: TextStyle(color: Colors.lightBlueAccent,fontSize: 18),),
                        const SizedBox(
                          height: 40,
                        ),
                        DefTextFormFiled(
                            textEditingController: emailController,
                            prefixIcon: const Icon(Icons.email_outlined),
                            labelText: 'Email',
                            validator: (value){
                              if(value!.isEmpty){
                                return 'please enter email';
                              }
                              else {
                                return null;
                              }
                            },
                            textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        DefTextFormFiled(
                            textEditingController: passwordController,
                            prefixIcon: const Icon(Icons.lock_outline),
                            labelText: 'Password',
                            password: cubit.isPassword,
                            suffixIcon:  IconButton(
                              onPressed: (){
                                cubit.changePasswordVisibility();
                              },
                              icon: Icon(cubit.suffixIcon),
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return 'please enter password';
                              }
                              else {
                                return null;
                              }
                            },
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.visiblePassword
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        LoadingButton(
                            text: 'Sign In',
                            controller: cubit.btnController,
                            onPressed: () {
                              FocusScope.of(context).requestFocus(new FocusNode());
                              if(formKey.currentState!.validate()){
                                cubit.userSignin(email: emailController.text, password: passwordController.text);
                              }else{
                                cubit.btnController.error();
                              }
                            }
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account?'),
                            TextButton(
                              onPressed: () {
                                navigateToReplacement(context,  SignupScreen());
                              },
                              child: const Text(
                                'Register Now',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}