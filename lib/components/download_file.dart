import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadFile extends StatefulWidget {
  DownloadFile({this.downloadUrl});
  final String downloadUrl;

  @override
  _DownloadFileState createState() => _DownloadFileState();
}

class _DownloadFileState extends State<DownloadFile> {
  String downloadId;
  String _localPath;

  ReceivePort _port = ReceivePort();

  @override
  void initState(){
    super.initState();
    _init();
  }

  Future<void> _init() async {
//    await FlutterDownloader.initialize();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      print("status: $status");
      print("progress: $progress");
      print("id == downloadId: ${id == downloadId}");
    });
    FlutterDownloader.registerCallback(downloadCallback);

    _localPath = (await _findLocalPath()) + '/Download';
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    print(
        'Background Isolate Callback: task ($id) is in status ($status) and process ($progress)');
    final SendPort send =
    IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }

  Future<String> _findLocalPath() async {
    final directory = await getExternalStorageDirectory();
    return directory.path;
  }

  Future<bool> _checkPermission() async {

    if (Theme.of(context).platform == TargetPlatform.android) {
      PermissionStatus permission = await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.storage);
      if (permission != PermissionStatus.granted) {
        Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler()
            .requestPermissions([PermissionGroup.storage]);
        if (permissions[PermissionGroup.storage] == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }
  //----------------------------------------------------------------
  @override
  void dispose() {
//    IsolateNameServer.removePortNameMapping('downloader_send_port');
//  _init();
    super.dispose();
  }
  //---------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () async {
        if (await _checkPermission()) {
          final taskId = await FlutterDownloader.enqueue(
            url: widget.downloadUrl,
            savedDir: _localPath,
            showNotification:
            true, // show download progress in status bar (for Android)
            openFileFromNotification:
            true, // click on notification to open downloaded file (for Android)
          );
          downloadId = taskId;
        }
      },
      child: Text('Downloa File',style: TextStyle(color: Colors.teal),)
    );
  }
}