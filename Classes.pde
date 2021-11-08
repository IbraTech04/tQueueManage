public class Queue {
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
      size--;
      names.remove(0);
      Clear.play();
    } else {
      Error.play();
    }
  }
}

class AdminEnabler extends Thread {
  public void run()
  {
    while (true) {
      List <File>files = Arrays.asList(File.listRoots());
      int currentNumDrives = files.size();
      if (currentNumDrives != numDrives) {
        numDrives = currentNumDrives;
        adminCommands = checkAdminConnection();
        if (adminCommands) {
          if (startupState == 1 && millis() > 2000 && alpha >= 255) {
            admin.play();
          }
          break;
        }
      }
    }
  }
}

PApplet parent = this;
class elementLoader extends Thread {
  int half;
  public elementLoader(int half) {
    this.half = half;
  }
  public void run()
  {
    if (half == 0) {
      startup = new SoundFile(parent, "startup.wav");
      startup.play();
      font = createFont("Product Sans.ttf", 100);
      boldFont = createFont("Product Sans Bold.ttf", 100);
      Error = new SoundFile(parent, "Error.wav");
      newEntry = new SoundFile(parent, "Tada.wav");
      Clear = new SoundFile(parent, "Rec.wav");
      syncCon = new SoundFile(parent, "syncCon.wav");
      syncDis = new SoundFile(parent, "syncDis.wav");
      admin = new SoundFile(parent, "admin.wav");
    } else {
      homep = loadImage("HomeL.png");
      settingsp = loadImage("SettingsL.png");
      editor = loadImage("EditorL.png");
      queue = new Queue();
      queue.names = new StringList();
      queue.currentName = "";
    }
  }
}

public class clickablePicture {

  public clickablePicture(PImage img, int picPosX, int picPosY, boolean isCenter) {
    this.img = img;
    picSizeX = img.width;
    picSizeY = img.height;
    this.picPosX = picPosX;
    this.picPosY = picPosY;
    this.isCenter = isCenter;
  }
  PImage img;
  int picPosX;
  int picPosY;
  int picSizeX;
  int picSizeY;
  boolean isCenter;
  public boolean isPressed() {
    if (isCenter) {
      return (mouseX >= picPosX - picSizeX && mouseX <= picPosX + picSizeX && mouseY >= picPosY-picSizeY && mouseY <= picPosY + picSizeY);
    } else {
      return (mouseX >= picPosX && mouseX <= picPosX + picSizeX && mouseY >= picPosY && mouseY <= picPosY + picSizeY);
    }
  }

  public void setImg(PImage img) {
    this.img = img;
    picSizeX = img.width;
    picSizeY = img.height;
  }

  public void drawImage() {
    if (isCenter) {
      imageMode(CENTER);
    } else {
      imageMode(CORNER);
    }
    image(img, picPosX, picPosY, picSizeX, picSizeY);
  }
  public void setSizeX(int size) {
    picSizeX = size;
  }
  public void setSizeY(int size) {
    picSizeY = size;
  }
  public void setPos(int x, int y) {
    picPosX = x;
    picPosY = y;
  }
  public void setMode(String mode) {
    if (mode.toUpperCase().equals("CENTER")) {
      isCenter = true;
    } else {
      isCenter = false;
    }
  }
  public int getPicSize() {
    return picSizeX;
  }
  public int getPicX() {
    return picPosX;
  }
  public int getPicY() {
    return picPosY;
  }
}
