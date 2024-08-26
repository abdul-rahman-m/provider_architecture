class RestHttpFile {
  // The path to the file on the local filesystem
  final String filePath;

  // The extension of the file, e.g., 'jpg', 'png'
  final String extension;

  // Constructor to initialize the file path and extension
  RestHttpFile({
    required this.filePath,
    required this.extension,
  });
}
