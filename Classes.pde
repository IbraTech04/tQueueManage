public class DisposeHandler {

  DisposeHandler(PApplet pa)
  {
    pa.registerMethod("dispose", this);
  }

  public void dispose()
  {      
    udp = new UDP( this, UDPPort, UDPIP );
   udp.send("ClientDisconnect");
   
  }
}

public class List {
  int size;
  StringList names;
  String currentName;
  void clear() {

    names.clear();
    size = 0;
    Clear.play();
  }
  void resetName() {
    currentName = "";
  }
  void removeOne() {
    if (names.size() != 0) {
      if (offlineMode) {
        names.remove(0);
      } else {
        udp.send("UP");
      }
      size--;
      Clear.play();
    } else {
      Error.play();
    }
  }
}
