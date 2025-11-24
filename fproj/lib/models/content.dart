class Content {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String? heroImageUrl;
  final String type; 
  final List<String> genres;
  final int year;
  final double rating;
  final String? duration;
  final String? director;
  final List<String>? cast;
  final String? background; 

  Content({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.heroImageUrl,
    required this.type,
    required this.genres,
    required this.year,
    required this.rating,
    this.duration,
    this.director,
    this.cast,
    this.background,
  });
}

class ContentData {
  static final List<Content> trending = [
    Content(
      id: '1',
      title: 'The Dark Knight',
      description: 'When the menace known as the Joker wreaks havoc on Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.',
      imageUrl: 'assets/images/posters/dark_knight.jpg',
      heroImageUrl: 'assets/images/hero/dark_knight1.jpg',
      type: 'movie',
      genres: ['Action', 'Crime', 'Drama'],
      year: 2008,
      rating: 9.0,
      duration: '152 min',
      director: 'Christopher Nolan',
      cast: ['Christian Bale', 'Heath Ledger', 'Aaron Eckhart'],
      background:
          'After finally tipping the scales in Gotham’s favor with Harvey Dent, Bruce Wayne faces a new kind of chaos. The Joker weaponizes fear, forcing Batman to question how far he can bend his moral code to save the city he swore to protect.',
    ),
    Content(
      id: '2',
      title: 'Stranger Things',
      description: 'When a young boy vanishes, a small town uncovers a mystery involving secret experiments, terrifying supernatural forces and one strange little girl.',
      imageUrl: 'assets/images/posters/stranger_things.jpg',
      heroImageUrl: 'assets/images/hero/stranger_things.jpg',
      type: 'series',
      genres: ['Drama', 'Fantasy', 'Horror'],
      year: 2016,
      rating: 8.7,
      duration: '50 min',
      director: 'The Duffer Brothers',
      cast: ['Millie Bobby Brown', 'Finn Wolfhard', 'David Harbour'],
    ),
    Content(
      id: '3',
      title: 'Inception',
      description: 'A skilled thief is given a chance at redemption if he can pull off the impossible task of inception: planting an idea in someone\'s mind.',
      imageUrl: 'assets/images/posters/inception.jpg',
      heroImageUrl: 'assets/images/hero/inception.jpg',
      type: 'movie',
      genres: ['Action', 'Sci-Fi', 'Thriller'],
      year: 2010,
      rating: 8.8,
      duration: '148 min',
      director: 'Christopher Nolan',
      cast: ['Leonardo DiCaprio', 'Marion Cotillard', 'Tom Hardy'],
    ),
  ];

  static final List<Content> popular = [
    Content(
      id: '4',
      title: 'The Crown',
      description: 'Follows the political rivalries and romance of Queen Elizabeth II\'s reign and the events that shaped the second half of the 20th century.',
      imageUrl: 'assets/images/posters/crown.jpg',
      type: 'series',
      genres: ['Drama', 'History'],
      year: 2016,
      rating: 8.6,
      duration: '60 min',
    ),
    Content(
      id: '5',
      title: 'Interstellar',
      description: 'A team of explorers travel through a wormhole in space in an attempt to ensure humanity\'s survival.',
      imageUrl: 'assets/images/posters/interstellar.jpg',
      type: 'movie',
      genres: ['Adventure', 'Drama', 'Sci-Fi'],
      year: 2014,
      rating: 8.6,
      duration: '169 min',
    ),
    Content(
      id: '6',
      title: 'Breaking Bad',
      description: 'A high school chemistry teacher turned methamphetamine manufacturer partners with a former student.',
      imageUrl: 'assets/images/posters/breaking_bad.jpg',
      type: 'series',
      genres: ['Crime', 'Drama', 'Thriller'],
      year: 2008,
      rating: 9.5,
      duration: '49 min',
    ),
  ];

  static final List<Content> topRated = [
    Content(
      id: '7',
      title: 'The Shawshank Redemption',
      description: 'Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.',
      imageUrl: 'assets/images/posters/shawshank.jpg',
      type: 'movie',
      genres: ['Drama'],
      year: 1994,
      rating: 9.3,
      duration: '142 min',
    ),
    Content(
      id: '8',
      title: 'Game of Thrones',
      description: 'Nine noble families fight for control over the lands of Westeros, while an ancient enemy returns after being dormant for millennia.',
      imageUrl: 'assets/images/posters/got.jpg',
      type: 'series',
      genres: ['Action', 'Adventure', 'Drama'],
      year: 2011,
      rating: 9.2,
      duration: '57 min',
    ),
  ];

  static final List<Content> action = [
    Content(
      id: '9',
      title: 'John Wick',
      description: 'An ex-hit-man comes out of retirement to track down the gangsters that took everything from him.',
      imageUrl: 'assets/images/posters/john_wick.jpg',
      type: 'movie',
      genres: ['Action', 'Crime', 'Thriller'],
      year: 2014,
      rating: 7.4,
      duration: '101 min',
    ),
    Content(
      id: '10',
      title: 'Mad Max: Fury Road',
      description: 'In a post-apocalyptic wasteland, Max teams up with a mysterious woman to escape from a tyrannical warlord.',
      imageUrl: 'assets/images/posters/mad_max.jpg',
      type: 'movie',
      genres: ['Action', 'Adventure', 'Sci-Fi'],
      year: 2015,
      rating: 8.1,
      duration: '120 min',
    ),
  ];

  static final List<Content> comedy = [
    Content(
      id: '11',
      title: 'The Office',
      description: 'A mockumentary on a group of typical office workers, where the workday consists of ego clashes, inappropriate behavior, and tedium.',
      imageUrl: 'assets/images/posters/office.jpg',
      type: 'series',
      genres: ['Comedy'],
      year: 2005,
      rating: 8.9,
      duration: '22 min',
    ),
    Content(
      id: '12',
      title: 'The Grand Budapest Hotel',
      description: 'A writer encounters the owner of an aging high-class hotel, who tells him of his early years serving as a lobby boy in the hotel\'s glorious years.',
      imageUrl: 'assets/images/posters/grand_budapest.jpg',
      type: 'movie',
      genres: ['Adventure', 'Comedy', 'Drama'],
      year: 2014,
      rating: 8.1,
      duration: '99 min',
    ),
  ];

  static Content? getContentById(String id) {
    final allContent = [...trending, ...popular, ...topRated, ...action, ...comedy];
    try {
      return allContent.firstWhere((content) => content.id == id);
    } catch (e) {
      return null;
    }
  }
}

