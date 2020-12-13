byte[] string2bytes(String chaine) {
  byte[] bytes = new byte[0];
  for (int i = 0; i < chaine.length(); i++) {
    bytes = append(bytes, byte(chaine.charAt(i)));
  }
  return bytes;
} 
String bytes2string(byte[] bytes){
  String chaine = str(char(bytes[0]));
  for (int i = 1; i < bytes.length; i++) {
    chaine = chaine+str(char(bytes[i]));
  }
  return chaine;
}
