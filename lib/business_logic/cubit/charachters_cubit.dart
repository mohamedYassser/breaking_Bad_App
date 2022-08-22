
import 'package:bloc/bloc.dart';
import 'package:breaking_bad_app/business_logic/cubit/characters_state.dart';
import 'package:breaking_bad_app/data/models/characters.dart';
import 'package:breaking_bad_app/data/repository/characters_repository.dart';

class CharactersCubit extends Cubit<CharactersState> {

  final CharactersRepository charactersRepository;
List<Character> characterss = [];

  CharactersCubit(this.charactersRepository):super ( CharactersInitial (),);

  List<Character> getAllCharacters(){
charactersRepository.getAllCharacters().then((character){
  emit(CharactersLoaded(character));
  characterss = character ;
}



);
return characterss;
  }



}

