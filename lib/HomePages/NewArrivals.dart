import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rentzy/HomePages/CarDetailsPages.dart';
class NewArrivals extends StatefulWidget {
   NewArrivals({super.key, this.car,});
   final List<Map<String, dynamic>>? car;
  @override
  State<NewArrivals> createState() => _NewArrivalsState();
}
class _NewArrivalsState extends State<NewArrivals> {
  @override
  Widget build(BuildContext context) {

    var mediaQueryData=MediaQuery.of(context);
    var screenheight=mediaQueryData.size.height;
    var screenwidth=mediaQueryData.size.width;

    return Scaffold(
      body: SafeArea(
          child: Column(
              children: [
                Container(
                    height: screenheight * 0.058,
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
                        SizedBox(width: screenwidth * 0.053),
                        Text("New Arrivals",style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),)
                      ],
                    )),
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left:13.0,right: 13),
                        child: ListView.builder(
                            physics: ScrollPhysics(),
                              itemCount: 7,
                              shrinkWrap: true,
                              itemBuilder: (context,index)
                              {
                                var indexCars=widget.car?[index];
                                return
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child:GestureDetector(
                                        onTap: ()
                                        {
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>CarDetailsPage(car:widget.car![index])));
                                        },
                                        child: Container(
                                          height: screenheight*0.200,
                                          width: screenwidth*0.934,
                                          color: Colors.grey.shade300,
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 10.0,top: 8.0,bottom: 8.0),
                                                child: Container(
                                                  height: screenheight*0.17,
                                                  width: screenwidth*0.35,
                                                  child:
                                                  ClipRRect(
                                                      borderRadius: BorderRadius.circular(15),
                                                      child: Image.network(indexCars?['image'],fit: BoxFit.cover,)),
                                                ),
                                              ),

                                              Padding(
                                                padding: const EdgeInsets.only(left: 15.0,top:20.0),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(indexCars?['model'],style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.w500,
                                                            color: Colors.black,
                                                            overflow: TextOverflow.ellipsis,
                                                        ),
                                                        maxLines: 1,),
                                                      ],
                                                    ),
                                                    SizedBox(height: screenheight*0.013,),
                                                    Row(
                                                      children: [
                                                        Icon(Icons.event_seat_outlined),
                                                        SizedBox(width: screenwidth*0.015,),
                                                        Text(indexCars?['seats']),
                                                        SizedBox(width: screenwidth*0.08,),
                                                        Icon(Icons.gas_meter),
                                                        Text(indexCars?['mileage'])
                                                      ],
                                                    ),
                                                    SizedBox(height: screenheight*0.013,),
                                                    Row(
                                                      children: [
                                                        Icon(Icons.currency_rupee),
                                                        SizedBox(width: screenwidth*0.015,),
                                                        Text("${indexCars?['rent']}/day"),
                                                      ],
                                                    ),
                                                    SizedBox(height: screenheight*0.013,),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        height: screenheight*0.036,
                                                        width: screenwidth*0.12,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(10),
                                                            color: Colors.grey.shade400
                                                        ),
                                                        child: Center(child:Icon(CupertinoIcons.heart)),
                                                      ),

                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 25.0),
                                                        child: Container(
                                                          height: screenheight*0.038,
                                                          width: screenwidth*0.30,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(10),
                                                              color: Colors.grey.shade400
                                                          ),
                                                          child: Center(child:Text("Explore more")),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                  ],
                                                ),
                                              )

                                            ],
                                          ),
                                        ),
                                      ) ,
                                    ),
                                  );
                              }),
                      ),
                    ),


              ],
            ),
          )
    );
  }
}
