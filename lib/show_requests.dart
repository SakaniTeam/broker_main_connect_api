import 'package:abdo/home_page.dart';
import 'package:flutter/material.dart';

class ShowRequest extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ShowRequest> {
  List requests = [];
  List user = [];

  bool isloading = true;
  // User? currentUser = FirebaseAuth.instance.currentUser;

  // void getrequest() async {
  //   CollectionReference tblProduct =
  //       FirebaseFirestore.instance.collection('requests');
  //   await Future.delayed(Duration(seconds: 2));
  //   await tblProduct.get().then((querySnapshot) {
  //     querySnapshot.docs.forEach((doc) {
  //       Map<String, dynamic> store = doc.data() as Map<String, dynamic>;
  //       store['documentId'] = doc.id;
  //       requests.add(store);
  //     });
  //     isloading = false;
  //     setState(() {});
  //   });
  // }

  // void getuser() async {
  //   CollectionReference tblProduct =
  //       FirebaseFirestore.instance.collection('userAccount');

  //   await Future.delayed(Duration(seconds: 2));
  //   await tblProduct.get().then((querySnapshot) {
  //     querySnapshot.docs.forEach((doc) {
  //       Map<String, dynamic> store = doc.data() as Map<String, dynamic>;

  //       user.add(store);
  //     });
  //     isloading = false;
  //     setState(() {});
  //   });
  // }

  @override
  void initState() {
    // getrequest();
    // getuser();
    super.initState();
  }

  // String formatDate(Timestamp selectedDay) {
  //   DateTime date = selectedDay.toDate();
  //   return DateFormat('yyyy-MM-dd').format(date);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isloading == true
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(top: 20.0, left: 8.0),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 30.0,
                      color: Color.fromRGBO(118, 165, 209, 1),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10.0),
                Expanded(
                  child: ListView.builder(
                    itemCount: requests.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => SingleProperty(
                          //       data: CCommercial[index],
                          //     ),
                          //   ),
                          // );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(2),
                                width: double.infinity,
                                color: Colors.grey[200],
                                child: Image.network(
                                  '${requests[index]['image']}',
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: SizedBox(
                                  height: 180,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      children: [
                                        Text(
                                          '${requests[index]['address']}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          ' number :  ${requests[index]['oldphoneNumber']} ',
                                          style: const TextStyle(fontSize: 13),
                                        ),
                                        Text(
                                          'Details : ${requests[index]['propertyDetails']}',
                                          style: const TextStyle(fontSize: 13),
                                        ),
                                        const Text(
                                          "gmail : ",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                        const Text('N/A'),
                                        // Text(
                                        //   ' ${formatDate(requests[index]['selectedDay'] as Timestamp)}',
                                        //   style: TextStyle(fontSize: 18),
                                        // ),
                                        Text(
                                          ' ${requests[index]['selectedTourTime']}',
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
