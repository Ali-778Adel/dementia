
import 'dart:io';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:time_control/presentation/pickup_file_field.dart';


class PaymentThirdScreen extends StatefulWidget {
  // List<DocumentModel> ?documents=[DocumentModel()];
  final _formKey=GlobalKey<FormState>();

   PaymentThirdScreen({Key? key}) : super(key: key);

  @override
  State<PaymentThirdScreen> createState() => _PaymentThirdScreenState();
}

class _PaymentThirdScreenState extends State<PaymentThirdScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:SingleChildScrollView(
        padding: EdgeInsets.all(16.sp),
        child: Form(
          key: widget._formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                EdgeInsets.symmetric(horizontal: 8.sp, vertical: 16.sp),
                child: Text(
                  'يمنكنك الان اصدار الختم او التوقيع الالكتروني من ايجيبت تراست من فضلك قم بادخال كافة البيانات المطلوبة ',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.sp, vertical: 8.sp),
                child: Text(
                  ' البيانات الاساسية. ',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 18.sp),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.sp, vertical: 8.sp),
                child: Text(
                  ' الاوراق المطلوبة : ',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.normal, fontSize: 14.sp),
                ),
              ),
              PickUpFileField(
                fieldLabel: ' السجل التجاري / بديل السجل التجاري (ملف او صورة )',
                onPickTapped: (){
                  pickPDF();
                },),
            ],
          ),

        ),
      ) ,
    );
  }

  Future<void> requestStoragePermission() async {
    final status = await Permission.storage.status;
    if (status != PermissionStatus.granted) {
      final result = await Permission.storage.request();
      if (result != PermissionStatus.granted) {
        throw Exception('Storage Permission not granted');
      }
    }
  }
  Future<void> pickPDF() async {
    await requestStoragePermission();
    try {
      final file = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
      if (file != null) {

        File file1 = File(file.files.single.path ?? '');
        var uri=file1.uri;
        var name2=basename(Uri.parse(uri.authority).toString());
        print('name2 is $name2');

        var base=basenameWithoutExtension(file1.path);
        print('basename is ${base}');

      }

      setState(() {
       final _pdfPath = file!.files.single.path;
       final name=basename(_pdfPath!);
       print('device name is $name ');
       final _pdfName=file.files.first.bytes.toString();
       debugPrint('$_pdfPath');
       debugPrint('name is $_pdfName');
      });
    } catch (e) {
      debugPrint('$e');
    }
  }

}
