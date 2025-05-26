import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart'; // For persistence

class FavoriteController extends GetxController {
  // Use RxSet for efficient add, remove, and contains checks, and to prevent duplicates.
  final RxSet<String> _favoriteMovieIds = <String>{}.obs;

  // Getter to allow UI to reactively listen to the list of favorite IDs
  // Although direct access to _favoriteMovieIds.contains is also reactive
  Set<String> get favoriteMovieIds => _favoriteMovieIds;

  // TODO: Implement methods to load and save favorites from/to shared_preferences

  bool isFavorite(String movieId) {
    return _favoriteMovieIds.contains(movieId);
  }

  void toggleFavorite(String movieId) {
    if (_favoriteMovieIds.contains(movieId)) {
      _favoriteMovieIds.remove(movieId);
      Get.snackbar('Favorites', 'Removed from favorites!',
          snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 1));
    } else {
      _favoriteMovieIds.add(movieId);
      Get.snackbar('Favorites', 'Added to favorites!',
          snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 1));
    }
    // _favoriteMovieIds.refresh(); // Not strictly necessary for RxSet but good practice for some Rx types
    // TODO: Save favorites to shared_preferences after toggling
  }

  // Example for loading from SharedPreferences (to be completed)
  /*
  @override
  void onInit() {
    super.onInit();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? savedFavorites = prefs.getStringList('favoriteMovies');
    if (savedFavorites != null) {
      _favoriteMovieIds.addAll(savedFavorites);
    }
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favoriteMovies', _favoriteMovieIds.toList());
  }
  */
}
