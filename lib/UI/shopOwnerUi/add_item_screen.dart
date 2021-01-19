import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jumga/Core/states/payment_provider.dart';
import 'package:jumga/models/product.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as Fb_Storage;
import 'package:path/path.dart' as Path;
import '../../constants.dart';

class AddItemScreen extends StatefulWidget {
  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

var inputDecoration = InputDecoration(
  hintText: '',
  border: OutlineInputBorder(
      borderSide: BorderSide(width: 0.2),
      borderRadius: BorderRadius.circular(6.0)),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kPrimaryColor, width: 1.0),
    borderRadius: BorderRadius.circular(6),
  ),
);

class _AddItemScreenState extends State<AddItemScreen> {
  TextEditingController _nameController;
  TextEditingController _priceController;
  TextEditingController _descriptionController;

  File _image;
  String upLoadedImageUrl;


  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    var textStyle = Theme
        .of(context)
        .textTheme
        .subtitle1
        .copyWith(
      color: kBlackTextColor,
      fontWeight: FontWeight.w500,
      fontSize: 16,
    );

    var model = Provider.of<PaymentProvider>(context, listen: true);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          'Add an Item',
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: kToolbarHeight * 0.5,
                ),
                Stack(
                  alignment: Alignment(0.3, 1.0),
                  children: [
                    _image == null ? Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.4,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          border: Border.all(
                              color: kPrimaryColor,
                              width: 0.5
                          )
                      ),
                    ) : Image.file(_image,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.4,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.5,
                    ),
                    Align(
                      alignment: Alignment(0.7, 1.0),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: kPrimaryColor,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.camera_alt,
                            color: Colors.white,),
                          onPressed: getImage,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  'Name',
                  style: textStyle,
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                    autofocus: false,
                    validator: (value) {
                      return value.isEmpty
                          ? 'Please enter  your item name.'
                          : null;
                    },
                    controller: _nameController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: inputDecoration.copyWith(
                        hintText: 'XXL T-Shirt')),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  'Price ( ${model.user.country})',
                  style: textStyle,
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  autofocus: false,
                  validator: (value) {
                    return value.isEmpty
                        ? 'Please enter  your item price.'
                        : null;
                  },
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: inputDecoration.copyWith(hintText: '400'),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  'Description (Optional)',
                  style: textStyle,
                ),
                SizedBox(
                  height: 4.0,
                ),
                Text(
                  'Description is an opportunity to convince people on how awesome your product is.',
                  style: Theme
                      .of(context)
                      .textTheme
                      .subtitle2
                      .copyWith(
                      color: kBlackTextColor, fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  autofocus: false,
                  controller: _descriptionController,
                  keyboardType: TextInputType.text,
                  maxLength: 300,
                  textInputAction: TextInputAction.next,
                  decoration: inputDecoration.copyWith(
                      hintText: '100% cotton and bullet proof shirt'),
                ),
                SizedBox(
                  height: 16.0,
                ),
                FlatButton(
                  color: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  onPressed: () {
                    if (_image != null && _formKey.currentState.validate()) {
                      uploadItem();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Upload Item',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Visibility(
                          visible: loading,
                          child: SpinKitThreeBounce(
                            color: Colors.white,
                            size: 15.0,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future getImage() async {
    try {
      FilePickerResult result = await FilePicker.platform.pickFiles(
          type: FileType.image);
      if (result != null) {
        setState(() {
          _image = File(result.files.first.path);
        });
      }
    } catch (e) {
      print(e);
    }
  }


  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _priceController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> uploadItem() async {
    setState(() {
      loading = true;
    });

    try {
      Fb_Storage.FirebaseStorage storage = Fb_Storage.FirebaseStorage.instance;

      Fb_Storage.TaskSnapshot taskSnapshot = await storage.ref(
          'chats/${Path.basename(_image.path)}}').putFile(_image);
      upLoadedImageUrl = await taskSnapshot.ref.getDownloadURL();

      CollectionReference productsReference = FirebaseFirestore.instance
          .collection('products');
      var model = Provider.of<PaymentProvider>(context, listen: false);

      String userId = model.user.id;

      Product product = Product(
        name: _nameController.text,
        price: double.parse(_priceController.text),
        imageUrl: upLoadedImageUrl,
        description: _descriptionController.text,
        ownerUserId: userId,
        id: userId + DateTime.now().toIso8601String(),
      );

      productsReference.doc(model.user.id).set(product.toJson())
          .then((value) {
        print(';item added');
        _scaffoldKey.currentState.showSnackBar(
            SnackBar(content: Text('Item uploaded successfully'),));
      }).catchError((error) {});
    } catch (e) {

    } finally {
      setState(() {
        loading = false;
      });
    }
  }
}
