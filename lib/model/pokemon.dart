class Pokemon {
  String? number;
  String? pokemonName;
  String? pokemonImage;

  Pokemon({
    required this.number,
    required this.pokemonName,
    required this.pokemonImage,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
        number: json['number'],
        pokemonName: json['name'],
        pokemonImage: json['imageUrl']);
  }

   
}
