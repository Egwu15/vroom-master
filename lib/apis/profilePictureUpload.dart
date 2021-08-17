import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:get/route_manager.dart';
import 'package:vroom_user/Components/snackBar.dart';
import 'hiveStorage.dart';
import 'authCall.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

final uploader = FlutterUploader();
File _image;
final picker = ImagePicker();

Future getImageFromCamera() async {
  final pickedFile = await picker.getImage(source: ImageSource.camera);
  _image = File(pickedFile.path);
  uploadProfilePic(_image);
}

Future getImageFromGallary() async {
  final pickedFile = await picker.getImage(source: ImageSource.gallery,);
  _image = File(pickedFile.path);
  uploadProfilePic(_image);
}

uploadProfilePic(_image) async {
  var userToken = await HiveCalls().getUserToken();

  final String filename = basename
  (_image.path);
  final String savedDir = dirname(_image.path);
  Get.back();
  showCustomSnackBar('uploading ...');
  await uploader.enqueue(
      url: "$baseUrl/Picture", //required: url to upload to
      files: [
        FileItem(filename: filename, savedDir: savedDir, fieldname: "avater")
      ], // required: list of files that you want to upload
      method: UploadMethod.POST, // HTTP method  (POST or PUT or PATCH)
      headers: {
        'Authorization': 'Bearer $userToken',
      },
      // data: {"avater": '$filename .jpg'}, // any data you want to send in upload request
      showNotification:
          true, // send local notification (android only) for upload status
      tag: "uploading Image"); // unique tag for upload task

  uploader.progress.listen(
    (progress) {
      print(
          "progress: ${progress.status.description} progress no: ${progress.progress}");
    },
  );

  uploader.result.listen(
    (result) {
      if (result.status.description == "Completed") {
        print('done');
        Future.delayed(Duration(seconds: 2), () => _deleteImageChache());
        
      }

      print(result);
    },
    onError: (ex, stacktrace) {
      // ... code to handle error
      showCustomSnackBar('upload failed');
      print(ex);
      print(stacktrace);
    },
  );
}

_deleteImageChache() async {
   String url = await HiveCalls().getProfilePhoto();
  await CachedNetworkImage.evictFromCache(url);
  PaintingBinding.instance.imageCache.clear();
 
  await NetworkImage(url).evict().then<void>((bool success) {
     if (success)
       debugPrint('removed image!');
       

});}
