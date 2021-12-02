class Animation {
  // variables
  PImage[] images;
  float speed; //how fast it moves through the animation
  float scale; //keeps aspect ratio but changes size

  float index;  //represents the image were currently displaying, starts as 0 for the first image
  boolean isAnimating; //true, animates once. false, sits still and does not animate

  // constructor
  Animation(PImage[] tempImages, float tempSpeed, float tempScale) {
    images = tempImages;
    speed = tempSpeed;
    scale = tempScale;

    index = 0;
    isAnimating = false;
  }

  // updates the index which image to display for
  // the animation
  void next() {
   // println(index);
    index += speed; //changes picture speed

    // resets the index if it is too big
    if (index >= images.length) {
      index=0;
      isAnimating=false;
    }
  }

  // display an image of the animation
  void display(int x, int y) {
    imageMode(CENTER);
    if (isAnimating) {
      int imageIndex = int(index);
      PImage img = images[imageIndex];
      image(img, x, y, img.width*scale, img.height*scale);

      // increment the index of the images to display
      next();
    } else {
      PImage img = images[0];
      image(img, x, y, img.width*scale, img.height*scale);
    }
  }
}
