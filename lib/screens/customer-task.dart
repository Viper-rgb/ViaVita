import 'package:flutter/material.dart';

class customertask extends StatefulWidget {
  const customertask({super.key});

  @override
  State<customertask> createState() => _customertaskState();
}

class _customertaskState extends State<customertask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
          
        ),
        title: Text("Veiw Details",style: TextStyle(fontSize: 15,color: Colors.black),),

    ),

    body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(crossAxisAlignment: .start,
            children: [
              Row(mainAxisAlignment: .spaceBetween,
                children: [
                  Text("Suresh Kumar",style: TextStyle(fontSize: 30,),),
                  SizedBox(width: 30,),
                  Container(
                    height: 20,
                    width: 80,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 225, 207, 197),
                      borderRadius: BorderRadius.circular(15),
                      
                    ),
                    child: Center(child: Text("Painting", style: TextStyle( fontFamily:'serif' ,color: const Color.fromARGB(255, 207, 75, 35)),)),
          
                
                  ),
                ]
          ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
          
                      Icon(Icons.wallet),
                      Text("Budget",),
                      SizedBox(width: 8,),
                      Text("15,000\$",style: TextStyle(fontSize: 20,fontFamily: 'serif',fontWeight: FontWeight.w300),)
                    ],
                    
                  ),
                  SizedBox(height: 12,),
                  Row(
                    children: [
                      Icon(Icons.map_sharp),
                      SizedBox(width:8),
                      Text("Location-Coimbatore",style:TextStyle(fontWeight: FontWeight.w200 ),)
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
            children: [
          
              Icon(Icons.calendar_today_outlined),
          
              SizedBox(width:8),
          
              Text("Expected Deadline - 20 September, 2025")
          
            ],
          ),
        
           SizedBox(height: 30,),
           Text("Description",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10,),
          Text(
            "",
          ),
          Text(
                "We need a skilled carpenter to build and install a custom wooden wardrobe and kitchen shelves. The work includes precise measurements, cutting, assembling, and polishing. All materials will be provided, but high-quality craftsmanship is expected. The job should be completed within 5 days with a neat finish.",
                style: TextStyle(
          fontSize: 15,
          color: Colors.grey.shade700,
          height: 1.5, // Line spacing
                ),
                textAlign: TextAlign.left,
                softWrap: true,
              ),
              SizedBox(height: 20,),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [ Color(0xFFFB8C00), Colors.deepOrange],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Add Requirements",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
              
                ],
              ),
        ),
            
          
        ),
      ),
    );
    
    
  }
}