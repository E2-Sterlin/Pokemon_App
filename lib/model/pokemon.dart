class Pokemon {
  String? number;
  String? pokemonName;
  List? pokemonType;
  String? pokemonImage;

  Pokemon({
    required this.number,
    required this.pokemonName,
    required this.pokemonImage,
    required this.pokemonType,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
        number: json['number'],
        pokemonName: json['name'],
        pokemonType: json['type'],
        pokemonImage: json['imageUrl']);
  }
}
