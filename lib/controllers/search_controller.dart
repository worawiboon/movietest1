import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:movietest/models/movie_model.dart';

class SearchControl extends GetxController {
  RxList<Movie> allMovies = <Movie>[].obs;
  RxList<Movie> filteredMovies = <Movie>[].obs;
  RxString searchQuery = ''.obs;
  RxBool isLoading = true.obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    fetchMovies();
    super.onInit();
  }

  Future<void> fetchMovies() async {
    try {
      isLoading(true);
      final response = await http.get(
        Uri.parse("https://whoa.onrender.com/whoas/random?results=20"),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        allMovies
            .assignAll(jsonData.map((json) => Movie.fromJson(json)).toList());
        filteredMovies.assignAll(allMovies);
        errorMessage.value = '';
      } else {
        errorMessage.value = 'HTTP Error: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading(false);
    }
  }

  void filterMovies(String query) {
    searchQuery.value = query.toLowerCase();
    filteredMovies.assignAll(
      allMovies.where((movie) =>
          movie.title.toLowerCase().contains(searchQuery.value) ||
          movie.year.toString().contains(searchQuery.value) ||
          movie.director.toLowerCase().contains(searchQuery.value)),
    );
  }
}
