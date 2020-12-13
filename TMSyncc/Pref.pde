//The logic that loads preferences  //<>// //<>// //<>//
void settingImport() {
  Pref = loadStrings("Preferences.tmsync");
  TMSizeDetecc();
  UDPIP = split(Pref[1], ":");
  UDPPorting = split(Pref[2], ":");
  UDPPort = int(UDPPorting[1]);
}

void settingUpdate() {
  UDPIP = split(Pref[1], ":");
  UDPPorting = split(Pref[2], ":");
  UDPPort = int(UDPPorting[1]);
}
