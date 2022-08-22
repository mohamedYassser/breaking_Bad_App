

import 'package:breaking_bad_app/business_logic/cubit/charachters_cubit.dart';
import 'package:breaking_bad_app/business_logic/cubit/characters_state.dart';
import 'package:breaking_bad_app/constants/my_colors.dart';
import 'package:breaking_bad_app/data/models/characters.dart';
import 'package:breaking_bad_app/presentation/widgets/character_widget_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class CharactersScreen extends StatefulWidget {

  const CharactersScreen({Key? key}) : super(key: key);


  @override

  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
 List<Character> allCharacters =[];
 late List<Character> searchedForCharacters;
 bool _isSearching = false;
 final _searchTextController = TextEditingController();
 //build search Field
 Widget _buildSearchField() {
   return TextField(
     controller: _searchTextController,
     cursorColor: MyColors.myGrey,
     decoration: const InputDecoration(
       hintText: 'Find a character...',
       border: InputBorder.none,
       hintStyle: TextStyle(color: MyColors.myGrey, fontSize: 18),
     ),
     style: const TextStyle(color: MyColors.myGrey, fontSize: 18),
     onChanged: (searchedCharacter) {
       //method add search and filtering
       addSearchedFOrItemsToSearchedList(searchedCharacter);
     },
   );
 }

// searched for item search list
 void addSearchedFOrItemsToSearchedList(String searchedCharacter) {
   searchedForCharacters = allCharacters
       .where((character) =>
       character.name.toLowerCase().startsWith(searchedCharacter))
       .toList();
   setState(() {});
 }
//build appbar actions with searching
  List<Widget> _buildAppBarActions() {

   // is   not searching
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.clear, color: MyColors.myGrey),
        ),
      ];
    } else {
      // is  searching
      return [
        IconButton(
          onPressed: _startSearch,
          icon: const Icon(
            Icons.search,
            color: MyColors.myGrey,
          ),
        ),
      ];
    }
  }

  // make button back  model route
  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }
  void _stopSearching() {
    _clearSearch();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }
 @override
  void initState() {
    super.initState();
BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }
  Widget buildBlocWidget (){
    return  BlocBuilder<CharactersCubit,CharactersState>(

      builder: (context, state)  {
        if(state is CharactersLoaded){
allCharacters =(state).characters;
return buildLoadedListWidgets();
        }else{
         return showLoadingIndicator();
        }
      });

  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGrey,
        child: Column(
          children: [
            buildCharactersList(),
          ],
        ),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
itemCount:_searchTextController.text.isEmpty?  allCharacters.length:searchedForCharacters.length,

      //     : searchedForCharacters.length,
      itemBuilder: (ctx, index) {
        return  CharacterItem(character: _searchTextController.text.isEmpty
            ? allCharacters[index]
            : searchedForCharacters[index],


        ) ;
      },
    );
  }
  Widget _buildAppBarTitle() {
    return const Text(
      'Characters',
      style: TextStyle(color: MyColors.myGrey),
    );
  }
  @override


  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: MyColors.myYellow,
        title:_isSearching ? _buildSearchField() : _buildAppBarTitle() ,
        leading: _isSearching
            ? const BackButton(
          color: MyColors.myGrey,
        )
            : Container(),
        actions: _buildAppBarActions(),
      ),
      body:  buildBlocWidget(),
    ) ;
  }
}
