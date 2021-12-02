class Deer {

  //hitboxes
  int dTop;
  int dBottom;
  int dLeft;
  int dRight;

  //deer vars
  int dx;
  int dy;
  int ds;
  color aColor;

  //jumping vars
  int jumpSpeed;
  int fallSpeed;

  int movingRight;

  boolean isJumping;
  boolean isFalling;

  int jumpHeight;
  int peakY;

  //constructor
  Deer(int tempX, int tempY, int tempS, color tempColor) {
    dx = tempX;
    dy = tempY;
    ds = tempS;
    aColor = tempColor;

    jumpHeight = 400;
    peakY = dy - jumpHeight;

    jumpSpeed = 12;


    //hitboxes
    dTop = dy;
    dBottom=  dy + ds;
    dLeft= dx;
    dRight= dx + ds;
  }


  void render() {
    fill(aColor);
    //square(dx, dy, ds);

    //hitboxes upadting every frame
    dTop = dy;
    dBottom=  dy + ds;
    dLeft= dx;
    dRight= dx + ds;
  }


  void jump() {
    if (isJumping == true) {
      dy = dy - jumpSpeed;
    }
  }

  void reachedTopOfJump() {
    if (dy <= peakY) {
      isFalling = true;
      isJumping = false;
    }
  }

  void fall() {
    if (isFalling == true) {
      dy = dy + jumpSpeed;
    }
  }

  void land() {
    if (dy >= height - ds) {
      isFalling = false;
    }
  }
}
