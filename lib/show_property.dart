import 'package:abdo/home_page.dart';
import 'package:abdo/models/properties.dart';
import 'package:abdo/services/api_service.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class showProperty extends StatefulWidget {
  @override
  State<showProperty> createState() => _showPropertyState();
}

class _showPropertyState extends State<showProperty> {

 List<Property> resdintial = [];
 List<Property> comercical = [];


  bool isloading = true;

  bool isResd = true;

  @override
  @override
  void initState() {
    super.initState();
      getResidential();
      getcommercials();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isloading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: isResd ? resdintial.length : comercical.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Stack(
                            children: [
                              Card(
                                color: Colors.white,
                                child: ListTile(
                                  onLongPress: () {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.warning,
                                      animType: AnimType.rightSlide,
                                      title: 'Warning',
                                      desc:
                                          'Are you sure you want to delete this',
                                      btnCancelOnPress: () {
                                        print("cancel");
                                      },
                                      btnOkOnPress: () async {
                                        print("ok");
                                        isResd
                                            ? deleteResidential(resdintial[index])
                                            : deleteCommercial(comercical[index] );

                                        setState(() {});
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                showProperty(),
                                          ),
                                        );
                                      },
                                    ).show();
                                  },
                                  leading: SizedBox(
                                    width: 200,
                                    height: 700,
                                    // child: Image.network(
                                    //   isResd
                                    //       ? 'Name: ${resdintial[index].image}'
                                    //       : 'Name: ${comerrical[index].image}',

                                    //   fit: BoxFit
                                    //       .cover, // This ensures that the image covers the specified width and height
                                    //   height: 300,
                                    // ),
                                  ),
                                  title: Text(
                                    isResd
                                        //  ? 'Name: CAIRO' : 'Name: CAIRO',
                                        ? " Type : ${resdintial[index].kind}"
                                        : ' Type : ${comercical[index].kind}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  subtitle: Text(
                                    isResd ? 'Name: CAIRO' : 'Name: CAIRO',
                                    //  ' Status :  ${resdintial[index]['propertyStatus']} \n Address : ${resdintial[index].propertyaddress}  \n more details : ${resdintial[index]['propertyDetails']} \n  rent duration :  ${resdintial[index]['propertyRentDuration']}'
                                    // : ' Status :  ${comerrical[index]['propertyStatus']} \n Address : ${comerrical[index].propertyaddress}  \n  more details : ${comerrical[index]['propertyDetails']} \n  rent duration :  ${comerrical[index]['propertyRentDuration']}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 10,
                                bottom: 10,
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) => EditPage(
                                        //       docID: isResd
                                        //           ? "${resdintial[index]['documentId']}"
                                        //           : "${comerrical[index]['documentId']}",
                                        //     ),
                                        //   ),
                                        // );
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        size: 30,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.expand_circle_down,
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          color: Colors.orangeAccent,
                          onPressed: () {
                            isResd = false;
                             getcommercials();
                            comercical.clear();

                            setState(() {});
                          },
                          child: const Text(
                            'Commercial ',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          color: Colors.orangeAccent,
                          onPressed: () {
                            isResd = true;
                            getResidential();
                            resdintial.clear();
                            setState(() {});
                          },
                          child: const Text(
                            'Residential',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),),
                        color: Colors.orangeAccent,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),);
                        },
                        child: const Text('Back' ,style:TextStyle(color :Colors.white , fontWeight: FontWeight.bold ,fontSize: 18)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> getResidential() async {
    try {
      setState(() {
        isloading = true;
      });
      final data = await ApiServices().getResidential();
      resdintial = data;
      setState(() {
        isloading = false;
      });
    } catch (e) {
      print("Error retrieving residential data: $e");
    }
  }
  Future<void> getcommercials() async {
    try {
      setState(() {
        isloading = true;
      });
      final data = await ApiServices().getcommercials();
      comercical = data;
      setState(() {
        isloading = false;
      });
    } catch (e) {
      print("Error retrieving residential data: $e");
    }
  }

  // Future<void> getResidential() async {
  //   final CollectionReference tblProduct =
  //       FirebaseFirestore.instance.collection('ResidentialProperty');

  //   try {
  //     final QuerySnapshot querySnapshot = await tblProduct
  //         .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  //         .get();

  //     for (final doc in querySnapshot.docs) {
  //       final Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
  //       data['documentId'] = doc.id;
  //       resdintial.add(data);
  //       print(data);
  //     }
  //     isloading = true;
  //     setState(() {});
  //   } catch (e) {
  //     print("Error retrieving residential data: $e");
  //   }
  // }
void deleteResidential(Property property) {
  ApiServices().deleteResidential(property).then((response) {
    if (response != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Deleted Successfully'),
          backgroundColor: Colors.green,
        ),
      );
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to delete property'),
          backgroundColor: Colors.red,
        ),
      );
    }
  });
}


  void deleteCommercial(Property property) {
  ApiServices().deleteCommercial(property).then((response) {
    if (response != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Deleted Successfully'),
          backgroundColor: Colors.green,
        ),
      );
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to delete property'),
          backgroundColor: Colors.red,
        ),
      );
    }
  });
}
}
