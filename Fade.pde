void fadeIn(int speed, String screen) {
  if (screen.equals("main")) {
    alpha+=speed;
  } else if (screen.equals("load")) {
    alphaLoadingScreen+=speed;
  } else if (screen.equals("2")) {
    alphaEaster+=speed;
  } else if (screen.equals("check")) {
    alphaCheck+=speed;
  } else {
    alphaLicence+=speed;
  }
}

void fadeOut(int speed, String screen) {
  if (screen.equals("main")) {
    alpha-=speed;
  } else if (screen.equals("load")) {
    alphaLoadingScreen-=speed;
  } else if (screen.equals("2")) {
    alphaEaster-=speed;
  } else if (screen.equals("check")) {
    alphaCheck-=speed;
  } else {
    alphaLicence-=speed;
  }
}
