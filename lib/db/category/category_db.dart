import 'package:flutter/foundation.dart';
import 'package:flutter_application_4/models/category/category_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

const CATEGORY_DB_NAME='category database';

abstract class CategoryDbFuctions{
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel value);
  Future<void>deleteCategory(String categoryID);
}


class CategoryDb implements CategoryDbFuctions{


  CategoryDb._internal();

  static CategoryDb instance =CategoryDb._internal();

  factory CategoryDb(){
    return instance;
  }

  ValueNotifier<List<CategoryModel>> incomeCategoryListListener=ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseCategoryListListener=ValueNotifier([]);

  
  @override
  Future<void> insertCategory(CategoryModel value) async{
    final _categoryDB=await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _categoryDB.put(value.id,value);
    refreshUI();
  }
  
  @override
  Future<List<CategoryModel>> getCategories() async{
    final _categoryDB=await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return _categoryDB.values.toList();
  }

  Future<void>refreshUI()async{
    final _allCategories=await getCategories();
    expenseCategoryListListener.value.clear();
    incomeCategoryListListener.value.clear();
    await Future.forEach(_allCategories, (CategoryModel category){
      if(category.type==CategoryType.income){
        incomeCategoryListListener.value.add(category);
      }else{
        expenseCategoryListListener.value.add(category);
      }
    });

    incomeCategoryListListener.notifyListeners();
    expenseCategoryListListener.notifyListeners();
  }
  
  @override
  Future<void> deleteCategory(String categoryID) async{
    final _categoryDb=await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _categoryDb.delete(categoryID);
    refreshUI();
  }
  
}