class Path {
  
  PVector   _coordTile1;
  PVector   _coordTile2;
  PVector[] _pointsDirectionSwitch;
  
  
  Path(Tile tileStart, Tile tileEnd) {
    
    _coordTile1 = tileStart._coordinates;
    _coordTile2 = tileEnd._coordinates;
    
  }
  
  
  
  void drawLines(PVector[] arrPoints) {
    stroke(0);
    strokeWeight(6);
    float halfWidthTile = iBoard._widthTile/2;
    float halfHeightTile = iBoard._heightTile/2;
    for (int i = 0; i < _pointsDirectionSwitch.length - 1; i++) {
      PVector pointToReach = new PVector(arrPoints[i+1].x * iBoard._widthTile + halfWidthTile, arrPoints[i+1].y * iBoard._heightTile + halfHeightTile);
      line(arrPoints[i].x * iBoard._widthTile + halfWidthTile, arrPoints[i].y * iBoard._heightTile + halfHeightTile, pointToReach.x, pointToReach.y);
    } 
  }
  
  //Parcours l'axe vertical en montant depuis la tuile1 jusqu'à la ligne numéro pointY
  void moveUp(float startPoint, float endPoint, float xyCoordToCheck, BooleanWrapper pathIsValid, BooleanWrapper moveIsValid) {
        PVector coordToCheck = new PVector();
        for (float coordYLine = startPoint; coordYLine >= endPoint; coordYLine--) {
          //Arrêt du parcours vertical si une tuile est rencontrée
          if (pathIsValid.value == false)
            break;
          coordToCheck = new PVector(xyCoordToCheck, coordYLine);
          println("coordToCheck = " + coordToCheck);
          //Si les coordonnées de coordToCheck correspondent à celles de coordTile2, alors le move est valide
          if (coordToCheck.equals(_coordTile2)) {
            _pointsDirectionSwitch = (PVector[]) append(_pointsDirectionSwitch, coordToCheck);
            moveIsValid.value = true;
            println("moveIsValid = " + moveIsValid);
            break;
          }
          //Vérifie si la tuile en cours de vérification est visible
          for(Tile tile : iBoard._tiles) {
            //Si une tuile visible est rencontrée, alors le chemin (tuile1.y jusqu'à pointA.y) n'est pas valide
            if (tile._coordinates.equals(coordToCheck) && tile._isVisible) {
              pathIsValid.value = false;
              break;
            }
          }
        }
        
        if (pathIsValid.value)
          _pointsDirectionSwitch = (PVector[]) append(_pointsDirectionSwitch, coordToCheck);
  }
  
  
  //Parcours l'axe vertical en descendant depuis la tuile1 jusqu'à la ligne numéro pointY (= pointY)
  void moveDown(float startPoint, float endPoint, float xyCoordToCheck, BooleanWrapper pathIsValid, BooleanWrapper moveIsValid) {
      PVector coordToCheck = new PVector();
      for (float coordYLine1 = startPoint; coordYLine1 <= endPoint; coordYLine1++) {
        //Arrêt du parcours vertical si une tuile est rencontrée
        if (pathIsValid.value == false)
          break;
        coordToCheck = new PVector(xyCoordToCheck, coordYLine1);
        println("coordToCheck = " + coordToCheck);
        //Si les coordonnées de coordToCheck correspondent à celles de coordTile2, alors le move est valide
        if (coordToCheck.equals(_coordTile2)) {
          _pointsDirectionSwitch = (PVector[]) append(_pointsDirectionSwitch, coordToCheck);
          moveIsValid.value = true;
          println("moveIsValid = " + moveIsValid);
          break;
        }
        //Vérifie si la tuile en cours de vérification est visible
        for(Tile tile : iBoard._tiles) {
          //Si une tuile visible est rencontrée, alors le chemin (tuile1.y jusqu'à pointA.y) n'est pas valide
          if (tile._coordinates.equals(coordToCheck) && tile._isVisible) {
            pathIsValid.value = false;
            break;
          }
        }
      }
      
      if (pathIsValid.value)
        _pointsDirectionSwitch = (PVector[]) append(_pointsDirectionSwitch, coordToCheck);
  }
  
  
  void moveRight(float startPoint, float endPoint, float xyCoordToCheck, BooleanWrapper pathIsValid, BooleanWrapper moveIsValid) {
    PVector coordToCheck = new PVector();
    for (float coordXLine = startPoint; coordXLine <= endPoint; coordXLine++) {  
      //Arrêt du parcours horizontal si une tuile est rencontrée
      if (pathIsValid.value == false)
        break;
      coordToCheck = new PVector(coordXLine, xyCoordToCheck);
      println("coordToCheck = " + coordToCheck);
      //Si les coordonnées de coordToCheck correspondent à celles de coordTile2, alors le move est valide
      if (coordToCheck.equals(_coordTile2)) {
        _pointsDirectionSwitch = (PVector[]) append(_pointsDirectionSwitch, coordToCheck);
        moveIsValid.value = true;
        println("moveIsValid = " + moveIsValid);
        break;
      }
      //Vérifie si la tuile en cours de vérification est visible
      for(Tile tile : iBoard._tiles) {
        if (tile._coordinates.equals(coordToCheck) && tile._isVisible) {
          pathIsValid.value = false;
          break;
        }
      }
    }
    
    if (pathIsValid.value)
      _pointsDirectionSwitch = (PVector[]) append(_pointsDirectionSwitch, coordToCheck);
  }
  
  
  void moveLeft(float startPoint, float endPoint, float xyCoordToCheck, BooleanWrapper pathIsValid, BooleanWrapper moveIsValid) {
    PVector coordToCheck = new PVector();
    for (float coordXLine = startPoint; coordXLine >= endPoint; coordXLine--) {  
      //Arrêt du parcours horizontal si une tuile est rencontrée
      if (pathIsValid.value == false)
        break;
      coordToCheck = new PVector(coordXLine, xyCoordToCheck);
      println("coordToCheck = " + coordToCheck);
      //Si les coordonnées de coordToCheck2 correspondent à celles de coordTile2, alors le move est valide
      if (coordToCheck.equals(_coordTile2)) {
        _pointsDirectionSwitch = (PVector[]) append(_pointsDirectionSwitch, coordToCheck);
        moveIsValid.value = true;
        println("moveIsValid = " + moveIsValid);
        break;
      }
      //Vérifie si la tuile en cours de vérification est visible
      for (Tile tile : iBoard._tiles) {
        if (tile._coordinates.equals(coordToCheck) && tile._isVisible) {
          pathIsValid.value = false;
          break;
        }
      }
    }
    
    if (pathIsValid.value)
      _pointsDirectionSwitch = (PVector[]) append(_pointsDirectionSwitch, coordToCheck);
  }
  
  
  boolean isPathValid(PVector coordTile1, PVector coordTile2) {
    BooleanWrapper pathIsValid;
    BooleanWrapper moveIsValid  = new BooleanWrapper(false);
    boolean canStartUp          = true;
    boolean canStartDown        = true;
    boolean canStartLeft        = true;
    boolean canStartRight       = true;
    
    //Parcours sur l'axe vertical et création d'un curseur indiquant une ligne (pointY)
    //Commence à la première ligne - 1 (pointY = 0) et termine à la dernière ligne + 1 (_boardHeight + 1)
    for (int pointY = 0; pointY <= iBoard._boardHeight + 1; pointY++) {
      _pointsDirectionSwitch = new PVector[0];
      PVector firstPoint     = new PVector(coordTile1.x, coordTile1.y);
      _pointsDirectionSwitch = (PVector[]) append(_pointsDirectionSwitch, firstPoint);
      pathIsValid            = new BooleanWrapper(true);
      
      
      // ---------- Première ligne = verticale ---------- \\
      if (coordTile1.x == coordTile2.x && coordTile2.y > coordTile1.y)
        canStartUp = false;
        
      if (pointY < coordTile1.y && canStartUp) {
        println("Haut L1");
        moveUp(coordTile1.y - 1, pointY, coordTile1.x, pathIsValid, moveIsValid);
        println("Finally, moveIsValid = " + moveIsValid.value);
        if (moveIsValid.value)
          return true;
       }
      
      
      if (coordTile1.x == coordTile2.x && coordTile2.y < coordTile1.y)
        canStartDown = false;
      
      //Parcours l'axe vertical en descendant depuis la tuile1 jusqu'à la ligne numéro pointY (= pointA.y)
      if (pointY > coordTile1.y && canStartDown) {
        println("Bas L1");
        moveDown(coordTile1.y + 1, pointY, coordTile1.x, pathIsValid, moveIsValid);
        if (moveIsValid.value)
          return true;
      }
      
      if (pointY == coordTile1.y)
        continue;
          
          
          
      // ---------- Deuxième ligne = horizontale ---------- \\    
      //Si le chemin est libre sur la ligne verticale de tuile1.y jusqu'à pointY
      if (pathIsValid.value == true) {
            
        //Parcours l'axe horizontal vers la droite depuis la colonne de la tuile1 (coordTile1.x) jusqu'à la colonne de la tuile2 (coordTile2.x)
        //sur la ligne pointY
        if (coordTile1.x < coordTile2.x) {
          println("Droite L2");
          moveRight(coordTile1.x + 1, coordTile2.x, pointY, pathIsValid, moveIsValid);
          if (moveIsValid.value)
            return true;
        }
                
        //Parcours l'axe horizontal vers la gauche depuis la colonne de la tuile1 (coordTile1.x) jusqu'à la colonne de la tuile2 (coordTile2.x)
        //sur la ligne pointY
        if (coordTile1.x > coordTile2.x) {
          println("Gauche L2");
          moveLeft(coordTile1.x - 1, coordTile2.x, pointY, pathIsValid, moveIsValid);
          if (moveIsValid.value)
            return true;
        }
      }
              
                
  
      // ---------- Troisième ligne = verticale ---------- \\
      //Si le chemin est libre sur la ligne verticale ET horizontale de tuile1.x jusqu'à tuile2.x
      if (pathIsValid.value == true) {
        if (pointY > coordTile2.y) {
          println("Haut L3");
          moveUp(pointY - 1, coordTile2.y, coordTile2.x, pathIsValid, moveIsValid);
          if (moveIsValid.value)
            return true;
        }
                  
                  
        if (pointY < coordTile2.y) {
          println("Bas L3");
          moveDown(pointY + 1, coordTile2.y, coordTile2.x, pathIsValid, moveIsValid);
          if (moveIsValid.value)
            return true;
        }
      }
    }
    
    
    
    
    
    //Parcours sur l'axe horizontal et création d'un curseur indiquant une colonne (pointX)
    //Commence à la première colonne - 1 (pointX = 0) et termine à la dernière colonne + 1 (_boardWidth + 1)
    for (int pointX = 0; pointX <= iBoard._boardWidth + 1; pointX++) {
      _pointsDirectionSwitch = new PVector[0];
      PVector firstPoint = new PVector(coordTile1.x, coordTile1.y);
      _pointsDirectionSwitch = (PVector[]) append(_pointsDirectionSwitch, firstPoint);
      pathIsValid    = new BooleanWrapper(true);
      
      
      
      // ---------- Première ligne = horizontale ---------- \\
      if (coordTile1.y == coordTile2.y && coordTile2.x > coordTile1.x)
        canStartLeft = false;
        
      //Parcours l'axe horizontal en se dirigeant vers la gauche depuis la tuile1 jusqu'à la colonne numéro pointX
      if (pointX < coordTile1.x && canStartLeft) {
        println("Gauche L1");
        moveLeft(coordTile1.x - 1, pointX, coordTile1.y, pathIsValid, moveIsValid);
        if (moveIsValid.value)
          return true;
      }
      
      
      if (coordTile1.y == coordTile2.y && coordTile2.x < coordTile1.x)
        canStartRight = false;
      
      //Parcours l'axe horizontal en se dirigeant vers la droite depuis la tuile1 jusqu'à la colonne numéro pointX
      if (pointX > coordTile1.x && canStartRight) {
        println("Droite L1");
        moveRight(coordTile1.x + 1, pointX, coordTile1.y, pathIsValid, moveIsValid);
        if (moveIsValid.value)
          return true;
      }
      
      if (pointX == coordTile1.x)
        continue;
          
          
          
      // ---------- Deuxième ligne = verticale ---------- \\    
      //Si le chemin est libre sur la ligne horizontale de tuile1.x jusqu'à pointX
      if (pathIsValid.value == true) {
            
        //Parcours l'axe vertical vers le bas depuis la ligne de la tuile1 (coordTile1.y) jusqu'à la ligne de la tuile2 (coordTile2.y)
        //sur la colonne pointX
        if (coordTile1.y < coordTile2.y) {
          println("Bas L2");
          moveDown(coordTile1.y + 1, coordTile2.y, pointX, pathIsValid, moveIsValid);
          if (moveIsValid.value)
            return true;
        }
                
        //Parcours l'axe vertical vers le haut depuis la ligne de la tuile1 (coordTile1.y) jusqu'à la ligne de la tuile2 (coordTile2.y)
        //sur la colonne pointX
        if (coordTile1.y > coordTile2.y) {
          println("Haut L2");
          moveUp(coordTile1.y - 1, coordTile2.y, pointX, pathIsValid, moveIsValid);
          if (moveIsValid.value)
            return true;
        }
      }
              
                
  
      // ---------- Troisième ligne = horizontale ---------- \\
      //Si le chemin est libre sur la ligne horizontale ET verticale de tuile1.y jusqu'à tuile2.y
      if (pathIsValid.value == true) {
        
        if (pointX > coordTile2.x) {
          println("Gauche L3");
          moveLeft(pointX - 1, coordTile2.x, coordTile2.y, pathIsValid, moveIsValid);
          if (moveIsValid.value)
            return true;
        }
                  
                  
        if (pointX < coordTile2.x) {
          println("Droite L3");
          moveRight(pointX + 1, coordTile2.x, coordTile2.y, pathIsValid, moveIsValid);
          if (moveIsValid.value)
            return true;
        }
      }
    }
    return false; 
  }
  
}
