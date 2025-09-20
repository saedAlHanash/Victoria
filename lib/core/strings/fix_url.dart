
class FixUrl {
  static String fixAvatarImage(String? image) {
    if (image == null) return '';
    if(image.startsWith('http'))return image;
    final String link = "http://e-learning.testbandtech.com/storage/images/$image";
    return link;
  }
}
