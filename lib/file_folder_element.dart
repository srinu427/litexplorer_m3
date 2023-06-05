import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FsEntryDetails{
  final FileSystemEntity entity;
  final FileStat stats;

  FsEntryDetails({required this.entity, required this.stats});
}

String getSizeString(int iSize){
  double fSize = iSize.toDouble();
  if (fSize < 1024) {
    return "${fSize.toStringAsFixed(0)} B";
  } else {
    fSize = fSize/1024.0;
  }

  if (fSize < 1024) {
    return "${fSize.toStringAsFixed(3)} KB";
  } else {
    fSize = fSize/1024.0;
  }

  if (fSize < 1024) {
    return "${fSize.toStringAsFixed(3)} MB";
  } else {
    fSize = fSize/1024.0;
  }

  return "${fSize.toStringAsFixed(3)} GB";
}

class FileFolderElement extends StatelessWidget{
  final FsEntryDetails fseDetails;
  final Function(int) tapCallback;
  final int index;

  const FileFolderElement({super.key, required this.fseDetails, required this.tapCallback, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: (){ tapCallback(index);},
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              fseDetails.stats.type == FileSystemEntityType.file?
              const Icon(Icons.file_present_outlined,size: 48,):
              const Icon(Icons.folder_outlined, size: 48,),
              const SizedBox(width: 8,),
              Flexible(
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        fseDetails.entity.path.split("/").last,
                        style: const TextStyle(fontSize: 16,),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    fseDetails.stats.type == FileSystemEntityType.file?
                    Text(
                      "Size: ${getSizeString(fseDetails.stats.size)}",
                      style: const TextStyle(fontSize: 8,),
                    ):
                    const Text(
                      "Directory",
                      style: TextStyle(fontSize: 8,),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}