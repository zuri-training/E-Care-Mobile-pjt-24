import 'dart:convert';

import 'package:e_care_mobile/models/healthmodel.dart';
import 'package:e_care_mobile/services/api.dart';
import 'package:e_care_mobile/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'profile/widgets/appbartwo.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({Key key}) : super(key: key);

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

AuthService _authService = AuthService();

class _ArticleScreenState extends State<ArticleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: lightgreen,
        title: Text('Health News'),
      ),
      body: FutureBuilder<List<Articles>>(
        future: _authService.getHealthNews(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return SnackBar(content: Text('No news to show'));
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) => ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      snapshot.data[index].urlToImage == null
                          ? ""
                          : snapshot.data[index].urlToImage),
                ),
                title: Text(snapshot.data[index].title == null
                    ? ""
                    : snapshot.data[index].title),
                subtitle: Text(snapshot.data[index].author == null
                    ? ""
                    : snapshot.data[index].author),
                trailing: IconButton(
                    icon: Icon(Icons.launch),
                    onPressed: () async {
                      await canLaunch(snapshot.data[index].url)
                          ? launch(snapshot.data[index].url)
                          : throw "cant load that data";
                    }),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
