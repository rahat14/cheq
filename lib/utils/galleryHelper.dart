import 'dart:io';
import 'dart:typed_data';

Future<List<String>> fetchImagesFromDirectory(
    String directoryPath, int page) async {
  List<String> imageBytesList = [];

  late Directory directory = Directory(directoryPath);

  if (await directory.exists()) {
    List<FileSystemEntity> entities = directory.listSync(followLinks: false);

    // Calculate start and end indices based on page and pageSize
    int start = page == 1 ? 0 : page * 48;
    int end = (page + 1) * 48;



    for (int i = start; i < end && i < entities.length; i++) {
      FileSystemEntity entity = entities[i];

      if (entity is File &&
          (entity.path.toLowerCase().endsWith('.jpg') ||
              entity.path.toLowerCase().endsWith('.png') ||
              entity.path.toLowerCase().endsWith('.jpeg'))) {
        imageBytesList.add(entity.path);
      }
    }
  } else {
    print("does not exits");
  }

  return imageBytesList;
}

Future<List<Uint8List>> fetchImagesFromDirectoryPaginated(
    String directoryPath, int page) async {
  List<Uint8List> imageBytesList = [];

  late Directory directory = Directory(directoryPath);

  if (await directory.exists()) {
    List<FileSystemEntity> entities = directory.listSync(followLinks: false);

    // Calculate start and end indices based on page and pageSize
    int start = page == 1 ? 0 : page * 48;
    int end = (page + 1) * 48;

    for (int i = start; i < end && i < entities.length; i++) {
      FileSystemEntity entity = entities[i];

      if (entity is File &&
          (entity.path.toLowerCase().endsWith('.jpg') ||
              entity.path.toLowerCase().endsWith('.png') ||
              entity.path.toLowerCase().endsWith('.jpeg'))) {
        Uint8List bytes = await entity.readAsBytes();
        imageBytesList.add(bytes);
      }
    }
  } else {
    print("erm");
  }

  return imageBytesList;
}
