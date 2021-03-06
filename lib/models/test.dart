// class Details {
//   String requestHash;
//   bool requestCached;
//   int requestCacheExpiry;
//   int malId;
//   String url;
//   String imageUrl;
//   String trailerUrl;
//   String title;
//   String titleEnglish;
//   String titleJapanese;
//   List<Null> titleSynonyms;
//   String type;
//   String source;
//   int episodes;
//   String status;
//   bool airing;
//   Aired aired;
//   String duration;
//   String rating;
//   double score;
//   int scoredBy;
//   int rank;
//   int popularity;
//   int members;
//   int favorites;
//   String synopsis;
//   String background;
//   String premiered;
//   String broadcast;
//   Related related;
//   List<Producers> producers;
//   List<Licensors> licensors;
//   List<Studios> studios;
//   List<Genres> genres;
//   List<String> openingThemes;
//   List<String> endingThemes;

//   Details(
//       {this.requestHash,
//       this.requestCached,
//       this.requestCacheExpiry,
//       this.malId,
//       this.url,
//       this.imageUrl,
//       this.trailerUrl,
//       this.title,
//       this.titleEnglish,
//       this.titleJapanese,
//       this.titleSynonyms,
//       this.type,
//       this.source,
//       this.episodes,
//       this.status,
//       this.airing,
//       this.aired,
//       this.duration,
//       this.rating,
//       this.score,
//       this.scoredBy,
//       this.rank,
//       this.popularity,
//       this.members,
//       this.favorites,
//       this.synopsis,
//       this.background,
//       this.premiered,
//       this.broadcast,
//       this.related,
//       this.producers,
//       this.licensors,
//       this.studios,
//       this.genres,
//       this.openingThemes,
//       this.endingThemes});

//   Details.fromJson(Map<String, dynamic> json) {
//     requestHash = json['request_hash'];
//     requestCached = json['request_cached'];
//     requestCacheExpiry = json['request_cache_expiry'];
//     malId = json['mal_id'];
//     url = json['url'];
//     imageUrl = json['image_url'];
//     trailerUrl = json['trailer_url'];
//     title = json['title'];
//     titleEnglish = json['title_english'];
//     titleJapanese = json['title_japanese'];
//     if (json['title_synonyms'] != null) {
//       titleSynonyms = new List<Null>();
//       json['title_synonyms'].forEach((v) {
//         titleSynonyms.add(new Null.fromJson(v));
//       });
//     }
//     type = json['type'];
//     source = json['source'];
//     episodes = json['episodes'];
//     status = json['status'];
//     airing = json['airing'];
//     aired = json['aired'] != null ? new Aired.fromJson(json['aired']) : null;
//     duration = json['duration'];
//     rating = json['rating'];
//     score = json['score'];
//     scoredBy = json['scored_by'];
//     rank = json['rank'];
//     popularity = json['popularity'];
//     members = json['members'];
//     favorites = json['favorites'];
//     synopsis = json['synopsis'];
//     background = json['background'];
//     premiered = json['premiered'];
//     broadcast = json['broadcast'];
//     related =
//         json['related'] != null ? new Related.fromJson(json['related']) : null;
//     if (json['producers'] != null) {
//       producers = new List<Producers>();
//       json['producers'].forEach((v) {
//         producers.add(new Producers.fromJson(v));
//       });
//     }
//     if (json['licensors'] != null) {
//       licensors = new List<Licensors>();
//       json['licensors'].forEach((v) {
//         licensors.add(new Licensors.fromJson(v));
//       });
//     }
//     if (json['studios'] != null) {
//       studios = new List<Studios>();
//       json['studios'].forEach((v) {
//         studios.add(new Studios.fromJson(v));
//       });
//     }
//     if (json['genres'] != null) {
//       genres = new List<Genres>();
//       json['genres'].forEach((v) {
//         genres.add(new Genres.fromJson(v));
//       });
//     }
//     openingThemes = json['opening_themes'].cast<String>();
//     endingThemes = json['ending_themes'].cast<String>();
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['request_hash'] = this.requestHash;
//     data['request_cached'] = this.requestCached;
//     data['request_cache_expiry'] = this.requestCacheExpiry;
//     data['mal_id'] = this.malId;
//     data['url'] = this.url;
//     data['image_url'] = this.imageUrl;
//     data['trailer_url'] = this.trailerUrl;
//     data['title'] = this.title;
//     data['title_english'] = this.titleEnglish;
//     data['title_japanese'] = this.titleJapanese;
//     if (this.titleSynonyms != null) {
//       data['title_synonyms'] =
//           this.titleSynonyms.map((v) => v.toJson()).toList();
//     }
//     data['type'] = this.type;
//     data['source'] = this.source;
//     data['episodes'] = this.episodes;
//     data['status'] = this.status;
//     data['airing'] = this.airing;
//     if (this.aired != null) {
//       data['aired'] = this.aired.toJson();
//     }
//     data['duration'] = this.duration;
//     data['rating'] = this.rating;
//     data['score'] = this.score;
//     data['scored_by'] = this.scoredBy;
//     data['rank'] = this.rank;
//     data['popularity'] = this.popularity;
//     data['members'] = this.members;
//     data['favorites'] = this.favorites;
//     data['synopsis'] = this.synopsis;
//     data['background'] = this.background;
//     data['premiered'] = this.premiered;
//     data['broadcast'] = this.broadcast;
//     if (this.related != null) {
//       data['related'] = this.related.toJson();
//     }
//     if (this.producers != null) {
//       data['producers'] = this.producers.map((v) => v.toJson()).toList();
//     }
//     if (this.licensors != null) {
//       data['licensors'] = this.licensors.map((v) => v.toJson()).toList();
//     }
//     if (this.studios != null) {
//       data['studios'] = this.studios.map((v) => v.toJson()).toList();
//     }
//     if (this.genres != null) {
//       data['genres'] = this.genres.map((v) => v.toJson()).toList();
//     }
//     data['opening_themes'] = this.openingThemes;
//     data['ending_themes'] = this.endingThemes;
//     return data;
//   }
// }

// class Aired {
//   String from;
//   String to;
//   Prop prop;
//   String string;

//   Aired({this.from, this.to, this.prop, this.string});

//   Aired.fromJson(Map<String, dynamic> json) {
//     from = json['from'];
//     to = json['to'];
//     prop = json['prop'] != null ? new Prop.fromJson(json['prop']) : null;
//     string = json['string'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['from'] = this.from;
//     data['to'] = this.to;
//     if (this.prop != null) {
//       data['prop'] = this.prop.toJson();
//     }
//     data['string'] = this.string;
//     return data;
//   }
// }

// class Prop {
//   From from;
//   From to;

//   Prop({this.from, this.to});

//   Prop.fromJson(Map<String, dynamic> json) {
//     from = json['from'] != null ? new From.fromJson(json['from']) : null;
//     to = json['to'] != null ? new From.fromJson(json['to']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.from != null) {
//       data['from'] = this.from.toJson();
//     }
//     if (this.to != null) {
//       data['to'] = this.to.toJson();
//     }
//     return data;
//   }
// }

// class From {
//   int day;
//   int month;
//   int year;

//   From({this.day, this.month, this.year});

//   From.fromJson(Map<String, dynamic> json) {
//     day = json['day'];
//     month = json['month'];
//     year = json['year'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['day'] = this.day;
//     data['month'] = this.month;
//     data['year'] = this.year;
//     return data;
//   }
// }

// class Related {
//   List<Adaptation> adaptation;
//   List<SideStory> sideStory;
//   List<Summary> summary;

//   Related({this.adaptation, this.sideStory, this.summary});

//   Related.fromJson(Map<String, dynamic> json) {
//     if (json['Adaptation'] != null) {
//       adaptation = <Adaptation>[];
//       json['Adaptation'].forEach((v) {
//         adaptation.add(new Adaptation.fromJson(v));
//       });
//     }
//     if (json['Side story'] != null) {
//       sideStory = new List<SideStory>();
//       json['Side story'].forEach((v) {
//         sideStory.add(new SideStory.fromJson(v));
//       });
//     }
//     if (json['Summary'] != null) {
//       summary = new List<Summary>();
//       json['Summary'].forEach((v) {
//         summary.add(new Summary.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.adaptation != null) {
//       data['Adaptation'] = this.adaptation.map((v) => v.toJson()).toList();
//     }
//     if (this.sideStory != null) {
//       data['Side story'] = this.sideStory.map((v) => v.toJson()).toList();
//     }
//     if (this.summary != null) {
//       data['Summary'] = this.summary.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Adaptation {
//   int malId;
//   String type;
//   String name;
//   String url;

//   Adaptation({this.malId, this.type, this.name, this.url});

//   Adaptation.fromJson(Map<String, dynamic> json) {
//     malId = json['mal_id'];
//     type = json['type'];
//     name = json['name'];
//     url = json['url'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['mal_id'] = this.malId;
//     data['type'] = this.type;
//     data['name'] = this.name;
//     data['url'] = this.url;
//     return data;
//   }
// }
