import 'package:flutter/material.dart';
import 'Clothing.dart';
import 'ClothingDetailPage.dart';
import 'ClothingService.dart';

class ClothingListPage extends StatefulWidget {
  @override
  _ClothingListPageState createState() => _ClothingListPageState();
}

class _ClothingListPageState extends State<ClothingListPage>
    with SingleTickerProviderStateMixin {
  final ClothingService _clothingService = ClothingService();
  List<String> _categories = ["Tous", "T-Shirts", "Pantalons", "Chaussures"];
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _categories.length);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Choisissez votre vêtement',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: _categories
              .map((category) => Tab(
                    text: category.toUpperCase(),
                  ))
              .toList(),
        ),
        centerTitle: true,
      ),
      body: TabBarView(
        controller: _tabController,
        children: _categories.map((category) {
          return StreamBuilder<List<Clothing>>(
            stream: _clothingService.getClothingStream(category: category),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Oops, quelque chose s\'est mal passé!'),
                );
              }

              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              final clothingList = snapshot.data!;

              return ListView.builder(
                itemCount: clothingList.length,
                itemBuilder: (context, index) {
                  final clothing = clothingList[index];

                  if (category == "Tous" || clothing.category == category) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ClothingDetailPage(clothing: clothing),
                          ),
                        );
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                clothing.imageUrl,
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: 16.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      clothing.name,
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Text(
                                      '${clothing.price} €',
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
