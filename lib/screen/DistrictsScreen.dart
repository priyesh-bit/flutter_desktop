// import 'package:file_picker_cross/file_picker_cross.dart';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/material.dart';
import 'package:myapp/screen/district_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class DistrictScreen extends StatefulWidget {
  @override
  _DistrictScreenState createState() => _DistrictScreenState();
}

class _DistrictScreenState extends State<DistrictScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDistricts();
  }

  bool isLoading = true;
  File image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: () => Navigator.of(context).pop(),),
      ),
      body: isLoading ? Center(child: CircularProgressIndicator(),): image != null ? Image.file(image) : ListView.builder(
        itemCount: districts.length,
        itemBuilder: (context, index) => Text("${districts[index].districtNameEnglish}"),),
      floatingActionButton: FloatingActionButton(onPressed: () async {

        return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Pick image'),
                content: Text(''),
                actions: <Widget>[
                  TextButton(
                    child: const Text('CANCEL'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                      child: const Text('PICK'),
                      onPressed: () async {
                        FilePickerCross myFile = await FilePickerCross.importFromStorage(
                            type: FileTypeCross.image,
                            fileExtension: 'png, jpg, jpeg'
                        );
                        if(myFile!=null){
                          print(myFile.path);
                        }
                        Navigator.of(context).pop();
                      }),
                ],
              );
            });
      },
      child: Icon(Icons.image),),
    );
  }

  List<DistrictModel> districts = List();

  getDistricts() async {
    districts = await districtsGet();

    setState(() {
      isLoading = false;
    });
  }



  Future<List<DistrictModel>> districtsGet() async {
    String baseUrl = "https://devapi.sewamitra.in/api/";
    String setting = "Setting/";
    String url = baseUrl + setting + "LoadAllDistrict";
    print(url);

    try{
      Response response = await http.get(url);
      print(response.statusCode);

      if(response.statusCode==200){
        return districtModelFromJson(response.body);
      }else{
        return null;
      }
    }catch(e){
      print(e);
      throw e;
    }
  }
}
