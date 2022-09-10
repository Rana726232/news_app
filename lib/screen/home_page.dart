
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app49/model/news_model.dart';
import 'package:news_app49/screen/news_api_service_page.dart';
import 'package:news_app49/widgets/constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  // List<Articles> newsList = [];

  // @override
  // void didChangeDependencies() async {
  //   newsList = await NewsApiService().fetchNewsData();
  //   setState(() {});
  //   // print("rrrrrrrrrrrrrrr${newsList.length}");
  //   super.didChangeDependencies();
  // }
  String sortN = SortNews.popularity.name;

  int currentIndex = 1;
  @override
  // void initState() {
  //   print('our enum is ahhhhhhhhhhhhhhhhhhhhhhhhh $sortBy');
  //   // TODO: implement initState
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
        ),
        centerTitle: true,
        title: Text(
          "News App",
          style: myStyle(18, Colors.black, FontWeight.w700),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "All News",
                style: myStyle(18, Colors.black, FontWeight.w700),
              ),

              Container(
                margin: EdgeInsets.only(top: 20),
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    paginationButton(onTap: () {}, title: "Prev"),
                    Flexible(
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 12),
                                child: MaterialButton(
                                  color: index + 1 == currentIndex
                                      ? Colors.blue
                                      : Colors.amber,
                                  minWidth: 30,
                                  onPressed: () {
                                    setState(() {
                                      currentIndex = index + 1;
                                    });
                                  },
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Text("${index + 1}"),
                                ),
                              );
                            })),
                    paginationButton(onTap: () {}, title: "Next"),
                  ],
                ),
              ),
              SizedBox(height: 15,),
               Column( crossAxisAlignment: CrossAxisAlignment.end,
                 children: [

                   DropdownButton<String>(
                       value: sortN,
                       items: [
                         DropdownMenuItem(
                           child: Text("${SortNews.popularity.name}"),
                           value: SortNews.popularity.name,
                         ),
                         DropdownMenuItem(
                           child: Text("${SortNews.publishedAt.name}"),
                           value: SortNews.publishedAt.name,
                         ),
                         DropdownMenuItem(
                           child: Text("${SortNews.relevancy.name}"),
                           value: SortNews.relevancy.name,
                         ),
                       ],
                       onChanged: (value) {
                         setState(() {
                           sortN = value!;
                         });
                         print("drop down value is $sortN");
                       }),
                   Container(
                     height:500,
                     width: double.infinity,
                     child:FutureBuilder<List<Articles>>(
                         future: NewsApiService.fetchNewsData(page: currentIndex, sotBy: sortN),
                       builder: (context,snapshot){
                         if (snapshot.connectionState == ConnectionState.waiting){
                           return Center(child: CircularProgressIndicator(color: Colors.amber,));
                         }
                         // else if (snapshot.hasError){
                         //   return ErroScreen();
                         // }


                           return ListView.builder(
                               shrinkWrap: true,
                               itemCount: snapshot.data!.length,
                               itemBuilder: (context, index) {

                                 return Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Stack(
                                     children: [
                                       Container(
                                         decoration: BoxDecoration(
// color: Colors.amber,
                                         ),

                                         height: 140,
                                         width: double.infinity,

                                         child: Expanded(
                                             child: Row(
                                               children: [
                                                 Expanded(
                                                   child: Padding(
                                                     padding: const EdgeInsets.all(20.0),
                                                     child: Container(
                                                       height:120,
                                                       width: 120,
                                                       decoration: BoxDecoration(
                                                           borderRadius: BorderRadius.circular(10),
                                                           image: DecorationImage(
                                                               fit:BoxFit.cover,image:NetworkImage('${snapshot.data![index].urlToImage}'))),),
                                                   ),
                                                 ),
                                                 Expanded(child:Padding(
                                                   padding: const EdgeInsets.only(right: 10.0),
                                                   child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                                     children: [
                                                       Text('${snapshot.data![index].title}',style: myStyle(12,Colors.black),),
                                                       SizedBox(height: 15,),
                                                       Text('${snapshot.data![index].publishedAt}',style: myStyle(12,Colors.black)  ,)
                                                     ],
                                                   ),
                                                 ) )



                                               ],
                                             )
                                         ),
                                       ),
                                       Positioned(
                                         top: 0,
                                         left: 0,
                                         child: Container(
                                             padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                             height:70,
                                             width: 10,
                                             color:Color(0xff79A4B0)
                                         ),),
                                       Positioned(
                                           child: Container(
                                             width: 70,
                                             height: 10,
                                             color: Color(0xff79A4B0),
                                           )),
                                       Positioned(
                                         bottom: 0,
                                         right: 0,

                                         child: Container(
                                             height:70,
                                             width: 10,
                                             color:Color(0xff79A4B0)
                                         ),),
                                       Positioned(
                                         bottom: 0,
                                         right: 0,

                                         child: Container(
                                             height:10,
                                             width: 70,
                                             color:Color(0xff79A4B0)
                                         ),),

                                     ],
                                   ),
                                 );
                               });
                       },

                     ),
                   ),
                 ],
               ),

            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton paginationButton({VoidCallback? onTap, String? title}) {
    return ElevatedButton(
        onPressed: onTap,
        child: Text(
          "$title",
          style: myStyle(14, Colors.white),
        ));
  }
}
enum SortNews { publishedAt, popularity, relevancy }