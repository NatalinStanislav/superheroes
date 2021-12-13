import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:superheroes/blocs/main_bloc.dart';
import 'package:superheroes/pages/superhero_page.dart';
import 'package:superheroes/resources/superheroes_images.dart';
import 'package:superheroes/resources/superheroes_colors.dart';
import 'package:superheroes/widgets/action_button.dart';
import 'package:superheroes/widgets/info_with_button.dart';
import 'package:superheroes/widgets/superhero_card.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final MainBloc bloc = MainBloc();

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: bloc,
      child: Scaffold(
        backgroundColor: SuperheroesColors.background,
        body: SafeArea(
          child: MainPageContent(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}

class MainPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MainBloc bloc = Provider.of<MainBloc>(context);
    return Stack(
      children: [
        MainPageStateWidget(),
        Align(
          alignment: Alignment.bottomCenter,
          child:
              ActionButton(text: "Next state", onTap: () => bloc.nextState()),
        )
      ],
    );
  }
}

class MainPageStateWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MainBloc bloc = Provider.of<MainBloc>(context);

    return StreamBuilder<MainPageState>(
      stream: bloc.observeMainPageState(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return SizedBox();
        }
        final MainPageState state = snapshot.data!;
        switch (state) {
          case MainPageState.loading:
            return LoadingIndicator();
          case MainPageState.noFavorites:
            return InfoWithButton(
              title: "No favorites yet",
              subtitle: "Search and add",
              buttonText: "Search",
              assetImage: SuperheroesImages.ironman,
              imageHeight: 119,
              imageWidth: 108,
              imageTopPadding: 9,
            );
          case MainPageState.minSymbols:
            return MinSymbolsStateWidget();
          case MainPageState.nothingFound:
            return InfoWithButton(
              title: "Nothing found",
              subtitle: "Search for something else",
              buttonText: "Search",
              assetImage: SuperheroesImages.hulk,
              imageHeight: 119,
              imageWidth: 108,
              imageTopPadding: 9,
            );
          case MainPageState.loadingError:
            return InfoWithButton(
              title: "Error happened",
              subtitle: "Please, try again",
              buttonText: "Retry",
              assetImage: SuperheroesImages.superman,
              imageHeight: 119,
              imageWidth: 108,
              imageTopPadding: 9,
            );
          case MainPageState.searchResults:
            return SearchResultsStateWidget();
          case MainPageState.favorites:
            return FavoritesStateWidget();
          default:
            return Center(
                child: Text(
              state.toString(),
              style: TextStyle(color: Colors.white),
            ));
        }
      },
    );
  }
}

class SearchResultsStateWidget extends StatelessWidget {
  const SearchResultsStateWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 90),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Search results",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 24,
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SuperheroCard(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SuperheroPage(name: "Batman"),
                  ),
                );
              },
              imageUrl:
                  "https://www.superherodb.com/pictures2/portraits/10/100/639.jpg",
              name: "Batman",
              realName: "Bruce Wayne",
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SuperheroCard(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SuperheroPage(name: "Venom"),
                  ),
                );
              },
              imageUrl:
                  "https://www.superherodb.com/pictures2/portraits/10/100/22.jpg",
              name: "Venom",
              realName: "Eddie Brock",
            ),
          ),
        ],
      ),
    );
  }
}

class FavoritesStateWidget extends StatelessWidget {
  const FavoritesStateWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 90),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Your favorites",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 24,
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SuperheroCard(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SuperheroPage(name: "Batman"),
                  ),
                );
              },
              imageUrl:
                  "https://www.superherodb.com/pictures2/portraits/10/100/639.jpg",
              name: "Batman",
              realName: "Bruce Wayne",
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SuperheroCard(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SuperheroPage(name: "Ironman"),
                  ),
                );
              },
              imageUrl:
                  "https://www.superherodb.com/pictures2/portraits/10/100/85.jpg",
              name: "Ironman",
              realName: "Tony Stark",
            ),
          ),
        ],
      ),
    );
  }
}

class MinSymbolsStateWidget extends StatelessWidget {
  const MinSymbolsStateWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: 110),
        child: Text(
          "Enter at least 3 symbols",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: 110),
        child: CircularProgressIndicator(
          color: SuperheroesColors.blue,
          strokeWidth: 4,
        ),
      ),
    );
  }
}
