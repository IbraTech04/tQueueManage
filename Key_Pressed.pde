File file; //<>//

void keyPressed() { //<>//
  if (key == 22 && keyCode==86) {
    pasteToText(state, GetTextFromClipboard());
  }
  if (startupState == 0) {
    if (key == 'e') {
      easterEggStat = true;
    }
  } else if (easterEggStat && key != 'e') {
    print("here");
    fadeOut = true;
    startupState = 1;
    easterEggStat = false;
  } else if (startupState == 1) {
    if (screenNumber == 1) {
      if (key == CODED) {
        if (keyCode == UP && adminMode) {
          if (offlineMode) {
            if (queue.names.size() != 0) {
              queue.size--;
              queue.names.remove(0);
              Clear.play();
            } else {
              Error.play();
            }
          } else {
            udp.send("UP");
          }
        } else if (keyCode == DOWN && adminMode) {
          if (offlineMode) {
            queue.names.clear();
          } else {
            udp.send("CLS");
          }
          Clear.play();
        }
      } else {
        if (key == BACKSPACE) {
          queue.currentName = queue.currentName.substring(0, max(0, queue.currentName.length() - 1));
        } else if (key != ENTER && queue.currentName.length() <=29 && key != CODED && key != '`') {
          queue.currentName += key;
        } else if (key == ENTER) {
          if (queue.currentName.equals("") || queue.currentName.equals("CLS") || queue.currentName.equals("UP") || queue.currentName.contains("Admin")|| queue.currentName.contains("Sync")) {
            Error.play();
            queue.resetName();
          } else {
            if (currentDelta == 0) {
              newEntry.play();
              if (!offlineMode) {
                udp.send(queue.currentName);
              } else {
                queue.names.append(queue.currentName);
              }
              queue.resetName();
              addToDelta = true;
            } else {
              Error.play();
              queue.resetName();
              tooFast = true;
              niceTry = false;
              currentDelta -= 150;
            }
          }
        } else if (key == '`') {
          if (adminCommands) {
            adminMode =! adminMode;
            adminDelta = maxAdminDelta-5;
          } else {
            Error.play();
            queue.resetName();
            niceTry = true;
            tooFast = true;
          }
        }
      }
    } else if (screenNumber == 2) {
      if (key == 'R' || key == 'r') {
        booster.showConfirmDialog(
          "Are you sure you want to restart tQMe? You'll lose all your entires if tSyncc is not connected", 
          "Confirm tQMe restart", 
          new Runnable() {
          public void run() {
            reset(false);
          }
        }
        , 
          new Runnable() {
          public void run() {
          }
        }
        );
      } else if (key == 'F' || key =='f') {
        booster.showConfirmDialog(
          "Are you sure you want to factory reset tQMe? You will need your username and product key to re-activate tQMe if you proceed", 
          "Confirm Factory Reset", 
          new Runnable() {
          public void run() {
            reset(true);
          }
        }
        , 
          new Runnable() {
          public void run() {
          }
        }
        );
      }
    } else if (screenNumber == 3) {
      if (key == 't' || key == 'T') {
        try {
          Theme = "Custom";
          customTheme = true;
          text = booster.showColorPickerAndGetRGB("Choose the color for tQMe's Text", "Text Color picking");
          newText[0] = (round(red(text)));
          newText [1] = (round(green(text)));
          newText [2] = (round(blue(text)));
        }
        catch (Exception e) {
          booster.showWarningDialog("Invalid Entry", "Warning");
        }
      } else if (key == CODED) {
        Theme = "Custom";
        customTheme = true;
        if (keyCode == UP) {
          newPicCol = 255;
        } else if (keyCode == DOWN) {
          newPicCol = 0;
        }
      }
      updateThemeFile();
    }
  } else if (startupState == 2) {
    if (key=='r' || key == 'R') {
      reset(true);
    }
  } else if (startupState == 3) {
    if (key == ENTER) {
      state++;
    } else if (key == '`') {
      file = booster.showFileSelection();
      String[] temp = loadStrings(file.toString());
      uName = temp[2];
      pKey = temp[4];
      state = 2;
    }
    if (state == 0) {
      if (key != ENTER && key != CODED && key != BACKSPACE && key != 22 && keyCode!=86) {
        uName+=key;
      } else if (key == BACKSPACE) {
        uName = uName.substring(0, max(0, uName.length() - 1));
      }
    } else if (state == 1) {
      if (key != ENTER && key != CODED && key != BACKSPACE && key != 22 && keyCode!=86) {
        pKey+=key;
      } else if (key == BACKSPACE) {
        pKey = pKey.substring(0, max(0, pKey.length() - 1));
      }
    }
  }
}
