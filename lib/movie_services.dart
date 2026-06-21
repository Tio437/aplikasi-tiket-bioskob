import 'dart:convert';
import 'package:http/http.dart' as http;
import 'movie_model.dart';

class MovieService {
  static const String _apiKey = '5d37e556bb5d4dba882e2bb72b746060';
  static const String _baseUrl = 'https://api.themoviedb.org/3';

  // Flag to check if we fell back to mock data
  bool isUsingMockData = false;

  Future<List<Movie>> fetchNowPlaying() async {
    final uri = Uri.parse('$_baseUrl/movie/now_playing?api_key=$_apiKey&language=id-ID&page=1');

    try {
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(
        const Duration(seconds: 8),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['results'] != null) {
          final List<dynamic> results = data['results'];
          isUsingMockData = false;
          return results.map((json) => Movie.fromJson(json)).toList();
        }
      }
      
      // If code is not 200 (e.g. 401 Unauthorized), use mock data fallback
      isUsingMockData = true;
      return _getMockMovies();
    } catch (e) {
      isUsingMockData = true;
      return _getMockMovies();
    }
  }

  Future<List<Movie>> searchMovies(String query) async {
    if (query.trim().isEmpty) {
      return fetchNowPlaying();
    }
    
    if (isUsingMockData) {
      final mock = _getMockMovies();
      return mock.where((m) => m.title.toLowerCase().contains(query.toLowerCase())).toList();
    }

    final uri = Uri.parse('$_baseUrl/search/movie?api_key=$_apiKey&query=${Uri.encodeComponent(query)}&language=id-ID');

    try {
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(
        const Duration(seconds: 8),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['results'] != null) {
          final List<dynamic> results = data['results'];
          return results.map((json) => Movie.fromJson(json)).toList();
        }
      }
      return _getMockMovies().where((m) => m.title.toLowerCase().contains(query.toLowerCase())).toList();
    } catch (e) {
      return _getMockMovies().where((m) => m.title.toLowerCase().contains(query.toLowerCase())).toList();
    }
  }

  List<Movie> _getMockMovies() {
    return [
      Movie(
        id: 1,
        title: 'Dune: Part Two',
        overview: 'Perjalanan mitis Paul Atreides saat ia bersatu dengan Chani dan Fremen sambil membalas dendam terhadap para konspirator yang menghancurkan keluarganya. Menghadapi pilihan antara cinta dalam hidupnya dan nasib alam semesta yang diketahui, ia berusaha mencegah masa depan mengerikan yang hanya ia yang bisa meramalkannya.',
        posterPath: '',
        backdropPath: '',
        releaseDate: '2024-02-27',
        voteAverage: 8.3,
      ),
      Movie(
        id: 2,
        title: 'Oppenheimer',
        overview: 'Kisah ilmuwan Amerika J. Robert Oppenheimer dan perannya dalam pengembangan bom atom selama Perang Dunia II, yang mengubah jalannya sejarah dunia selamanya.',
        posterPath: '',
        backdropPath: '',
        releaseDate: '2023-07-19',
        voteAverage: 8.1,
      ),
      Movie(
        id: 3,
        title: 'Avatar: The Way of Water',
        overview: 'Jake Sully tinggal bersama keluarga barunya yang terbentuk di bulan ekstrasurya Pandora. Setelah ancaman akrab kembali untuk menyelesaikan apa yang dimulai sebelumnya, Jake harus bekerja sama dengan Neytiri dan tentara ras Na\'vi untuk melindungi planet mereka.',
        posterPath: '',
        backdropPath: '',
        releaseDate: '2022-12-14',
        voteAverage: 7.6,
      ),
      Movie(
        id: 4,
        title: 'Spider-Man: Across the Spider-Verse',
        overview: 'Setelah bersatu kembali dengan Gwen Stacy, Spider-Man ramah lingkungan penuh waktu asal Brooklyn dilemparkan melintasi Multiverse, di mana ia bertemu dengan tim Spider-People yang bertugas melindungi keberadaannya.',
        posterPath: '',
        backdropPath: '',
        releaseDate: '2023-05-31',
        voteAverage: 8.4,
      ),
      Movie(
        id: 5,
        title: 'The Batman',
        overview: 'Ketika seorang pembunuh berantai sadis mulai membunuh tokoh-tokoh politik penting di Gotham, Batman terpaksa menyelidiki korupsi tersembunyi di kota itu dan mempertanyakan keterlibatan keluarganya sendiri.',
        posterPath: '',
        backdropPath: '',
        releaseDate: '2022-03-01',
        voteAverage: 7.7,
      ),
    ];
  }
}
