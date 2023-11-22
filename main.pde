boolean isMouseReleased = false;
PImage img1, img2, img3, img4, img5, img6, img7;
Board iBoard;
int startTime;
boolean _drawing;
boolean _toDisplay;
Path pathToCheck;
boolean _toDisplayOnce;
void setup() {
  size(1000, 800);
  frameRate(60);
  PImage titleBarIcon = loadImage("assets/shisenshou-logo.png");
  surface.setIcon(titleBarIcon);
  iBoard = new Board(18, 8); //<>//
  _drawing = false;
  _toDisplay = true;
  _toDisplayOnce = false;
}



void draw() {
  background(220);
  iBoard.displayTiles();
  noLoop();

  
  if (iBoard._selectedTiles.length == 2) {
    loop();
    pathToCheck = new Path(iBoard._selectedTiles[0], iBoard._selectedTiles[1]);
        
    if (
          pathToCheck.isPathValid(iBoard._selectedTiles[0]._coordinates, iBoard._selectedTiles[1]._coordinates) 
          && iBoard._selectedTiles[0]._family == iBoard._selectedTiles[1]._family
        ) 
    {    

      if (!_drawing) {
        startTime = millis();
      }
        
      if (millis() - startTime < 1000) {
        _drawing = true;
        drawLines(pathToCheck._pointsDirectionSwitch);
      }  
      else {
        iBoard._selectedTiles[0]._isVisible = false;
        iBoard._selectedTiles[1]._isVisible = false; 
        Tile[] emptyArray = new Tile[0];
        iBoard._selectedTiles  = emptyArray;
      }
    }     
    else {
      iBoard._selectedTiles[0]._isSelected = false;
      Tile newSelectedTile = iBoard._selectedTiles[1];
      Tile[] emptyArray = new Tile[0];
      iBoard._selectedTiles  = emptyArray;
      iBoard._selectedTiles  = (Tile[]) append(iBoard._selectedTiles, newSelectedTile);
    }
  }

  isMouseReleased = false;
}



void mouseClicked() {
  loop();
  _toDisplay = true;
  isMouseReleased = true;

}



void keyPressed() {
  if (key == ESC) {
    key = 0;
  }
}



void shuffleArray(int[] arr) {
  for (int i = arr.length - 1; i > 0; i--) {
    int j = int(random(i + 1));
    int temp = arr[i];
    arr[i] = arr[j];
    arr[j] = temp;
  }
}



void drawLines(PVector[] arrPoints) {
  stroke(0);
  strokeWeight(6);
  float halfWidthTile = iBoard._widthTile/2;
  float halfHeightTile = iBoard._heightTile/2;
  for (int i = 0; i < pathToCheck._pointsDirectionSwitch.length - 1; i++) {
    PVector pointToReach = new PVector(arrPoints[i+1].x * iBoard._widthTile + halfWidthTile, arrPoints[i+1].y * iBoard._heightTile + halfHeightTile);
    line(arrPoints[i].x * iBoard._widthTile + halfWidthTile, arrPoints[i].y * iBoard._heightTile + halfHeightTile, pointToReach.x, pointToReach.y);
  } 
}
