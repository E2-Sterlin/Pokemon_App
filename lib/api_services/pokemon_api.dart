import "dart:convert";
import "package:http/http.dart" as http;
import "package:pokemon_app/model/pokemon.dart";
import "package:pokemon_app/model/pokemon_details.dart";

class PokemonApi {
  Future<List<Pokemon>> getPokemon() async {
    List<Pokemon> pokemonList = [];
    try {
      final response = await http.get(
        Uri.parse("https://pokedex.alansantos.dev/api/pokemons.json"),
      );
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
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      print('Exception occurs for while getting pokemons $e');
    }
    return pokemonList;
  }

  Future<PokemonDetails> getPokemonDetails(String number) async {
    late PokemonDetails pokemonDetails;
    try {
      final detailResponse = await http.get(
        Uri.parse("https://pokedex.alansantos.dev/api/pokemons/$number.json"),
      );
      if (detailResponse.statusCode == 200) {
        final resultDetail = json.decode(detailResponse.body);
        Map baseStats = Map.of(resultDetail["baseStats"]);
        List types = List.of(resultDetail["types"]);
        List cards = List.of(resultDetail["cards"]);
        List<String> cardsList = [];
        for (var i = 0; i < cards.length; i++) {
          final card = cards[i]['imageUrl'];
          cardsList.add(card);
        }

        List descriptions = List.of(resultDetail["descriptions"]);
        pokemonDetails = PokemonDetails(
            pokemonDetailsNumber: resultDetail["number"],
            pokemonDetailsName: resultDetail["name"],
            pokemonDetailsImageUrl: resultDetail["imageUrl"],
            pokemonDetailsTypes: types,
            pokemonDetailsBaseStats: baseStats,
            pokemonDetailsCards: cardsList,
            pokemonDetailsDescriptions: descriptions);
      } else {
        throw Exception(detailResponse.reasonPhrase);
      }
    } catch (e) {
      print('Exception occurs while fetching pokemonDetails $e');
    }
    return pokemonDetails;
  }

  Future<List<Map<String, dynamic>>> getPokemonSearch() async {
    List<Map<String, dynamic>> pokemonList = [];

    try {
      final response = await http
          .get(Uri.parse("https://pokedex.alansantos.dev/api/pokemons.json"));
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        for (var e in result) {
          pokemonList.add(e);
        }
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      print('Exception occured while fetching Pokemon Search List $e');
    }

    return pokemonList;
  }
}
