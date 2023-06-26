import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/constants.dart';
import '../../../models/material_model.dart';
import 'material_states.dart';


class MaterialCubit extends Cubit<MaterialStates>{

  MaterialCubit() : super(MaterialInitialState());
  static MaterialCubit get(context)=>BlocProvider.of(context);

  List<MaterialModel>? materialList;
  void getMaterial(){
    emit(MaterialLoadingState());
    MaterialModel materialModel;
    FirebaseFirestore.instance.collection('material').orderBy('order')
        .get().then((materialDocs) {
      materialList = [];
      materialDocs.docs.forEach((material) {
            materialModel = MaterialModel.fromJson(material.data());
            materialList?.add(materialModel);
          });
      emit(MaterialSuccessState());
    }).catchError((error){
      emit(MaterialErrorState());
      defToast(msg: error.toString());
    });
  }
  void sendRequest(String uId){
    FirebaseFirestore.instance.collection('users').doc(uId).update({'isRequested':true}).then((value) {
      emit(MaterialSuccessRequestState());
    });
  }
}