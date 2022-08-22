import 'package:breaking_bad_app/business_logic/cubit/charachters_cubit.dart';
import 'package:breaking_bad_app/constants/strings.dart';
import 'package:breaking_bad_app/data/models/characters.dart';
import 'package:breaking_bad_app/data/repository/characters_repository.dart';
import 'package:breaking_bad_app/data/web_services/characters_web_services.dart';
import 'package:breaking_bad_app/presentation/screens/characters_details_screen.dart';

import 'package:breaking_bad_app/presentation/screens/characters_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class AppRouter{

  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;

  AppRouter() {
  charactersRepository = CharactersRepository(CharactersWebServices());
  charactersCubit = CharactersCubit(charactersRepository);
  }
  Route? generateRoute(RouteSettings setting ){




    switch (setting.name){

      case charactersScreen :
        return MaterialPageRoute(
          builder:(_)=> BlocProvider(
create:(BuildContext context)=>charactersCubit,
child:const CharactersScreen() ,

          ),
        );
      case characterDetailsScreen :
        final character = setting.arguments as Character;
        return MaterialPageRoute(

          builder:(_)=> BlocProvider(
            create:(BuildContext context)=> CharactersCubit(charactersRepository) ,
            child: CharacterDetailsScreen( character: character,),          )
        );


  }








  }}
