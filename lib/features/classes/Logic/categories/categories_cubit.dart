import 'package:bloc/bloc.dart';
import 'package:hola_academy/features/classes/Data/Repo/categories_repo.dart';
import 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final CategoriesRepo categoriesRepo;

  CategoriesCubit(this.categoriesRepo) : super(CategoriesInitial()) {
    fetchAllCategories();
    // print("Get All Categories");
  }

  // Fetch all categories
  void fetchAllCategories() async {
    try {
      // print('fetching categories');
     if (!isClosed) emit(CategoriesLoading());
      final categories = await categoriesRepo.getAllCategories();
      // print('categories fetched');
      // print(categories);
      if (!isClosed) emit(CategoriesSuccess(categories));
    } catch (e) {
      if (!isClosed) emit(CategoriesError(e.toString()));
    }
  }

  // Fetch a category by ID
  void fetchCategoryById(int id) async {
    try {
      if (!isClosed) emit(CategoriesLoading());
      final category = await categoriesRepo.getCategoryById(id);
      if (!isClosed) emit(SingleCategorySuccess(category));
    } catch (e) {
      if (!isClosed) emit(CategoriesError(e.toString()));
    }
  }
}
