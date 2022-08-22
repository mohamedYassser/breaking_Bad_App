import 'package:breaking_bad_app/data/models/characters.dart';
import 'package:breaking_bad_app/data/models/quote.dart';

abstract class CharactersState {}

class CharactersInitial extends CharactersState {}
 class CharactersLoaded extends CharactersState {
  final List<Character> characters;
  CharactersLoaded(this.characters);




 }

class QuotesLoaded extends CharactersState {
 final List<Quote> quotes;

 QuotesLoaded(this.quotes);
}
