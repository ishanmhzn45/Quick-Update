import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:quick_update/models/categories_models.dart';
import 'package:quick_update/view_model/news_view_model.dart';
import 'package:quick_update/screen/news_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  NewsViewModel newsViewModel = NewsViewModel();

  final format = DateFormat('MMMM dd, yyyy');
  String categoryName = 'General';

  List<String> categoriesList = [
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technology',
  ];
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        scrolledUnderElevation: 0,
        title: Image.asset('images/QUICKUPDATE.png',),
      ),
      body: Column(
        children: [
          SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoriesList.length,
                itemBuilder: (context, index){
                  return InkWell(
                    onTap: () {
                      categoryName = categoriesList[index];
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12, top: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          border: categoryName == categoriesList[index] ? const Border(bottom: BorderSide(
                            color: Color.fromRGBO(255, 234, 147, 100),
                          )):  const Border()
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Center(child: Text(categoriesList[index].toString(), style: GoogleFonts.poppins(
                            fontSize: categoryName == categoriesList[index] ? 25 : 16,
                            color: categoryName == categoriesList[index] ? const Color.fromRGBO(255, 234, 147, 100) : const Color.fromRGBO(146, 146, 146, 100)
                          ),)),
                        ),
                      ),
                    ),
                  );
                }
              ),
            ),
            const SizedBox(height: 20,),
            Expanded(
              child: RefreshIndicator(
                color: Color.fromRGBO(255, 234, 147, 100),
                onRefresh: () async {
                  setState(() {
                    
                  });
                },
                child: FutureBuilder<CategoriesNewsModel>(
                  future: newsViewModel.fetchCategoriesNewsApi(categoryName), 
                  builder: (BuildContext context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const Center(
                        child: SpinKitCircle(
                          size: 50,
                          color: Color.fromRGBO(255, 234, 147, 100),
                        ),
                      );
                    }else if(snapshot.hasError){
                      return Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12)
                          ),
                          child: const Padding(
                            padding:  EdgeInsets.all(16.0),
                            child:  Text('No Internet Connection',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            ),
                          ),
                        )
                      );
                    }else{
                      return ListView.builder(
                        itemCount: snapshot.data!.articles!.length,
                        itemBuilder: (context, index){
                          DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                          return InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetailScreen(
                                  newsImage: snapshot.data!.articles![index].urlToImage.toString(), 
                                  newsTitle: snapshot.data!.articles![index].title.toString(), 
                                  newsData: snapshot.data!.articles![index].publishedAt.toString(), 
                                  author: snapshot.data!.articles![index].author.toString(), 
                                  description: snapshot.data!.articles![index].description.toString(), 
                                  content: snapshot.data!.articles![index].content.toString(), 
                                  source: snapshot.data!.articles![index].source!.name.toString(),
                              )));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Row(
                                children: [
                                  ClipRRect(
                                        // borderRadius: BorderRadius.circular(15),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 8),
                                          child: CachedNetworkImage(
                                            imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                            fit: BoxFit.cover,
                                            height: height * .18,
                                            width: width *.3,
                                            placeholder: (context, url) => const  Center(
                                              child: SpinKitCircle(
                                                size: 50,
                                                color: Color.fromRGBO(255, 234, 147, 100),
                                              ),
                                            ),
                                            errorWidget: (context, url, eror) =>  const Center(child: Text("Image Not Found!", style: TextStyle(color: Colors.red),)),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 8),
                                          child: Container(
                                            decoration:const  BoxDecoration(
                                              borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
                                              color: Color.fromRGBO(70, 70, 70, 100),
                                            ),
                                            height: height * .18,
                                            padding: const EdgeInsets.only(left: 15),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Text(snapshot.data!.articles![index].title.toString(), 
                                                  maxLines: 3,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 15,
                                                    color: const Color.fromRGBO(255, 234, 147, 100),
                                                    fontWeight: FontWeight.w700
                                                  ),
                                                  ),
                                                  const Spacer(),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(snapshot.data!.articles![index].source!.name.toString(), 
                                                      maxLines: 3,
                                                      style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        color: Colors.white70,
                                                        fontWeight: FontWeight.w600
                                                      ),
                                                      ),
                                                      Text(format.format(dateTime), 
                                                      style: GoogleFonts.poppins(
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.w500
                                                      ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                ],
                              ),
                            ),
                          );
                        }
                      );
                    }
                  }
                ),
              ),
            ),
        ],
      ),

    );
  }
}

