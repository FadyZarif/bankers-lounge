import 'package:bankerslounge/layout/main_layout/cubit/layout_cubit.dart';
import 'package:bankerslounge/models/material_model.dart';
import 'package:bankerslounge/style/themes.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

import '../../widgets/def_button.dart';
import '../../widgets/material_item.dart';
import 'cubit/material_cubit.dart';

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
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, i) =>
                      MaterialItem(materialModel: materials[i]),
                  separatorBuilder: (context, i) => const SizedBox(
                    height: 10,
                  ),
                  itemCount: materials.length,
                ),
              ],
            ),
          ),
          if (cubit.userModel!.role == 'visitor')
            Container(
              color: Colors.grey.withOpacity(0.7),
            ),
          if (cubit.userModel!.role == 'visitor')
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                    child: Icon(
                  Icons.lock,
                  size: 100,
                  color: Colors.black,
                )),
                const Text(
                  'You are not student yet !',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (cubit.userModel!.isRequested != true)
                  DefButton(
                    text: 'Send Request',
                    onPressed: () {
                      MaterialCubit.get(context)
                          .sendRequest(cubit.userModel!.uId!);
                    },
                    color: defColor,
                  )
              ],
            ),
        ],
      ),
    );
  }
}

List<MaterialModel> materials = [
  MaterialModel(
      name: 'Video',
      url: 'assets/material/Banking+Products.pdf',
      isVideo: true,
      isPdf: false),
  MaterialModel(
      name: 'Banking+Products', url: 'assets/material/Banking+Products.pdf'),
  MaterialModel(
      name: 'Business English', url: 'assets/material/Business English.pdf'),
  MaterialModel(
      name: 'compliance and risk management',
      url: 'assets/material/compliance and risk management.pdf'),
  MaterialModel(
      name: 'CV writing and Interview skills new',
      url: 'assets/material/CV writing and Interview skills new.pdf'),
  MaterialModel(
      name: 'Digital Transformation new',
      url: 'assets/material/Digital Transformation new.pdf'),
  MaterialModel(
      name: 'Economy for banking new',
      url: 'assets/material/Economy for banking new.pdf'),
  MaterialModel(
      name: 'How to be a banker',
      url: 'assets/material/How to be a banker.pdf'),
  MaterialModel(
      name: 'Insurance bfi update new',
      url: 'assets/material/Insurance bfi update new.pdf'),
  MaterialModel(name: 'Mortgage BFI', url: 'assets/material/Mortgage BFI.pdf'),
  MaterialModel(
      name: 'Presentation Skills',
      url: 'assets/material/Presentation Skills.pdf'),
  MaterialModel(
      name: 'Presentation1 SME_S  2022 5 New Template',
      url: 'assets/material/Presentation1 SME_S  2022 5 New Template.pdf'),
  MaterialModel(name: 'shomol', url: 'assets/material/shomol.pdf'),
  MaterialModel(name: 'shomol 2', url: 'assets/material/shomol 2.pdf'),
  MaterialModel(
      name: 'shomol 3', url: 'assets/material/shomol 3.pdf'),
  MaterialModel(
      name: 'البورصة د.محمد شعراوي', url: 'assets/material/porsa.pdf'),
  MaterialModel(
      name: 'برنامج مقدمة أدوات الدفع في عمليات التجارة بالبنوك',
      url: 'assets/material/tegara.pdf'),
  MaterialModel(
      name: 'assessment  shapes questions',
      url: 'assets/material/assessment  shapes questions.pdf'),
  MaterialModel(
      name: 'IQ Final 2021', url: 'assets/material/IQ Final 2021.pdf'),
  MaterialModel(
      name: 'Numerical assessment',
      url: 'assets/material/Numerical assessment .pdf'),
];
