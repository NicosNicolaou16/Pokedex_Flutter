abstract class PokemonEvents {}

class PokemonListFetchData extends PokemonEvents {
  String? url;
  bool isFirstTime;

  PokemonListFetchData({this.url, this.isFirstTime = true});
}

class Offline extends PokemonEvents {}
