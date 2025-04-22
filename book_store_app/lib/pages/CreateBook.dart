import 'package:flutter/material.dart';

class Createbook extends StatefulWidget {
  const Createbook({super.key});

  @override
  State<Createbook> createState() => _CreatebookState();
}

class _CreatebookState extends State<Createbook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Book Posts"),
        centerTitle: true,

      ),
      body:  Column(
          children: [


          Card(
            borderOnForeground:true ,
            child: Text("HEELO"),

          ),



            SizedBox(
              height: 20,
            ),
            Text("Title"),

            Container(
              margin: EdgeInsets.only(left: 10,right: 10),
              child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter title" ,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                      
                    )
                  ),
              
              ),
            ),
             SizedBox(
              height: 20,
            ),
            Text("Author"),

            Container(
              margin: EdgeInsets.only(left: 10,right: 10),
              child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter Author name" ,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                      
                    )
                  ),
              
              ),
            ),
             SizedBox(
              height: 20,
            ),
            Text("Title"),

            Container(
              margin: EdgeInsets.only(left: 10,right: 10),
              child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter title" ,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                      
                    )
                  ),
              
              ),
            ),
             SizedBox(
              height: 20,
            ),
            Text("Category"),

            Container(
              margin: EdgeInsets.only(left: 10,right: 10),
              child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter Category" ,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                      
                    )
                  ),
              
              ),
            ),
             SizedBox(
              height: 20,
            ),
            Text("Description"),

            Container(
              margin: EdgeInsets.only(left: 10,right: 10),
              child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter description" ,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                      
                    )
                  ),
              
              ),
            ),
             SizedBox(
              height: 20,
            ),
            Text("price"),

            Container(
              margin: EdgeInsets.only(left: 10,right: 10),
              child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter price" ,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                      
                    )
                  ),
              
              ),
            ), SizedBox(
              height: 30,
            ),
           ElevatedButton(
                onPressed: () {
                 
                   
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(400, 60),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: const Color.fromARGB(255, 41, 163, 45),
                    side: BorderSide(color: Colors.black, width: 2)),
                child: Text(
                  "Create Book",
                  style: TextStyle(
                      color: const Color.fromARGB(255, 225, 222, 222),
                      fontSize: 20.0),
                ))
          ],
        ),
      
    );
  }
}