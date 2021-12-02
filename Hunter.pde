class Hunter {

  //hitboxes
  int hTop;
  int hBottom;
  int hLeft;
  int hRight;

  //hunter vars
  int hx;
  int hy;
  int hw;
  int hh;
  color aColor;

  int xSpeed;
  int ySpeed;

  //constructor
  Hunter(int tempX, int tempY, int tempH, int tempW, color tempColor) {
    hx = tempX;
    hy = tempY;
    hh = tempH;
    hw = tempW;
    aColor = tempColor;

    xSpeed = -10;


    if (xSpeed == 0) {
      xSpeed =5;
    }

    //hitboxes
    hTop = hy;
    hBottom=  hy + hh;
    hLeft= hx;
    hRight= hx + hw;
  }


  //functions
  void render() {
    fill(aColor);
    rect(hx, hy, hw, hh);
  }

  void move() {
    hx += xSpeed;

    //hitboxes
    hTop = hy;
    hBottom=  hy + hh;
    hLeft= hx;
    hRight= hx + hw;
  }

  void collisionDetection(Deer de) {
    // collision with deer if statements
    if (hTop < de.dBottom) {  
      if (hBottom > de.dTop) {
        if (hLeft < de.dRight) {
          if (hRight > de.dLeft) {
            println("collided hunter");
            state = 2;
          }
        }
      }
    }
  }
}
