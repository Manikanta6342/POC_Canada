import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:poc_canada/data/about_canada_api.dart';
import 'package:poc_canada/model/about_canada.dart';

class CanadaList extends StatefulWidget {
  const CanadaList({Key? key}) : super(key: key);

  @override
  _CanadaListState createState() => _CanadaListState();
}

class _CanadaListState extends State<CanadaList> {
  late AboutCanada itemsList = AboutCanada();
  bool isLoaded = false;
  double size = 50.0;

  void getCanadaListFromService() async {
    CanadaServiceApi.getItems().then((response) {
      setState(() {
        itemsList = AboutCanada.fromJson(jsonDecode(response.body));
        for (int i = 0; i < itemsList.rows!.length; i++) {
          isLoaded = true;
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getCanadaListFromService();
  }

  Future<void> _getData() async {
    setState(() {
      getCanadaListFromService();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isLoaded ? itemsList.title.toString() : ''),
      ),
      body: !isLoaded
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: RefreshIndicator(
                onRefresh: _getData,
                child: ListView.builder(
                    itemCount: itemsList.rows!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                          title:
                              Text(itemsList.rows![index].title != null ? itemsList.rows![index].title.toString() : ''),
                          subtitle: Text(itemsList.rows![index].description != null
                              ? itemsList.rows![index].description.toString()
                              : ''),
                          leading: Container(
                            width: size,
                            height: size,
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: FadeInImage(
                              image: NetworkImage(itemsList.rows![index].imageHref.toString()),
                              placeholder: AssetImage('assets/default_picture.png'),
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.asset('assets/default_picture.png', fit: BoxFit.fitWidth);
                              },
                              fit: BoxFit.fitWidth,
                            ),
                          ));
                    }),
              ),
            ),
    );
  }
}
