//Called whenever Data is Received
void receive( byte[] data ) {
  if (!tmSyncc) {
  } else {
    String recName = bytes2string(data);
    String[] splitRec = split(recName, ":");
    if (splitRec[0].equals("UP")) {
      if (queue.names.size() !=0) {
        queue.removeOne();
      } else {
        Error.play();
      }
    } else if (splitRec[0].equals("Init")) {
      errorStat = false;
    } else if (splitRec[0].equals("CLS")) {
      queue.names.clear();
      queue.size = 0;
    } else if (splitRec[0].equals("NUM")) {
    } else if (splitRec[0].equals("namesSize")) {
      udp.send("Size:"+str(queue.names.size()));
    } else if (splitRec[0].equals("devCheck")) {
      udp.send("devRec");
    } else if (splitRec[0].equals("queue.namesSize")) {
      udp.send("Size:"+str(queue.names.size()));
    } else if (splitRec[0].equals("syncDis")) {
      sDisconnectProtocol();
    } else if (splitRec[0].equals("nameRequest")) {
      String[] toSend = queue.names.array();
      for (int i = 0; i < toSend.length; i++) {
        String name2send = toSend[i];
        udp.send("Sync:"+name2send);
      }
    } else if (recName.equals("SyncOn")) {
      serverConnectProtocol();
    } else if (splitRec[0].contains("Admin")) {
      adminAdvanced(recName);
    } else if (splitRec[0].equals("ServerDisconnect")) {
      sDisconnectProtocol();
    } else if (splitRec[0].equals("failedToAuthenticate")) {
      tSyncError = true;
      tSyncDelta = 0;
    } else if (!splitRec[0].equals("syncWillBeTurnedOff") && !splitRec[0].equals("isType") && !splitRec[0].equals("numType") &&!splitRec[0].equals("checkType") && !splitRec[0].equals("Version") && !recName.equals("devRec") && !splitRec[0].equals("Size") && !splitRec[0]  .equals("Sync") && !splitRec[0].equals("Starting") && !splitRec[0].equals("waiting4Sync")) {
      queue.names.append(recName); 
      if (adminCommands && !jf.isFocused()) {
        booster.createNotification(
          recName + " needs some help!", 
          "New Queue Member!");
        jf.requestFocus();
      }
      queue.size++;
    }
  }
}
//Called when the TMSyncc Client Connects
void serverConnectProtocol() {
  syncServerStat = true;
  syncCon.play();
}
//Called when TMSyncc Client Disconnects
void sDisconnectProtocol() {
  syncServerStat = false;
  syncDis.play();
}

void adminAdvanced(String currentName) {
  String[] command = split(currentName, ".");
  if (command[1].toUpperCase().equals("REMOVE")) {
    int num2Rem = int(command[2]);
    if (num2Rem >= queue.names.size()) {
    } else {
      queue.names.remove(num2Rem);
      currentName = "";
      queue.size--;
    }
  } else if (command[1].toUpperCase().equals("MODIFY")) {
    int num2Chng = int(command[2]);
    if (num2Chng >= queue.names.size()) {
    } else {
      queue.names.set(num2Chng, command[3]);
      currentName = "";
    }
  } else if (command[1].toUpperCase().equals("SWAP")) {
    int num12Chng = int(command[2]);
    int name22Chng = int(command[3]);
    if (num12Chng >= queue.names.size() || name22Chng >=queue.names.size()) {
    } else {
      String temp = queue.names.get(name22Chng);
      String temp2 = queue.names.get(num12Chng);
      currentName = "";
      queue.names.set(num12Chng, temp);
      queue.names.set(name22Chng, temp2);
    }
  } else if (command[1].toUpperCase().equals("ADDAT")) {

    int addAt = int(command[2]);
    if (addAt > queue.names.size()) {
      currentName = "";
    } else {
      String[] toReplace = queue.names.array();
      String backupAddAt = queue.names.get(addAt);
      queue.names.set(addAt, command[3]);
      String lastOne = queue.names.get(queue.names.size()-1);
      queue.names.append(lastOne);
      for (int i = addAt + 1; i < queue.names.size(); i++) {
        queue.names.set(i, toReplace[i-1]);
      }
    }
  } else if (command[1].toUpperCase().equals("CLEAR")) {
    udp.send("CLS");
  } else if (command[1].toUpperCase().equals("ADD")) {
    queue.names.append(command[2]);
  } else {
    currentName = "";
  }
}
