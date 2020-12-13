//TMSynccV3 //<>//
import hypermedia.net.*;
UDP udp;

String[] themeString, UDPIP, VERBOSE, ADMIN, UDPPORT, COLOR, iconColor, UDPPorting;

String[] Pref;

float[] home = {0, 0, 0, 0}, settings = {0, 0, 0, 0}, posView = {0, 0};

PImage Home, Admin;

PFont font, boldFont;

int numDev = 0, numInTMQM, nameNum = 0, negativeCheck = 0, UDPPort;

boolean errorStat = false, storeStat = false, startStat = false, customTheme;

int start = 0, screenNumber = 0;

String version = "3", currentName = "";
StringList names, typers;

int type = 0;

DisposeHandler dh;


void setup() {
  settingImport();
  imageMode(CENTER);
  Home = loadImage("Home.png");
  Admin = loadImage("Admin.png");
  font = createFont("Product Sans.ttf", 100);
  boldFont = createFont("Product Sans Bold.ttf", 100);
  size(1280, 700);
  surface.setTitle("TMSyncc");
  surface.setResizable(true);
  udp = new UDP( this, UDPPort, UDPIP[1]);
  dh = new DisposeHandler(this);

  udp.listen( true );
  names = new StringList();
  typers = new StringList();

  textAlign(CENTER);
  udp.send("namesSize");
  udp.send("SyncOn");
}

void draw() {
  rectMode(CORNER);
  TMSizeDetecc();
  println(numDev);
  background(0);
  noStroke();
  fill(50, 130, 184);
  rect(0, 0, width*0.05859375, height);
  rect(0, 0, width, height*0.102986612);
  image(Home, home[0], home[1], 50, 50);
  image(Admin, settings[0], settings[1], 50, 50);
  if (numDev > 0 && start != 1) {
    start = 2;
  }
  fill(255);
  /*if (numDev == 0 && start != 1) {
   start = 0;
   udp.send("SyncOn");
   errorStat = false;
   }*/
  if (numInTMQM > 0 && numDev == 1 && !storeStat) {
    udp.send("nameRequest");
  }
  if (numDev == 0) {
    start = 0;
  }
  textFont(boldFont, 40);
  textAlign(LEFT);
  if (screenNumber == 0) {
    text("TMSynccV3", 15, height*0.102986612/2 + 17);
    textAlign(CENTER);

    textSize(25);
    if (start == 2) {
      if (type > 0) {
        println("HERE");
        udp.send("numType:" + type + ":" + typers.get(0));
      } else {
        udp.send("numType:" + "0" + ":" + "");
      }
      textSize(50);
      text("Clients Connected: " + numDev, width/2, height/2);

      textSize(25);

      text("Entries in TMSyncc: " + names.size(), width/2, height/2+30);
      text("Entries in TMQM: " + numInTMQM, width/2, height/2+60);
    } else if (start == 0) {
      textSize(50);
      text("Searching for TMQM Client", width/2, height/2);
    } else if (start == 1) {
      text("Connecting New Client", width/2, height/2);
    }

    if (errorStat) {
      fill(255, 0, 0);
      textSize(20);
      text("Warning: TMQM already has entries. TMSyncc will only Sync new entries. \nTo ensure proper syncing, please clear entries in TMQM", width/2, height/2+150);
      fill(255);
    }
  } else {
    strokeWeight(5);
    rectMode(CENTER);
    text("TMRemoteAdmin", 15, height*0.102986612/2 + 17);
    noFill();
    stroke(255);
    textMode(CENTER);
    text("ADMIN_CONSOLE", width/2-160, posView[1]-100);
    textFont(boldFont, 25);
    editName();
    showNames();
  }
  udp.send("NUM:"+numDev);

  numDev = 0;
  type = 0;
  typers.clear();
  udp.send("checkType");
  udp.send("devCheck");
  udp.send("namesSize");
}

void devCheck() {
  numDev++;
}

void receive( byte[] data ) {
  String recName = bytes2string(data);
  String[] splitRec = split(recName, ":");

  if (recName.equals("devRec")) {
    devCheck();
  } else if (splitRec[0].equals("Version")) {
    println("HIIIII");
    if (!splitRec[1].equals(version)) {
      udp.send("Confirm");
    }
  } else if (recName.equals("waiting4Sync")) {
    start = 2;
  } else if (recName.equals("Starting")) {
    start = 1;
    println("start");
  } else if (recName.equals("Init")) {
    start = 2;
    println("HERE");
    //numDev++;f
    newDevice();
    udp.send("SyncOn");
  } else if (recName.contains("Size:")) {
    int i = int(splitRec[1]);
    numInTMQM = i;
    if (i != 0 && storeStat == false) {
      errorStat = true;
    } else if (i !=0 && i>names.size()) {
      errorStat = true;
    } else {
      errorStat = false;
    }
  } else if (recName.equals("UP")) {
    if (names.size() !=0) {
      upOneArrow();
    }
  } else if (recName.equals("CLS")) {
    names.clear();
  } else if (splitRec[0].contains("Admin")) {
    println(recName);
    adminAdvanced(recName);
  } else if (splitRec[0].equals("isType")) {
    typers.append(splitRec[1]);
    type++;
  } else if (splitRec[0].equals("syncWillBeTurnedOff")) {
    names.clear();
  } else if (!splitRec[0].equals("numType") && !splitRec[0].equals("checkType") && !splitRec[0].equals("NUM") && !recName.equals("devCheck") && !recName.equals("namesSize") && !recName.contains("nameRequest") && !recName.contains("SyncOn") && !recName.equals("ClientDisconnect")) {
    if (recName.contains("Sync")) {
      String[] splitRecLocal = split(recName, ":");
      names.append(splitRecLocal[1]);
      storeStat = true;
    } else {
      names.append(recName);
      storeStat = true;
    }
  }
}

boolean isEven(int n) {
  return n % 2 == 0;
}

void newDevice() {
  udp.send("CLS");
  String[] toSend = names.array();
  names.clear();
  for (int i = 0; i < toSend.length; i++) {
    String name2send = toSend[i];
    println(name2send);
    udp.send(name2send);
  }
}
void upOneArrow() {
  names.remove(0);
} 
public class DisposeHandler {

  DisposeHandler(PApplet pa)
  {
    pa.registerMethod("dispose", this);
  }

  public void dispose()
  {      
    println("Closing sketch");
    udp = new UDP( this, 6000, "224.0.1.1" );
    udp.send("ServerDisconnect");
    // Place here the code you want to execute on exit
  }
}

void TMSizeDetecc() {
  int wid = width;
  int hei = height;
  posView[0] = wid*0.5;
  posView[1] = hei*0.20;
  home[0] = wid*0.02734375;
  home[1] = hei*0.326388889;
  //Settings Icon
  settings[0] = wid*0.02734375;
  settings[1] = hei*0.417095778;
}

void mousePressed() {
  if (mouseX >= 0 && mouseX <= 75) {
    if (mouseY >=home[1]-25 && mouseY <=home[1]+25) {
      screenNumber = 0;
    } else if (mouseY >=settings[1]-25 && mouseY <=settings[1]+25) {
      screenNumber = 1;
    }
  }
}
