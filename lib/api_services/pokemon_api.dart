import "dart:convert";
import "package:http/http.dart" as http;
import "package:pokemon_app/model/pokemon.dart";
import "package:pokemon_app/model/pokemon_details.dart";

class PokemonApi {
  Future<List<Pokemon>> getPokemon() async {
    List<Pokemon> pokemonList = [];
    try {
      final response = await http
          .get(Uri.parse("https://pokedex.alansantos.dev/api/pokemons.json"));
      final result = json.decode(response.body);

      if (response.statusCode == 200) {
        for (var pokemon in result) {
          Pokemon pokemonResult = Pokemon(
              number: pokemon["number"],
              pokemonName: pokemon["name"],
              pokemonType: pokemon["types"],
              pokemonImage: pokemon["imageUrl"]);
          pokemonList.add(pokemonResult);
        }
      }
    } catch (e) {
      print('Exception occurs for while getting pokemons $e');
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

  Future<List<Map<String, dynamic>>> getPokemonSearch() async {
    final response = await http
        .get(Uri.parse("https://pokedex.alansantos.dev/api/pokemons.json"));
    final result = json.decode(response.body);
    List<Map<String, dynamic>> pokemonList = [];
    for (var e in result) {
      pokemonList.add(e);
    }
    return pokemonList;
  }
}
