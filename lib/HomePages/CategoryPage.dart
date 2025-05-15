
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CarDetailsPages.dart';
class CategoryPage extends StatefulWidget {
  CategoryPage({super.key, required this.car, required this.name,});
  final List<Map<String, dynamic>>? car;
  final String name;


  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {

    var mediaQueryData = MediaQuery.of(context);
    var screenHeight = mediaQueryData.size.height;
    var screenWidth = mediaQueryData.size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
          child: Column(
            children: [
              Container(
                  height: screenHeight * 0.058,
                  width: double.infinity,
                  color: Colors.white60,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: GestureDetector(
                          onTap: ()
                          {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            size: 23,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.053),
                      Text(widget.name,style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),)
                    ],
                  )
              ),
              SizedBox(height: screenHeight*0.0130,),
              Expanded(
                child: GridView.builder(
                    physics: BouncingScrollPhysics(
                      decelerationRate: ScrollDecelerationRate.fast
                    ),
                    itemCount: widget.car?.length,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: screenHeight * 0.0040,
                        mainAxisSpacing: screenHeight * 0.020,
                        mainAxisExtent: screenHeight * 0.30,
                        childAspectRatio: 1.0,),
                      itemBuilder: (context,index)
                  {
                    var carModels=widget.car?[index];
                    return Padding(
                      padding: const EdgeInsets.only(left:10.0,right: 9.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(22),
                        child: GestureDetector(
                          onTap: ()
                          {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context)=>CarDetailsPage(car:widget.car![index],)));
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
                                                height:screenHeight *0.19,
                                                width: screenWidth *0.447 ,
                                                color: Colors.grey,
                                                child: Image.network(carModels?['image'],fit:BoxFit.cover,)
                                            ),
                                            Positioned(
                                              left: screenWidth*0.34,
                                              bottom: screenHeight *0.142,

                                              child: Container(
                                                height:screenHeight*0.035,
                                                width: screenWidth *0.098,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey.shade300,
                                                    shape: BoxShape.circle
                                                ),
                                                child:Icon(
                                                  CupertinoIcons.suit_heart,
                                                  color: Colors.black,
                                                  size: 18,
                                                ),
                                              ),
                                            )
                                          ]
                                      ) ,
                                    )
                                  ],
                                ),
                                SizedBox(height: screenHeight*0.011,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Row(
                                    children: [
                                      Expanded(child: Text(carModels?['model'],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black,overflow: TextOverflow.ellipsis),maxLines: 1,)),

                                    ],
                                  ),
                                ),
                                SizedBox(height: screenHeight*0.002,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Row(
                                    children: [
                                      Text(carModels?['rating'],style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.grey),),
                                      SizedBox(width: screenWidth*0.012,),
                                      Icon(CupertinoIcons.star_fill,color:Colors.yellow,size: 17,)
                                    ],
                                  ),
                                ),

                                SizedBox(height: screenHeight*0.002,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.event_seat_outlined,color: Colors.grey,size: 17,),
                                      SizedBox(width: screenWidth*0.012,),
                                      Text(carModels?['seats'],style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.grey)),
                                      Spacer(),
                                      Icon(Icons.currency_rupee,color: Colors.grey,size: 17,),
                                      Text("${carModels?['rent']}/day",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.grey))

                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),


                      ),
                    );
                  }),
              ),

            ],
          )),
    );
  }
}
