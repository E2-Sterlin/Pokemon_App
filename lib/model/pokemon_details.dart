class PokemonDetails {
  String pokemonDetailsNumber;
  String pokemonDetailsName;
  List pokemonDetailsTypes;
  String pokemonDetailsImageUrl;
  List pokemonDetailsDescriptions;
  Map pokemonDetailsBaseStats;
  List<String> pokemonDetailsCards;

  PokemonDetails({
    required this.pokemonDetailsNumber,
    required this.pokemonDetailsName,
    required this.pokemonDetailsTypes,
    required this.pokemonDetailsImageUrl,
    required this.pokemonDetailsBaseStats,
    required this.pokemonDetailsCards,
    required this.pokemonDetailsDescriptions,
  });

  factory PokemonDetails.fromJson(Map<String, dynamic> json) {
    return PokemonDetails(
      pokemonDetailsName: json['name'],
      pokemonDetailsTypes: json['types'],
      pokemonDetailsImageUrl: json['imageUrl'],
      pokemonDetailsBaseStats: json['baseStats'],
      pokemonDetailsCards: json['cards'],
      pokemonDetailsDescriptions: json['descriptions'],
      pokemonDetailsNumber: json['number'],
    );
  }
}
