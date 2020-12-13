float[] colors = {50, 130, 184, 128, 0, 0, 92, 153, 107, 0, 0, 0}, textColor = {255, 255, 255}, backGroundColor = {0, 0, 0};
int colorShift = 0;
void editName() {
  rectMode(CENTER);
  stroke(colors[colorShift], colors[colorShift+1], colors[colorShift+2]);
  noFill();
  rect(posView[0], posView[1]-35, 335, 35);
  rectMode(CORNER);
  textAlign(CENTER);
  fill(textColor[0], textColor[1], textColor[2]);
  text(currentName, posView[0], posView[1]-30);
}
//Shows the Queue (Thanks to Tiemen for the help with this part)
void showNames() {
  textAlign(LEFT);
  int namesPerColumn = round((height/2.5)/20);
  int yPos = 0;
  translate(width*0.05859375+15, 250);
  pushMatrix();
  for (int i = 0; i < names.size(); i++) {
    yPos = (i % namesPerColumn) * 35;
    if (i != 0 && i % namesPerColumn == 0) {
      translate(250, 0);
    }
    String name = names.get(i);
    textFont(boldFont, 25);
    text(name, 0, yPos);
  }
  popMatrix();
}

void keyPressed() {
  if (key == BACKSPACE) {
    currentName = currentName.substring(0, max(0, currentName.length() - 1));
  } else if (key == ENTER) {
    udp.send(currentName);
    currentName = "";
  } else if (key != ENTER && currentName.length() <=29 && key != CODED && key != '`') {
    currentName += key;
  }
}
void adminAdvanced(String currentName) {
  println(names.size());
  String[] command = split(currentName, ".");
  if (command[1].toUpperCase().equals("REMOVE")) {
    int num2Rem = int(command[2]);
    if (num2Rem >= names.size()) {
    } else {
      names.remove(num2Rem);
      currentName = "";
      nameNum--;
      negativeCheck--;
    }
  } else if (command[1].toUpperCase().equals("MODIFY")) {
    int num2Chng = int(command[2]);
    if (num2Chng >= names.size()) {
    } else {
      names.set(num2Chng, command[3]);
      currentName = "";
    }
  } else if (command[1].toUpperCase().equals("SWAP")) {
    int num12Chng = int(command[2]);
    int name22Chng = int(command[3]);
    if (num12Chng >= names.size() || name22Chng >=names.size()) {
    } else {
      String temp = names.get(name22Chng);
      String temp2 = names.get(num12Chng);
      currentName = "";
      names.set(num12Chng, temp);
      names.set(name22Chng, temp2);
    }
  } else if (command[1].toUpperCase().equals("ADDAT")) {

    int addAt = int(command[2]);
    if (addAt > names.size()) {
      currentName = "";
    } else {
      String[] toReplace = names.array();
      String backupAddAt = names.get(addAt);
      names.set(addAt, command[3]);
      String lastOne = names.get(names.size()-1);
      names.append(lastOne);
      for (int i = addAt + 1; i < names.size(); i++) {
        names.set(i, toReplace[i-1]);

        println(toReplace[i]);

        /* names.set(i, backupAddAt);
         backupAddAt = names.get(i+1);
         */
        /*String backup1 = names.get(i);
         String backup2 = names.get(i+1);
         names.set(i+2,backup1);
         names.set(i+3,backup2);
         */
      }
    }
  } else if (command[1].toUpperCase().equals("CLEAR")) {
    udp.send("CLS");
  } else if (command[1].toUpperCase().equals("ADD")) {
    names.append(command[2]);
  } else {
    currentName = "";
  }
}
