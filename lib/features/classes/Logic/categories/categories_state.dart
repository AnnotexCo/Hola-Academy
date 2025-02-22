import 'package:equatable/equatable.dart';
import 'package:hola_academy/features/classes/Data/Model/category_model.dart';

// Base state class
abstract class CategoriesState extends Equatable {
  @override
  List<Object> get props => [];
}

// Initial state
class CategoriesInitial extends CategoriesState {}

// Loading state
class CategoriesLoading extends CategoriesState {}

// Success state - for fetching all categories
class CategoriesSuccess extends CategoriesState {
  final List<CategoryModel> categories;
  CategoriesSuccess(this.categories);

  @override
  List<Object> get props => [categories];
}

// Success state - for fetching a single program
class SingleCategorySuccess extends CategoriesState {
  final CategoryModel category;
  SingleCategorySuccess(this.category);

  @override
  List<Object> get props => [category];
}

// Error state
class CategoriesError extends CategoriesState {
  final String message;
  CategoriesError(this.message);

  @override
  List<Object> get props => [message];
}
