import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/constants.dart';
import '../../layout/main_layout/cubit/layout_cubit.dart';
import '../../layout/main_layout/layout.dart';
import '../../widgets/def_text_form_filed.dart';
import '../../widgets/loading_button.dart';
import '../sginin_screen/sginin_screen.dart';
import 'cubit/signup_states.dart';
import 'cubit/signup_cubit.dart';


class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);






  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController(text: '01');
    TextEditingController passwordController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey();

    final List<String> items = [
      'القاهرة',
      'الجيزة',
      'الشرقية',
      'الدقهلية',
      'البحيرة',
      'القليوبية',
      'المنيا',
      'الإسكندرية',
      'سوهاج',
      'الغربية',
      'أسيوط',
      'المنوفية',
      'الفيوم',
      'كفر الشيخ',
      'قنا',
      '	بني سويف',
      'دمياط',
      'أسوان',
      'الإسماعيلية',
      'الأقصر',
      'بورسعيد',
      '	السويس',
      'شمال سيناء',
      'مطروح',
      'البحر الأحمر',
      'الوادي الجديد',
      'جنوب سيناء',
    ];
    final TextEditingController textEditingController = TextEditingController();
    return BlocProvider(
      create: (context)=>SignupCubit(),
      child: BlocConsumer<SignupCubit,SignupState>(
        listener: (context,state)  {
          if(state is CreateSuccessState){
            defToast2(
              msg: 'Successfully Signup',
              dialogType: DialogType.success,
              context: context,
            ).then((value) {
              uId = state.uId;
              LayoutCubit.get(context).getUserData();
              LayoutCubit.get(context).getAdminData();
              navigateToReplacement(context,  const MainLayout());
            });
          }
          if(state is SignupErrorState){
            defToast2(
              msg: state.error.toString(),
              dialogType: DialogType.error,
              context: context,
            );
          }
          if(state is CreateErrorState){
            defToast2(
              msg: state.error.toString(),
              dialogType: DialogType.error,
              context: context,
            );
          }
        },
        builder: (context,state){
          SignupCubit cubit = SignupCubit.get(context);
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Scaffold(
              appBar: AppBar(),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Signup",
                            style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                            ),),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text("Join Banker's Lounge app today and grow!",
                            style: TextStyle(
                                fontSize: 17,
                            ),),
                          const SizedBox(
                            height: 40,
                          ),
                          DefTextFormFiled(
                              textEditingController: nameController,
                              prefixIcon: const Icon(Icons.person),
                              labelText: 'Name',
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'please enter name';
                                }
                                else {
                                  return null;
                                }
                              },
                              textInputAction: TextInputAction.next
                          ),
                          const SizedBox(
                            height: 30,
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
                                }else if(value.length < 6){
                                  return 'must be 6 digit';
                                } else {
                                  return null;
                                }
                              },
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.visiblePassword
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          DefTextFormFiled(
                              textEditingController: phoneController,
                              maxLength: 11,
                              prefixIcon: const Icon(Icons.phone),
                              labelText: 'Phone',
                              validator: (value){
                                if(value!.isEmpty ){
                                  return 'please enter your phone';
                                }else if(value.length != 11){
                                  return 'please enter real number';
                                }else {
                                  return null;
                                }
                              },
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.phone,
                              listTextInputFormatter: [
                                FilteringTextInputFormatter.allow(RegExp('[0-9+]'))
                              ],

                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                width: 1,
                                color: Colors.grey
                              )
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true,
                                hint: Row(
                                  children: [
                                    const Icon(
                                      Icons.location_city,
                                      size: 24,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(
                                      width: 10
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Select City',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Theme.of(context).hintColor,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                items: items
                                    .map((item) => DropdownMenuItem(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ))
                                    .toList(),
                                value: cubit.selectedValue,
                                onChanged: (value) {
                                    cubit.selectCity(value!);
                                },
                                buttonStyleData: const ButtonStyleData(
                                  height: 40,
                                  width: 200,
                                ),
                                dropdownStyleData: const DropdownStyleData(
                                  maxHeight: 200,
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                ),
                                dropdownSearchData: DropdownSearchData(
                                  searchController: textEditingController,
                                  searchInnerWidgetHeight: 50,
                                  searchInnerWidget: Container(
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                      top: 8,
                                      bottom: 4,
                                      right: 8,
                                      left: 8,
                                    ),
                                    child: TextFormField(
                                      expands: true,
                                      maxLines: null,
                                      controller: textEditingController,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 8,
                                        ),
                                        hintText: 'Search for an city...',
                                        hintStyle: const TextStyle(fontSize: 12),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                  searchMatchFn: (item, searchValue) {
                                    return (item.value.toString().contains(searchValue));
                                  },
                                ),
                                //This to clear the search value when you close the menu
                                onMenuStateChange: (isOpen) {
                                  if (!isOpen) {
                                    textEditingController.clear();
                                  }
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          LoadingButton(
                              controller: cubit.controller,
                              onPressed: (){
                                FocusScope.of(context).requestFocus(FocusNode());
                                if(formKey.currentState!.validate()){
                                  if(cubit.selectedValue!=null){
                                    cubit.newRegistration(
                                        name: nameController.text,
                                        email: emailController.text,
                                        phone: phoneController.text,
                                        password: passwordController.text,
                                        city: cubit.selectedValue!

                                    );
                                  }else{
                                    cubit.controller.error();
                                    defToast2(context: context, msg: 'Please Select City', dialogType: DialogType.error,);
                                    Future.delayed(const Duration(seconds: 3), () {
                                      cubit.controller.reset();
                                    });
                                  }
                                }else{
                                  cubit.controller.error();
                                  Future.delayed(const Duration(seconds: 3), () {
                                    cubit.controller.reset();
                                  });
                                }
                              },
                              text: 'Sign Up'
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Already have account?'),
                              TextButton(
                                onPressed: () {
                                  navigateToReplacement(context,  const SigninScreen());
                                },
                                child: const Text(
                                  'Login Now',
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
            ),
          );
        },
      ),
    );
  }
}