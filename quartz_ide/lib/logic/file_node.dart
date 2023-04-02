class StorageNode {
  const StorageNode(this.name);
  final String name;
}

class FolderNode extends StorageNode {
  FolderNode(String name, [this.children = const []]) : super(name);
  final List<StorageNode> children;
  bool opened = false;
}

class FileNode extends StorageNode {
  FileNode(String name, [this.content = ""]) : super(name);
  String content;
}
