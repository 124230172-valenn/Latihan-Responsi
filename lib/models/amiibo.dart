class Amiibo {
  final String name;
  final String gameSeries;
  final String image;
  final String head;
  final String tail;
  final String amiiboSeries;
  final String type;
  final String character;
  final Release? release;

  Amiibo({
    required this.name,
    required this.gameSeries,
    required this.image,
    required this.head,
    required this.tail,
    required this.amiiboSeries,
    required this.type,
    required this.character,
    required this.release,
  });

  factory Amiibo.fromJson(Map<String, dynamic> json) {
    return Amiibo(
      name: json['name'] ?? '',
      gameSeries: json['gameSeries'] ?? '',
      image: json['image'] ?? '',
      head: json['head'] ?? '',
      tail: json['tail'] ?? '',
      amiiboSeries: json['amiiboSeries'] ?? '',
      type: json['type'] ?? '',
      character: json['character'] ?? '',
      release: json['release'] != null
          ? Release.fromJson(json['release'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'gameSeries': gameSeries,
        'image': image,
        'head': head,
        'tail': tail,
        'amiiboSeries': amiiboSeries,
        'type': type,
        'character': character,
        'release': release?.toJson(),
      };
}

// ===========================================
// RELEASE MODEL
// ===========================================

class Release {
  final String? au;
  final String? eu;
  final String? jp;
  final String? na;

  Release({
    this.au,
    this.eu,
    this.jp,
    this.na,
  });

  factory Release.fromJson(Map<String, dynamic> json) {
    return Release(
      au: json['au'],
      eu: json['eu'],
      jp: json['jp'],
      na: json['na'],
    );
  }

  Map<String, dynamic> toJson() => {
        'au': au,
        'eu': eu,
        'jp': jp,
        'na': na,
      };
}
