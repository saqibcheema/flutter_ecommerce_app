import 'package:flutter/material.dart';
import 'Models/cs.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EcomerceApi extends StatefulWidget {
  const EcomerceApi({super.key});

  @override
  State<EcomerceApi> createState() => _EcomerceApiState();
}

class _EcomerceApiState extends State<EcomerceApi> {
  String headerImage =
      "https://images.unsplash.com/photo-1529655683826-aba9b3e77383?auto=format&fit=crop&w=1000&q=80";

  Future<List<Ecomercejson>> getecomerce() async {
    List<Ecomercejson> getApi = [];
    var response = await http.get(
      Uri.parse('https://fakestoreapi.com/products'),
    );
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        getApi.add(Ecomercejson.fromJson(i));
      }
      return getApi;
    } else {
      return getApi;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<Ecomercejson>>(
          future: getecomerce(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error loading data"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("No data found"));
            }

            return CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.teal.shade600,
                  pinned: true,
                  stretch: true,
                  expandedHeight: 200.0,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text('Ecommerce Api',style: TextStyle(fontWeight: FontWeight.bold),),
                    stretchModes: [
                      StretchMode.zoomBackground,
                      StretchMode.fadeTitle,
                      StretchMode.blurBackground
                    ],
                    background: DecoratedBox(
                      position: DecorationPosition.foreground,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                            end: Alignment.center,
                            colors: [
                              Colors.teal.shade800,
                              Colors.transparent
                            ]
                        )
                      ),
                      child: Image.network(headerImage, fit: BoxFit.cover),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.all(10),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Image.network(
                                snapshot.data![index].image.toString(),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Divider(color: Colors.grey, thickness: 1),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.all(4),
                                child: ListTile(
                                  title: Text(
                                    snapshot.data![index].title ?? '',
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width >
                                                  600
                                              ? 11
                                              : 14,
                                    ),
                                    maxLines: 2,
                                  ),
                                  trailing: Text(
                                    '   Price\n ${snapshot.data![index].price.toString()} \$',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }, childCount: snapshot.data!.length),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.6,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
