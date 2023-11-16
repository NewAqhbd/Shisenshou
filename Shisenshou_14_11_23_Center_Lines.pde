boolean isMouseReleased = false;
PImage img1, img2, img3, img4, img5, img6, img7;
Board iBoard;



void setup() {
  size(1000, 800);
  frameRate(25);
  PImage titleBarIcon = loadImage("assets/shisenshou-logo.png");
  surface.setIcon(titleBarIcon);
  iBoard = new Board(18, 8);
   //<>// //<>//
}




void draw() {
  background(220);
      
  iBoard.loopOverTiles();
  isMouseReleased = false;
}



void mouseClicked() {
    isMouseReleased = true;
}



void keyPressed() {
  if (key == ESC) {
    key = 0;
  }
}



//boolean isInsideTheBoard() {
//  if (mouseX >= widthSize && mouseX <= (width - widthSize) && mouseY >= heightSize && mouseY <= (boardHeight * heightSize + heightSize))
//    return true;
//  return false;
//}



void shuffleArray(int[] arr) {
  for (int i = arr.length - 1; i > 0; i--) {
    int j = int(random(i + 1));
    // Swap arr[i] and arr[j]
    int temp = arr[i];
    arr[i] = arr[j];
    arr[j] = temp;
  }
}
