import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Messenger'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<UserHorizontal> listhorizontal = [
    UserHorizontal(
        avatar: "https://cdn-icons-png.flaticon.com/512/147/147142.png",
        username: "user1",
        message: "1 chấm sành điệu"
        ),
         
        
  ];
  List<UserHorizontal> listHorizontalSearching = [
    UserHorizontal(
        avatar: "https://cdn-icons-png.flaticon.com/512/147/147142.png",
        username: "user1",
        message: "một chấm sành điệu"
        ),
           
  ];
  

  @override
  void onAddItem(){
    // neu rong thi khong them vao list
    if(usernameController.text.isEmpty || messageController.text.isEmpty) return;
    setState(() {
      final useradd = UserHorizontal(avatar: "https://cdn-icons-png.flaticon.com/512/147/147142.png", username: usernameController.text,message: messageController.text);
      listhorizontal.add(useradd);
      listHorizontalSearching.add(useradd);
    });
    usernameController.clear();
     messageController.clear();
  }

  void deleteItem(int index){
    setState(() {
      listhorizontal.removeAt(index);
      listHorizontalSearching.removeAt(index);
    });
  }
  void updateItem(int index){
    setState(() {
      usernameController.text = listhorizontal[index].username;
      messageController.text = listhorizontal[index].message;
    });
  }
  late final TextEditingController usernameController;
  late final TextEditingController messageController;
  String? usernameValue;
  String? messageValue;
  
  @override
  void initState() {
    // TODO: implement initState
    usernameController=TextEditingController(text: usernameValue);
    messageController=TextEditingController(text: messageValue);
    super.initState();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    usernameController.dispose();
    messageController.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    return Scaffold(
      
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
        //refresh man hinh 
        child: RefreshIndicator(
          onRefresh: () async{
            setState(() {
              listhorizontal.clear();
              listHorizontalSearching.clear();
              
            });
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 8,
                ),
                Container(
                  child: TextField(
                    //su ly su kien tim kiem
                    onChanged: ( valueInput) {
                      setState(() {
                        //listhorizontal =  listhorizontal.where((item) => item.username.toUpperCase().contains(valueInput.toUpperCase())?? false ).toList();
                        listHorizontalSearching =  listhorizontal.where((item) => item.username.toUpperCase().contains(valueInput.toUpperCase())?? false ).toList();
                      });
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.deepPurpleAccent,
                      ),
                      contentPadding: EdgeInsets.all(16),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                            color: Colors.deepPurpleAccent, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                            color: Colors.deepPurpleAccent, width: 2),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 120,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      //physics:const NeverScrollableScrollPhysics(),
                      itemCount: listHorizontalSearching.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              width: 80,
                              //height: 70,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              padding: EdgeInsets.all(2),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(35),
                                  child:
                                      Image.network(listHorizontalSearching[index].avatar)),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(listHorizontalSearching[index].username),
                          ],
                        );
                      }),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  child: Container(
                    child: ListView.builder(
                        shrinkWrap: true,
                        //physics: NeverScrollableScrollPhysics(),
                        itemCount: listHorizontalSearching.length,
                        itemBuilder: (context, index) {
                          currentIndex=index;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                margin: EdgeInsets.only(bottom: 10, right: 5),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(35),
                                    child: Image.network(
                                      listHorizontalSearching[index].avatar,
                                    )),
                              ),
                              Expanded(
                                child: Column(
                                  
                                  children: [
                                    Container(
                                      child: Text(
                                        listHorizontalSearching[index].username,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Text(listHorizontalSearching[index].message),
                                  ],
                                ),
                              ),
                              GestureDetector(onTap: () {
                                deleteItem(index);
                              }, child: const Icon(Icons.delete)),
                              GestureDetector(onTap: () {
                                setState(() {
                                  updateItem(index);
                                });
                              }, child: const Icon(Icons.edit)),
                            ],

                          );
                        }),
                  ),
                ),
          
                //chuc nang
                const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    onChanged: (String value) {
                      usernameValue=value;
                    },
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText:'Username' ,
                      
                      hintText: 'hãy nhập tên đăng nhập của bạn',
                      hintStyle:TextStyle(color: Colors.grey.withOpacity(0.9)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Colors.indigoAccent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                  onChanged: (String value) {
                    messageValue=value;
                  },
                  controller: messageController,
                  decoration: InputDecoration(
                    labelText: 'Message',
                    hintText: 'hãy nhập message của bạn',
                    hintStyle:TextStyle(color: Colors.grey.withOpacity(0.9)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.indigoAccent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                  ),
                  // obscureText: true,
                  // obscuringCharacter: '*',
        
                ),
                  InkWell(
                    onTap: (){
                      //print(usernameController.text);
                        setState(() {
                          onAddItem();
                        });
                    },
                    child: Container(
          
                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                      margin: EdgeInsets.only(top: 20,bottom: 20),
                      color: Colors.blue,
                      child: Text(
                        'Thêm',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                        setState(() {
                          listhorizontal[currentIndex].username = usernameController.text;
                          listhorizontal[currentIndex].message = messageController.text;
                        });
                    },
                    child: Container(
          
                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 40),
                      color: Colors.blue,
                      child: Text(
                        'Sửa',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
            
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            width: 10,
                          )),
                      Container(
                        child: Column(
                          children: [
                            Icon(
                              Icons.chat,
                              color: Colors.deepPurpleAccent,
                              size: 35,
                            ),
                            Text("chats")
                          ],
                        ),
                      ),
                      Expanded(flex: 2, child: Center()),
                      Container(
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera,
                              color: Colors.deepPurpleAccent,
                              size: 35,
                            ),
                            Text("Story")
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Container(
                            width: 10,
                          )),
                    ],
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

class UserHorizontal {
  String avatar;
  String username;
  String message;
  UserHorizontal({required this.avatar, required this.username,required this.message});
}





