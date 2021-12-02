class Trap {

  //hitboxes
  int tTop;
  int tBottom;
  int tLeft;
  int tRight;

  //trap vars
  int tx;
  int ty;
  int tw;
  int th;
  color aColor;

  int xSpeed;

  //constructor
  Trap(int tempX, int tempY, int tempH, int tempW, color tempColor) {
    tx = tempX;
    ty = tempY;
    th = tempH;
    tw = tempW;
    aColor = tempColor;

    xSpeed = -7;

    if (xSpeed == 0) {
      xSpeed =10;
    }

    //hitboxes
    tTop = ty;
    tBottom=  ty + th;
    tLeft= tx;
    tRight= tx + tw;
  }


  //functions
  void render() {
    fill(aColor);
  }

  void move() {
    tx += xSpeed;

    //hitboxes
    tTop = ty;
    tBottom=  ty + th;
    tLeft= tx;
    tRight= tx + tw;
  }

  void collisionDetection(Deer de) {
    // collision with deer if statements
    if (tTop < de.dBottom) {  
      if (tBottom > de.dTop) {
        if (tLeft < de.dRight) {
          if (tRight > de.dLeft) {
            println("collided trap");
          state = 2;
          }
        }
      }
    }
  }
}
