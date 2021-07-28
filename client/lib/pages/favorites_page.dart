import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/favorite_card.dart';
import '../provider/favorites_provider.dart';
import '../model/menu.dart';
import '../data/api/apiService.dart';
import '../widgets/platform_widget.dart';
import '../utility/provider_state.dart';
import '../common/navigation.dart';

class FavoritesPage extends StatelessWidget {
  static String routeName = 'favorites_page';
  String email;
  FavoritesPage({required this.email});

  Widget _buildItem() {
    return Builder(
      builder: (BuildContext newContext) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(newContext).accentColor,
            elevation: 0.0,
            leading: IconButton(
              onPressed: () {
                Navigation.back();
              },
              icon: Icon(Icons.arrow_back),
            ),
          ),
          backgroundColor: Theme.of(newContext).accentColor,
          body: Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 25.0,
            ),
            decoration: BoxDecoration(
              color: Theme.of(newContext).primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Favorites,',
                  style: TextStyle(
                    fontSize: 22.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    bottom: 15.0,
                  ),
                  child: Text(
                    'Total: ${Provider.of<FavoritesProvider>(newContext).favoritesLength} items',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Consumer<FavoritesProvider>(
                  builder: (context, state, _) {
                    if (state.state == ResultState.Loading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state.state == ResultState.HasData) {
                      return state.nestedUserFavorites.length == 0
                          ? Center(
                              child: Text(
                                'No items to display...',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            )
                          : Container(
                              height: 470.0,
                              child: ListView.builder(
                                itemCount: state.nestedUserFavorites.length,
                                itemBuilder: (context, index) {
                                  var favorites =
                                      state.nestedUserFavorites[index];
                                  return IntrinsicHeight(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children:
                                            favorites.map<FavoriteCard>((data) {
                                          var menu = Menu.fromJson(data);
                                          return FavoriteCard(
                                            menu: menu,
                                            onPressed:
                                                Provider.of<FavoritesProvider>(
                                                        context)
                                                    .deleteOneFavorite,
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                    } else if (state.state == ResultState.NoData) {
                      return Center(child: Text(state.message));
                    } else if (state.state == ResultState.Error) {
                      return Center(child: Text(state.message));
                    } else {
                      return Center(child: Text(''));
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return ChangeNotifierProvider<FavoritesProvider>(
      create: (_) => FavoritesProvider(apiService: ApiService(), email: email),
      child: _buildItem(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildAndroid,
    );
  }
}
