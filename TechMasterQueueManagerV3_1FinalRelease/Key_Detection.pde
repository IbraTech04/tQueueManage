//Basicly all the name-detecting logic
boolean controlStat = false;
void keyPressed() {
  if (key == 22 && keyCode==86) {
    pasteToText(state, GetTextFromClipboard ());
  }


  /* if (keyCode == 82){
   reset();
   setup();
   / }*/
  if (screenNumber == 0) {
    if (key == '`') {
      if (adminCommands) {
        adminMode =! adminMode;
      } else {
        E.play();
        currentName = "";
      }
    }
    if (key == CODED) {
      if (keyCode == UP && negativeCheck !=0 && adminMode) {
        udp.send("UP");
        upOne();
        if (!tmSyncc) {
          if (names.size() !=0) {
            upOneArrow();
          } else {
            E.play();
          }
        }
      } else if (keyCode == UP && negativeCheck == 0) {
        E.play();
      } else if (keyCode == UP && !adminMode) {
        E.play();
      } else if (keyCode == DOWN) {
        s = 800;
        loop = 6;
      }
    }
    if (key == BACKSPACE) {
      currentName = currentName.substring(0, max(0, currentName.length() - 1));
    } else if (key != ENTER && currentName.length() <=29 && startupState == 2 && key != CODED && key != '`') {
      T.play();
      currentName += key;
    }

    if (key == ENTER) {
      if (currentName.equals("")) {
        E.play();
      } else if (currentName.toUpperCase().equals("CLS") && !adminMode) {
        E.play();
        currentName = "";
      } else if (currentName.equals("cls") && adminMode) {
        udp.send("CLS");
        currentName = "";
      } else if (currentName.equals("Admin") && adminCommands) {
        adminMode = !adminMode;
        currentName = "";
      } else if (currentName.equals("Admin") && !adminCommands) {
        E.play();
        currentName = "";
      } else if (currentName.equals("Help") || currentName.equals("help")) {
        assistStat = true;
      } else if (currentName.contains("Admin") && adminCommands) {
        udp.send(currentName);
      } else if (currentName.contains("Admin") && !adminCommands) {
        E.play();
      } else {
        output.println(currentName); // Write the name to the file
        output.flush();
        checkSwears();
        prevCurrentName = currentName;
        if (currentName.toUpperCase().contains("DOROSZ")) {
          doroszCheck();
        }
        if (offlineMode) {
          udp.send(currentName);
        } else {

          if (currentName.toUpperCase().equals("CLS") && adminCommands) {
            names.clear();
            negativeCheck = 0;
            nameNum = 0;
          } else {
            nameNum++;
            negativeCheck++;
            names.append(currentName);
          }
        }
        currentName = "";
        negativeCheck ++;
        Tada.play();
      }
    }

    if (currentName.length() >=29 && key != ENTER) {
      E.play();
    }
  } else if (screenNumber == 1) {
    if (key == 'r') {
      startupState = 5;
    } else if (key == 'f') {
      facReset();
    }
  } else if (screenNumber == 5) {
    if (key == ENTER) {
      state++;
    } else if (key == '=') {
      state --;
    } else {
      if (state == 0) {
        if (key != ENTER && key != CODED && key != '`' && key != BACKSPACE && key != 22 && keyCode!=86) {
          userName +=key;
        } else  if (key == BACKSPACE) {
          userName = userName.substring(0, max(0, userName.length() - 1));
        }
      } else if (state == 1) {
        if (key != ENTER && key != CODED && key != '`' && key != BACKSPACE && key != 22 && keyCode!=86) {
          pID += key;
        } else  if (key == BACKSPACE) {
          pID = pID.substring(0, max(0, pID.length() - 1));
        }
      } else if (state == 2) {
        if (key != ENTER && key != CODED && key != '`' && key != BACKSPACE && key != 22 && keyCode!=86) {
          pKey += key;
        } else  if (key == BACKSPACE) {
          pKey = pKey.substring(0, max(0, pKey.length() - 1));
        }
      }
    }
  } else if (screenNumber ==4) {
    if (key == 'r') {
      reset();
      licence = createWriter("data/ActivationInfo.tmqm");
      setup();
    }
  }
  if (needReboot) {
    if (key == 'r') {
      reset();
      setup();
    }
  }
}
void editName() {
  rectMode(CENTER);
  stroke(colors[colorShift], colors[colorShift+1], colors[colorShift+2], alpha);
  noFill();
  rect(posView[shiftRegister], posView[shiftRegister+1]-35, 335, 35);
  rectMode(CORNER);
  textAlign(CENTER);
  fill(textColor[0], textColor[1], textColor[2]);
  text(currentName, posView[shiftRegister], posView[shiftRegister+1]-30);
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
void keyReleased() {
  if (keyCode == 17) {
    controlStat = false;
  }
}
