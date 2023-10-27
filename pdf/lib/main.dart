import 'dart:io';
import 'dart:math';

import 'package:external_path/external_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

void main()
{
  runApp(MaterialApp(home: first(),));
}

class first extends StatefulWidget {
  const first({super.key});

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {

  @override
  void initState() {
    get();
  }

  get()
  async {
    var status = await Permission.storage.status;
    if (status.isDenied) {

      Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
          Permission.storage,
      ].request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(),
      
      body: ElevatedButton(onPressed: () async {

        final PdfDocument document = PdfDocument();
        final PdfPage page = document.pages.add();

        page.graphics.drawString(' I am Vipul Konar, and I am 7 years old.'
            '\nI study at Delhi Public School in the fourth standard.'
            '\nMy father’s name is Mr. Adhitya Konar, and my mother’s name is Mrs. Alar Konar.'
            '\nI have one younger sister who studies in the first standard in the same school.'
            '\nI like watching cartoons, and my favorite cartoon character is Sinchan.'
            '\nI also love playing Indoor games with my sister. And, I love playing cricketwith my friends.'
            '\nI am a very honest and decent boy and follow all the instructions from my parents and teachers.'
            '\nI complete my homework regularly and never get late to school.'
            '\nI pay attention and respect to my teachers and elders. Also, I follow every piece of advice from them.'
            '\nI try to help my mother and father by keeping all the toys at the right place after playing with them.',
          PdfStandardFont(PdfFontFamily.helvetica, 12),
            bounds: const Rect.fromLTWH(0, 0, 150, 20),
            brush: PdfBrushes.black,
        );

        var path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
        print(path);

        Directory dir=Directory(path);
        if(await dir.exists())
          {
            dir.create();
          }


        File f=File("${dir.path}/${Random().nextInt(100)}.pdf");
        f.writeAsBytes(await document.save());
        OpenFile.open(f.path);
        document.dispose();

      }, child: Text("Submit")),

    );
  }
}
