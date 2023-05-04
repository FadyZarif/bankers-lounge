import 'package:bankerslounge/constants/constants.dart';
import 'package:bankerslounge/layout/main_layout/cubit/layout_cubit.dart';
import 'package:bankerslounge/style/themes.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../widgets/def_button.dart';
import '../../widgets/material_item.dart';
import 'cubit/material_cubit.dart';
import 'cubit/material_states.dart';

class MaterialScreen extends StatelessWidget {
  const MaterialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LayoutCubit cubit = LayoutCubit.get(context);
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black54,
                              offset: Offset(1, 5),
                              blurRadius: 8)
                        ]),
                    clipBehavior: Clip.antiAlias,
                    height: MediaQuery.of(context).size.height * 0.33,
                    width: double.infinity,
                    child: FancyShimmerImage(
                      imageUrl:
                          'https://firebasestorage.googleapis.com/v0/b/emad-kattara.appspot.com/o/310723217_583915710201368_6621670359857999622_n.jpg?alt=media&token=e844667f-60a1-4eb6-9708-2f52ec454ef6',
                      boxFit: BoxFit.fill,
                    )),
                const SizedBox(
                  height: 20,
                ),
                BlocConsumer<MaterialCubit, MaterialStates>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    MaterialCubit materialCubit = MaterialCubit.get(context);
                    return ConditionalBuilder(
                      condition: materialCubit.materialList != null,
                      builder: (context) => ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, i) => MaterialItem(
                            materialModel: materialCubit.materialList![i]),
                        separatorBuilder: (context, i) => const SizedBox(
                          height: 10,
                        ),
                        itemCount: materialCubit.materialList!.length,
                      ),
                      fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                    );
                  },
                ),
              ],
            ),
          ),
          if(cubit.userModel!.role == 'visitor')
          Container(color: Colors.grey.withOpacity(0.7),),
          if(cubit.userModel!.role == 'visitor')
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(child: Icon(Icons.lock,size:100,color: Colors.black,)),
              const Text('You are not student yet !',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),
              if(cubit.userModel!.isRequested != true)
              DefButton(text: 'Send Request', onPressed: (){
                MaterialCubit.get(context).sendRequest(cubit.userModel!.uId!);
              },color: defColor,)
            ],
          ),

        ],
      ),
    );
  }
}
