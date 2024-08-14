import "dart:convert";
import "package:http/http.dart" as http;
import "package:pokemon_app/model/pokemon.dart";
import "package:pokemon_app/model/pokemon_details.dart";

class PokemonApi {
  Future<List<Pokemon>> getPokemon() async {
    final response = await http
        .get(Uri.parse("https://pokedex.alansantos.dev/api/pokemons.json"));
    final result = json.decode(response.body);
    List<Pokemon> pokemonList = [];
    if (response.statusCode == 200) {
      for (var pokemon in result) {
        Pokemon pokemonResult = Pokemon(
            number: pokemon["number"],
            pokemonName: pokemon["name"],
            pokemonImage: pokemon["imageUrl"]);
        pokemonList.add(pokemonResult);
      }
    } else {
      throw Exception('Failed to load Pokemon');
    }
    return pokemonList;
  }

  Future<PokemonDetails> getPokemonDetails(String number) async {
    final responseDetail = await http.get(
        Uri.parse("https://pokedex.alansantos.dev/api/pokemons/$number.json"));
    final resultDetail = json.decode(responseDetail.body);
    Map baseStats = Map.of(resultDetail["baseStats"]);
    List types = List.of(resultDetail["types"]);
    List cards = List.of(resultDetail["cards"]);
    List<String> cardsList = [];
    for (var i = 0; i < cards.length; i++) {
      final card = cards[i]['imageUrl'];
      cardsList.add(card);
    }

    List descriptions = List.of(resultDetail["descriptions"]);
    PokemonDetails pokemonDetails = PokemonDetails(
        pokemonDetailsNumber: resultDetail["number"],
        pokemonDetailsName: resultDetail["name"],
        pokemonDetailsImageUrl: resultDetail["imageUrl"],
        pokemonDetailsTypes: types,
        pokemonDetailsBaseStats: baseStats,
        pokemonDetailsCards: cardsList,
        pokemonDetailsDescriptions: descriptions);
    return pokemonDetails;
  }

  // Future<List<String>> getPokemonName() async {
  //   final response = await http
  //       .get(Uri.parse("https://pokedex.alansantos.dev/api/pokemons.json"));
  //   final result = json.decode(response.body);
  //   List<String> pokemonList = [];
  //   if (response.statusCode == 200) {
  //     for (var pokemon in result) {
  //       pokemonList.add(pokemon['name']);
  //     }
  //   } else {
  //     throw Exception('Failed to load Pokemon');
  //   }

  //   return pokemonList;
  // }
}
