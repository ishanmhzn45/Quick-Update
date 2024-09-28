import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewsDetailScreen extends StatefulWidget {
 final String newsImage, newsTitle, newsData, author, description, content, source;
  const NewsDetailScreen({
    super.key,
    required this.newsImage,
    required this.newsTitle,
    required this.newsData,
    required this.author,
    required this.description,
    required this.content,
    required this.source,
    });

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  final format = DateFormat('MMMM dd, yyyy');
  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    DateTime dateTime = DateTime.parse(widget.newsData);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SizedBox(
            height: height * .45,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: CachedNetworkImage(
                imageUrl: widget.newsImage,
                fit: BoxFit.cover,
                placeholder: (context, ulr) => const Center( child: CircularProgressIndicator(),),
                errorWidget: (context, url, eror) =>  const Center(child: Text("Image Not Found", style: TextStyle(color: Colors.red),)),
              ),
            ),
          ),
          Container(
            height: height * .6,
            margin: EdgeInsets.only(top: height * .4),
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 19, 19, 19),
              borderRadius:  BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: ListView(
              children: [
                Text(widget.newsTitle,
                style: GoogleFonts.poppins(fontSize: 20, color: const Color.fromRGBO(255, 234, 147, 100), fontWeight: FontWeight.w700),
                ),
                SizedBox(height: height * .02,),
                Row(
                  children: [
                    Expanded(
                      child: Text( widget.source,
                      style: GoogleFonts.poppins(fontSize: 20, color: Colors.white70, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Text( format.format(dateTime),
                    style: GoogleFonts.poppins(fontSize: 12, color: Colors.white70, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                SizedBox(height: height * .03,),
                Text(widget.description,
                    style: GoogleFonts.poppins(fontSize: 15, color: Colors.white70, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: height * .03,),
                Text(widget.content,
                    style: GoogleFonts.poppins(fontSize: 15, color: Colors.white70, fontWeight: FontWeight.w500),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}