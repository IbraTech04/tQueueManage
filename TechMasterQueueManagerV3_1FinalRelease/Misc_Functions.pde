//Misc Functions //This is a comment
 

boolean isOdd(int n) {
  return n % 2 != 0;
}

boolean isDiv7(int n) {
  return n % 7 == 0;
}

boolean isDiv5(int n) {
  return n % 5 == 0;
}

void doroszCheck() {
  String [] Rep = {"Why", "Watch your mouth", "Dirty Words!", "I'm Offended", "You are HARAM", "...", "COPPA!!", "Demonetized!"};  
  int index = int(random(Rep.length));  // Same as int(random(4))
  for (int z = 0; z < Swears.length; z++) {
    String swearCheck = currentName.toUpperCase();
    if (swearCheck.contains(Swears[index])) {
      currentName = Rep[index];
    }
  }
}

void checkSwears() {
  String [] Rep = {"Swearing Boi", "Watch your mouth", "Dirty Words!", "I'm Offended", "You are HARAM", "...", "COPPA!!", "Demonetized!"};  
  int index = int(random(Rep.length));  // Same as int(random(4))
  String swearCheck = currentName.toUpperCase();
  for (int z = 0; z < Swears.length; z++) {
    if (swearCheck.contains(Swears[z]) && !swearCheck.contains("HELLO")) {
      currentName = Rep[index];
    }
  }
}
//Beta txt backup
void upOne() {
  output = createWriter("List.txt");
  for (int J = 0; J < names.size(); J++) {
    //String text = names.get(J);
    output.println(names.get(J));
    output.flush();
  }
}
void init() {
  startupState = 2;
  currentName = "";
}


void upOneArrow() {
  names.remove(0);
  nameNum --;
  negativeCheck --;
  Y.play();
}
void clear() {
  names.clear();
  negativeCheck = 0;
  nameNum = 0;
  output = createWriter("List.txt"); 
  currentName = "";
  Y.play();
}
void techMasterQuickAssist() {
  textAlign(LEFT);
  background(backGroundColor[0], backGroundColor[1], backGroundColor[2]);
  sup++;
  if (sup >= 0 && sup < 50) {
    text("Contacting TechMaster Support Agent. Please Wait.", 5, 100);
  }
  if (sup >= 50 && sup < 100) {
    text("Contacting TechMaster Support Agent. Please Wait. .", 5, 100);
  }
  if (sup >= 100 && sup < 150) {
    text("Contacting TechMaster Support Agent. Please Wait. . .", 5, 100);
  }
  if (sup >= 150) {
    sup = 0; 
    supNum++;
  }
  if (supNum == 5) {
    assistStat = false;
    supNum = 0;
  }
}

public class DisposeHandler {

  DisposeHandler(PApplet pa)
  {
    pa.registerMethod("dispose", this);
  }

  public void dispose()
  {      
    udp = new UDP( this, 6000, UDP );
    udp.send("ClientDisconnect");
    // Place here the code you want to execute on exit
  }
}
void pay() {
  background(0);
  textFont(boldFont, 100);
  text("PAY UP", width/2, height/2);
  textFont(boldFont, 50);

  text("You've used me enough. Now time to PAY!", width/2, height/2+55);
  text("PayPal chehab.ibrahim@outlook.com", width/2, height/2+110);
}

void fadeIn(int speed, String screen) {
  if (screen.equals("main")) {
    alpha+=speed;
  } else if (screen.equals("2")) {
    alphaLoadingScreen+=speed;
  } else {
    alpha1+=speed;
  }
}

void fadeOut(int speed, String screen) {
  if (screen.equals("main")) {
    alpha-=speed;
  } else if (screen.equals("load")) {
    println("WORKS");
    alphaLoadingScreen-=speed;
  } else if (screen.equals("2")) {
    alpha2-=speed;
  } else {
    alpha1-=speed;
  }
}
