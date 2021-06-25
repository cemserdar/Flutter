import 'package:blog_uygulamasi/views/create_blog.dart';
import 'package:blog_uygulamasi/services/crud.dart';
import 'package:blog_uygulamasi/views/create_blog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CrudMethods crudMethods = new CrudMethods();

  QuerySnapshot? blogsSnapshot;

  Widget BlogList() {
    return Container(
      child: blogsSnapshot != null
          ? Column(children: <Widget>[
              ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemCount: blogsSnapshot!.documents.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return BlogsTile(
                      yazar: blogsSnapshot!.documents[index].data['YazarAdı'],
                      metin: blogsSnapshot!.documents[index].data['Metin'],
                      aciklama:
                          blogsSnapshot!.documents[index].data['Açıklama'],
                      imgUrl:
                          blogsSnapshot!.documents[index].data['Resimİndir'],
                    );
                  }),
            ])
          : Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
    );
  }

  @override
  void initState() {
    super.initState();

    crudMethods.getData().then((result) {
      blogsSnapshot = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Flutter",
              style: TextStyle(fontSize: 22),
            ),
            Text(
              "Blog",
              style: TextStyle(fontSize: 22, color: Colors.blue),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: BlogList(),
      floatingActionButton: Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FloatingActionButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CreateBlog()));
                },
                child: Icon(Icons.add),
              )
            ],
          )),
    );
  }
}

class BlogsTile extends StatelessWidget {
  String imgUrl, metin, aciklama, yazar;
  BlogsTile(
      {required this.imgUrl,
      required this.metin,
      required this.aciklama,
      required this.yazar});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      height: 150,
      child: Stack(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                imgUrl,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              )),
          Container(
            height: 170,
            decoration: BoxDecoration(
                color: Colors.black45.withOpacity(0.3),
                borderRadius: BorderRadius.circular(6)),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  metin,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  aciklama,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(yazar),
              ],
            ),
          )
        ],
      ),
    );
  }
}
