import 'dart:io';

import 'package:path_provider/path_provider.dart' as PathProvider;
import 'package:permission_handler/permission_handler.dart';

class FileUtils {
  static Future<String?> getFilePath() async {
    if (await Permission.storage.request().isGranted) {
      // // TEMP Code.
      // Directory directory = await PathProvider.getExternalStorageDirectory();

      // ORG Code.
      Directory directory = await PathProvider.getApplicationSupportDirectory();
      return directory.path;
    }

    return null;
  }

  static Future<File?> getOrCreateFile(String fileName) async {
    try {
      String? filePath = await getFilePath();
      if (filePath == null) {
        return null;
      } else {
        return File('$filePath/$fileName.txt');
      }
    } catch (excp) {
      print(excp);
      return null;
    }
  }

  static Future saveDataInFile(String fileName, String data) async {
    try {
      File? file = await getOrCreateFile(fileName);
      if (file != null) {
        file.writeAsString(data);
      }
    } catch (excp) {
      print(excp);
    }
  }

  static Future<String?> readDataFromFile(String fileName) async {
    try {
      File? file = await getOrCreateFile(fileName);
      if (file == null) {
        return null;
      }

      String fileContents = await file.readAsString();
      return fileContents;
    } on IOException catch (exception) {
      print(exception);
      print("No file Exists of this Name....");
      return null;
    } catch (error) {
      return null;
    }
  }

  // static Future<File> getFileFromCache(String url) async {
  //   File cacheImgFile = await DefaultCacheManager().getSingleFile(url);
  //   return cacheImgFile;
  // }

  // static Future<bool> updateCacheImage(String url) async {
  //   bool opStatus = false;
  //   try {
  //     File imgFileForUpdate = await DefaultCacheManager().getSingleFile(url);
  //     if (imgFileForUpdate != null) {
  //       String oldFilePath = imgFileForUpdate.path;
  //       await imgFileForUpdate.delete();
  //       FileInfo newImgFileInfo = await DefaultCacheManager().downloadFile(url);
  //       if (newImgFileInfo != null) {
  //         File newImgFile = newImgFileInfo.file;
  //         await newImgFile.rename(oldFilePath);
  //         opStatus = true;
  //       }
  //     }
  //   } catch (exp) {
  //     print("Update Cache Image Exception..");
  //   }

  //   return opStatus;
  // }

  Future<Directory?> getInternalStorageDirectoryForAndroid() async {
    try {
      await Permission.manageExternalStorage.request();
      await Permission.storage.request();
      Directory extStDir = await PathProvider.getApplicationSupportDirectory();
      List<String> dirsName = extStDir.path.split("/");
      int andNameIn = -1;
      for (int i = dirsName.length - 1; i >= 0; i--) {
        if (dirsName[i] == "Android") {
          andNameIn = i;
        }
      }

      Directory resDir = extStDir;
      if (andNameIn != -1) {
        andNameIn = (dirsName.length - andNameIn);
        for (int i = 0; i < andNameIn; i++) {
          resDir = resDir.parent;
        }

        return resDir;
      }
      return null;
    } catch (err) {
      print(err);
      return null;
    }
  }
}
