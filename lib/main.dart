import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies_app/core/resources/app_router.dart';
import 'package:movies_app/core/services/service_locator.dart';
import 'package:movies_app/core/resources/app_strings.dart';
import 'package:movies_app/core/resources/app_theme.dart';
import 'package:movies_app/movies/presentation/controllers/movies_bloc/movies_bloc.dart';
import 'package:movies_app/movies/presentation/controllers/movies_bloc/movies_event.dart';
import 'package:movies_app/tv_shows/presentation/controllers/tv_shows_bloc/tv_shows_bloc.dart';
import 'package:movies_app/watchlist/data/models/watchlist_item_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movies_app/watchlist/presentation/controllers/watchlist_bloc/watchlist_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  await Hive.initFlutter();
  Hive.registerAdapter(WatchlistItemModelAdapter());
  await Hive.openBox<WatchlistItemModel>('items');

  ServiceLocator.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<MoviesBloc>()..add(GetMoviesEvent()),
        ),
        BlocProvider(
          create: (context) => sl<TVShowsBloc>()..add(GetTVShowsEvent()),
        ),
        BlocProvider(
          create: (context) =>
              sl<WatchlistBloc>()..add(GetWatchListItemsEvent()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appTitle,
      theme: getApplicationTheme(),
      routerConfig: AppRouter.router,
    );
  }
}
