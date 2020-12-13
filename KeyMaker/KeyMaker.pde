String current = "ItsACrystal"; //Put your name in here
String ID = "";
PrintWriter output;
String proKey = "";
int s = 0;
void setup() {
  output = createWriter("ActivationInfo.tmqm");

  size(750, 750);
  background(0);
  fill(255, 255, 255);
  stepOne();
  current = current.toUpperCase();
  stepTwo();
  stepThree();
  for (int A = 0; A < current.length(); A++) {
    char temp = current.charAt(A);
    if (temp == 'A') {
      proKey += 1;
    } else if (temp == 'B') {
      proKey += 2;
    } else if (temp == 'C') {
      proKey += 3;
    } else if (temp == 'D') {
      proKey += 4;
    } else if (temp == 'E') {
      proKey += 5;
    } else if (temp == 'F') {
      proKey += 6;
    } else if (temp == 'G') {
      proKey += 7;
    } else if (temp == 'H') {
      proKey += 8;
    } else if (temp == 'I') {
      proKey += 9;
    } else if (temp == 'J') {
      proKey += 10;
    } else if (temp == 'K') {
      proKey += 11;
    } else if (temp == 'L') {
      proKey += 12;
    } else if (temp == 'M') {
      proKey += 13;
    } else if (temp == 'N') {
      proKey += 14;
    } else if (temp == 'O') {
      proKey += 15;
    } else if (temp == 'P') {
      proKey += 16;
    } else if (temp == 'Q') {
      proKey += 17;
    } else if (temp == 'R') {
      proKey += 18;
    } else if (temp == 'S') {
      proKey += 19;
    } else if (temp == 'T') {
      proKey += 20;
    } else if (temp == 'U') {
      proKey += 21;
    } else if (temp == 'V') {
      proKey += 22;
    } else if (temp == 'W') {
      proKey += 23;
    } else if (temp == 'X') {
      proKey += 24;
    } else if (temp == 'Y') {
      proKey += 25;
    } else if (temp == 'Z') {
      proKey += 26;
    }
  }
  println("This is your Product key: " + proKey);
  println("This is your Product ID: " + ID);
  frameRate(1);
}
void stepOne() {
  String one = str(int(random(001, 365)));
  if (int(one) <= 99) {
    one = "0" + one;
  }
  String temp = str(year());
  String two = "";
  two += temp.charAt(2);
  two += temp.charAt(3);
  String finalOne = "";
  finalOne = one;
  finalOne+=two;
  ID+=finalOne + "-";
  ID += "OEM-";
}

void stepTwo() {
  int div7 = 0;
  String test = str(int(random(0, 9)));
  String test2 = str(int(random(0, 9)));
  String test3 = str(int(random(0, 9)));
  String test4 = str(int(random(0, 9)));
  String test5 = str(int(random(0, 9)));
  String test6 = str(int(random(0, 9)));
  String test7 = str(int(random(0, 9)));

  String one = test + test2 + test3 + test4 + test5 + test6 + test7;
  println("thus is one" + one);
  for (int A = 0; A < one.length(); A++) {
    String toAdd = str(one.charAt(A));
    int toAddto = int(toAdd);
    div7 += toAddto;
  }
  if (isDiv7(div7)) {
    ID+=one + "-";
  } else {
    stepTwo();
  }
}

void stepThree() {
  int div5 = 0;
  String test = str(int(random(0, 9)));
  String test2 = str(int(random(0, 9)));
  String test3 = str(int(random(0, 9)));
  String test4 = str(int(random(0, 9)));
  String test5 = str(int(random(0, 9)));

  String one = test + test2 + test3 + test4 + test5;  
  for (int A = 0; A < one.length(); A++) {
    String toAdd = str(one.charAt(A));
    int toAddto = int(toAdd);
    div5 += toAddto;
  }
  if (isDiv5(div5)) {
    ID+=one; 
    println(one);
  } else {
    println("HERE");
    stepThree();
  }
}

boolean isDiv7(int n) {
  return n % 7 == 0;
}

boolean isDiv5(int n) {
  return n % 5 == 0;
}
void draw() {
  textSize(50);
  textAlign(3);
  background(0);
  text("TMQM Licence Tool", width/2, height/2);
  s++;
  if (s==1) {
    text("Starting Services", width/2, height/2 + 50);
  }
  if (s ==2) {

    text("Generating Keys", width/2, height/2 + 50);
  }
  if (s == 3) {
    text("Writing Keys to file", width/2, height/2 + 50);
    output.println("ProductInfo:");
    output.println("ProductOwner:");
    output.println(current);
    output.println("ProductKey:");
    output.println(proKey);
    output.println("ProductID:");
    output.println(ID);
  }
  if (s == 4) {
    text("Signing File", width/2, height/2 + 50);
  }
  if (s==5) {
    text("Flushing File", width/2, height/2 + 50);
    output.flush();
  }
  if (s >= 6) {
    text("Done", width/2, height/2 + 50);
  }
  if (s ==9){
    exit(); 
  }
}
