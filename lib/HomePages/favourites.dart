import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rentzy/HomePages/CarDetailsPages.dart';

import '../Database/favouritesdetails.dart';
class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});


  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {

  List<Map<String,dynamic>>loadFavourites=[];

  @override
  void initState() {
    super.initState();
    GetFavourites();

  }

  Future<void>GetFavourites() async
  {
    List<Map<String, dynamic>> favs = await FavouriteDetails().FetchFavouritesDetails();
    setState(() {
      loadFavourites=favs;

    });
  }
  @override
  Widget build(BuildContext context) {

    var mediaQueryData=MediaQuery.of(context);
    var screenheight=mediaQueryData.size.height;
    var screenwidth=mediaQueryData.size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: Text("My Wishlist",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
      ),
      body: SafeArea(
          child: loadFavourites.isEmpty?Center(
            child:Lottie.asset("assets/animations/Animation - 1743144677149.json"),
          ):Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: GridView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.normal),
                itemCount:loadFavourites.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                    crossAxisSpacing: screenheight * 0.0060,
                    mainAxisSpacing: screenheight * 0.010,
                    mainAxisExtent: screenheight * 0.30,
                    childAspectRatio: 1.0),
                itemBuilder: (context,index)
                {
                   var favdetails=loadFavourites[index];
                  return   Padding(
                    padding: const EdgeInsets.only(left:10.0,right: 9.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(22),
                      child: GestureDetector(
                        onTap: ()
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>CarDetailsPage(car: favdetails)));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white60,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(22),topRight: Radius.circular(22)),
                                    child:Stack(
                                        children:[
                                          Container(
                                            height:screenheight *0.19,
                                            width: screenwidth *0.445 ,
                                            color: Colors.grey,
                                            child: Image.network(favdetails['image'],fit:BoxFit.cover,)
                                          ),
                                          Positioned(
                                            left: screenwidth*0.34,
                                            bottom: screenheight *0.142,

                                            child: Container(
                                                height:screenheight*0.035,
                                                width: screenwidth *0.098,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey.shade300,
                                                    shape: BoxShape.circle
                                                ),
                                                child:Icon(CupertinoIcons.heart_solid,color: Colors.red,size: 18,)
                                            ),
                                          )
                                        ]
                                    ) ,
                                  )
                                ],
                              ),
                              SizedBox(height: screenheight*0.011,),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Row(
                                  children: [
                                    Expanded(child: Text(favdetails['model'],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black,overflow: TextOverflow.ellipsis),maxLines: 1,)),

                                  ],
                                ),
                              ),
                              SizedBox(height: screenheight*0.002,),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Row(
                                  children: [
                                    Text("4.9",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.grey),),
                                    SizedBox(width: screenwidth*0.012,),
                                    Icon(CupertinoIcons.star_fill,color:Colors.yellow,size: 17,)
                                  ],
                                ),
                              ),

                              SizedBox(height: screenheight*0.002,),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.event_seat_outlined,color: Colors.grey,size: 17,),
                                    SizedBox(width: screenwidth*0.012,),
                                    Text(favdetails['seats'],style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.grey)),
                                    Spacer(),
                                    Icon(Icons.currency_rupee,color: Colors.grey,size: 17,),
                                    Text("${favdetails['rent']}/day",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.grey))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),


                    ),
                  );

                }),
          )),
    );
  }
}
