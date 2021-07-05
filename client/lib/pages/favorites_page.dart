import 'package:flutter/material.dart';
import '../components/favorite_card.dart';
import 'package:provider/provider.dart';
import '../provider/user_favorites.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(246, 246, 246, 1),
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        backgroundColor: Color.fromRGBO(246, 246, 246, 1),
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 25.0,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
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
                  'Total: ${Provider.of<FavoritesProvider>(context).favoritesLength} items',
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
                    return state.userFavorites?.length == 0
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
                              itemCount: state.userFavorites?.length,
                              itemBuilder: (context, index) {
                                var favorites = state.userFavorites?[index];
                                return IntrinsicHeight(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children:
                                          favorites.map<FavoriteCard>((data) {
                                        return FavoriteCard(
                                          title: data['title'],
                                          price: data['price'],
                                          imageUrl: data['imageUrl'],
                                          rating: data['rating'],
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
        ));
  }
}
