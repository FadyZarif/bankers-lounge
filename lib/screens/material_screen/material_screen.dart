import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/material_item.dart';
import 'cubit/material_cubit.dart';
import 'cubit/material_states.dart';

class MaterialScreen extends StatelessWidget {
  const MaterialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8),bottomRight: Radius.circular(8)),
                boxShadow: [BoxShadow(color: Colors.black54,offset: Offset(1, 5),blurRadius: 8)]
              ),
              clipBehavior: Clip.antiAlias,
              height: MediaQuery.of(context).size.height*0.33,
              width: double.infinity,
              child: FancyShimmerImage(imageUrl: 'https://firebasestorage.googleapis.com/v0/b/emad-kattara.appspot.com/o/310723217_583915710201368_6621670359857999622_n.jpg?alt=media&token=e844667f-60a1-4eb6-9708-2f52ec454ef6'
              , boxFit: BoxFit.fill,)

            ),
            SizedBox(height: 20,),
            BlocConsumer<MaterialCubit,MaterialStates>(
              listener: (context,state){},
              builder: (context,state){
                MaterialCubit materialCubit = MaterialCubit.get(context);
                return ConditionalBuilder(
                  condition: materialCubit.materialList != null,
                  builder: (context) => ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, i) => MaterialItem(materialModel: materialCubit.materialList![i]),
                    separatorBuilder: (context, i) => const SizedBox(
                      height: 10,
                    ),
                    itemCount: materialCubit.materialList!.length,
                  ),
                  fallback: (context) =>
                      Center(child: CircularProgressIndicator()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
