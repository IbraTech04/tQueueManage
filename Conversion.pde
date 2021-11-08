//The UDP Server Conversion
byte[] string2bytes(String chaine) {
  byte[] bytes = new byte[0];
  for (int i = 0; i < chaine.length(); i++) {
    bytes = append(bytes, byte(chaine.charAt(i)));
  }
  return bytes;
} 
String bytes2string(byte[] bytes) {
  String chaine = str(char(bytes[0]));
  for (int i = 1; i < bytes.length; i++) {
    chaine = chaine+str(char(bytes[i]));
  }
  return chaine;
}

float getSize(String text, int textSize) {
  return ((text.length()) * textSize)/2 / 2;
}


boolean checkAdminConnection() {
  List <File>files = Arrays.asList(File.listRoots());
  for (File f : files) {
    String s1 = FileSystemView.getFileSystemView().getSystemDisplayName(f);
    String type = FileSystemView.getFileSystemView().getSystemTypeDescription(f);
    if (s1.contains("tAdmin") && type.equals("USB Drive") && !adminCommands) {
      try {
        int hash = int(loadStrings(f + ".tmadmin"))[0];
        if (hash == calcHash(f.getTotalSpace())) {
          tooFast = true;
          return true;
        } else {
          adminError = true;
          return false;
        }
      }
      catch(Exception e) {
        adminError = true;
        return false;
      }
    }
  }
  adminError = false;
  return false;
}

long calcHash(long size) {
  return (long)Math.pow(size, 2) % 400000000;
}
