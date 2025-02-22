import 'package:bloc/bloc.dart';
import 'package:hola_academy/features/classes/Data/Repo/categories_repo.dart';
import 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final CategoriesRepo categoriesRepo;
  

  CategoriesCubit(this.categoriesRepo) : super(CategoriesInitial());

  // Fetch all categories
  void fetchAllCategories() async {
    try {
      print('fetching categories');
      emit(CategoriesLoading());
      final categories = await categoriesRepo.getAllCategories();
      print('categories fetched');
      print(categories);
      emit(CategoriesSuccess(categories));
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }

  // Fetch a category by ID
  void fetchCategoryById(int id) async {
    try {
      emit(CategoriesLoading());
      final category = await categoriesRepo.getCategoryById(id);
      emit(SingleCategorySuccess(category));
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }
}
