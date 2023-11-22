class Path {
  
  PVector   _coordTile1;
  PVector   _coordTile2;
  PVector[] _pointsDirectionSwitch;
  
  
  Path(Tile tileStart, Tile tileEnd) {
    
    _coordTile1 = tileStart._coordinates;
    _coordTile2 = tileEnd._coordinates;
    
  }
  
  
  
  //Parcours l'axe vertical en montant depuis la tuile1 jusqu'à la ligne numéro pointY
  void moveUp(float startPoint, float endPoint, float xyCoordToCheck, BooleanWrapper pathIsValid, BooleanWrapper moveIsValid) {
        PVector coordToCheck = new PVector();
        for (float coordYLine = startPoint; coordYLine >= endPoint; coordYLine--) {
          //Arrêt du parcours vertical si une tuile est rencontrée
          if (pathIsValid.value == false)
            break;
          coordToCheck = new PVector(xyCoordToCheck, coordYLine);

          //Si les coordonnées de coordToCheck correspondent à celles de coordTile2, alors le move est valide
          if (coordToCheck.equals(_coordTile2)) {
            _pointsDirectionSwitch = (PVector[]) append(_pointsDirectionSwitch, coordToCheck);
            moveIsValid.value = true;
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
        
        if (pathIsValid.value && !moveIsValid.value)
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

        //Si les coordonnées de coordToCheck correspondent à celles de coordTile2, alors le move est valide
        if (coordToCheck.equals(_coordTile2)) {
          _pointsDirectionSwitch = (PVector[]) append(_pointsDirectionSwitch, coordToCheck);
          moveIsValid.value = true;
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
      
      if (pathIsValid.value && !moveIsValid.value)
        _pointsDirectionSwitch = (PVector[]) append(_pointsDirectionSwitch, coordToCheck);
  }
  
  
  
  void moveRight(float startPoint, float endPoint, float xyCoordToCheck, BooleanWrapper pathIsValid, BooleanWrapper moveIsValid) {
    PVector coordToCheck = new PVector();
    for (float coordXLine = startPoint; coordXLine <= endPoint; coordXLine++) {  
      //Arrêt du parcours horizontal si une tuile est rencontrée
      if (pathIsValid.value == false)
        break;
      coordToCheck = new PVector(coordXLine, xyCoordToCheck);

      //Si les coordonnées de coordToCheck correspondent à celles de coordTile2, alors le move est valide
      if (coordToCheck.equals(_coordTile2)) {
        _pointsDirectionSwitch = (PVector[]) append(_pointsDirectionSwitch, coordToCheck);
        moveIsValid.value = true;
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
    
    if (pathIsValid.value && !moveIsValid.value)
      _pointsDirectionSwitch = (PVector[]) append(_pointsDirectionSwitch, coordToCheck);
  }
  
  
  
  void moveLeft(float startPoint, float endPoint, float xyCoordToCheck, BooleanWrapper pathIsValid, BooleanWrapper moveIsValid) {
    PVector coordToCheck = new PVector();
    for (float coordXLine = startPoint; coordXLine >= endPoint; coordXLine--) {  
      //Arrêt du parcours horizontal si une tuile est rencontrée
      if (pathIsValid.value == false)
        break;
      coordToCheck = new PVector(coordXLine, xyCoordToCheck);

      //Si les coordonnées de coordToCheck2 correspondent à celles de coordTile2, alors le move est valide
      if (coordToCheck.equals(_coordTile2)) {
        _pointsDirectionSwitch = (PVector[]) append(_pointsDirectionSwitch, coordToCheck);
        moveIsValid.value = true;
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
    
    if (pathIsValid.value && !moveIsValid.value)
      _pointsDirectionSwitch = (PVector[]) append(_pointsDirectionSwitch, coordToCheck);
  }
  
  
  
  boolean isPathValid(PVector coordTile1, PVector coordTile2) {
    BooleanWrapper pathIsValid  = new BooleanWrapper(true);
    BooleanWrapper moveIsValid  = new BooleanWrapper(false);
    boolean canStartUp          = true;
    boolean canStartDown        = true;
    boolean canStartLeft        = true;
    boolean canStartRight       = true;
    boolean onSameLine          = true;
    boolean onSameColumn        = true;
 
    if (coordTile1.y != coordTile2.y)
      onSameLine = false;
    if (coordTile1.x != coordTile2.x)
      onSameColumn = false;
 
    if (onSameColumn && coordTile2.y > coordTile1.y)
      canStartUp = false;
    if (onSameColumn && coordTile2.y < coordTile1.y)
      canStartDown = false;
    if (onSameLine && coordTile2.x > coordTile1.x)
      canStartLeft = false;
    if (onSameLine && coordTile2.x < coordTile1.x)
      canStartRight = false;
    
        
        
    // ---------- Connexion en une ligne ---------- \\
    if (onSameLine) {
      _pointsDirectionSwitch = new PVector[0];
      _pointsDirectionSwitch = (PVector[]) append(_pointsDirectionSwitch, coordTile1);
      
      if (coordTile2.x < coordTile1.x) {
        println("Gauche L1 (Only)");
        moveLeft(coordTile1.x - 1, coordTile2.x, coordTile1.y, pathIsValid, moveIsValid);
        if (moveIsValid.value)
          return true;
      }
      
      if (coordTile2.x > coordTile1.x) {
        println("Droite L1 (Only)");
        moveRight(coordTile1.x + 1, coordTile2.x, coordTile1.y, pathIsValid, moveIsValid);
        if (moveIsValid.value)
          return true;
      }
    }
    
    
    if (onSameColumn) {
      _pointsDirectionSwitch = new PVector[0];
      _pointsDirectionSwitch = (PVector[]) append(_pointsDirectionSwitch, coordTile1);
      
      if (coordTile2.y < coordTile1.y) {
        println("Haut L1 (Only)");
        moveUp(coordTile1.y - 1, coordTile2.y, coordTile1.x, pathIsValid, moveIsValid);
        if (moveIsValid.value)
          return true;
      }
      
      if (coordTile2.y > coordTile1.y) {
        println("Bas L1 (Only)");
        moveDown(coordTile1.y + 1, coordTile2.y, coordTile1.x, pathIsValid, moveIsValid);
        if (moveIsValid.value)
          return true;
      }
    }
    
    
    
    
    // ---------- Connexion en deux lignes ---------- \\
    if (coordTile2.x < coordTile1.x) {
      _pointsDirectionSwitch = new PVector[0];
      _pointsDirectionSwitch = (PVector[]) append(_pointsDirectionSwitch, coordTile1);
      println("Gauche L1 (Deux lignes)");
      moveLeft(coordTile1.x - 1, coordTile2.x, coordTile1.y, pathIsValid, moveIsValid);

      if (coordTile2.y < coordTile1.y) {
        println("Haut L2 (Deux lignes)");
        moveUp(coordTile1.y - 1, coordTile2.y, coordTile2.x, pathIsValid, moveIsValid);
        if (moveIsValid.value)
          return true;
      }
      if (coordTile2.y > coordTile1.y) {
        println("Bas L2 (Deux lignes)");
        moveDown(coordTile1.y + 1, coordTile2.y, coordTile2.x, pathIsValid, moveIsValid);
        if (moveIsValid.value)
          return true;
      }
    }
    
    
    if (coordTile2.x > coordTile1.x) {
      _pointsDirectionSwitch = new PVector[0];
      _pointsDirectionSwitch = (PVector[]) append(_pointsDirectionSwitch, coordTile1);
      println("Droite L1 (Deux lignes)");
      moveRight(coordTile1.x + 1, coordTile2.x, coordTile1.y, pathIsValid, moveIsValid);

      if (coordTile2.y < coordTile1.y) {
        println("Haut L2 (Deux lignes)");
        moveUp(coordTile1.y - 1, coordTile2.y, coordTile2.x, pathIsValid, moveIsValid);
        if (moveIsValid.value)
          return true;
      }
      if (coordTile2.y > coordTile1.y) {
        println("Bas L2 (Deux lignes)");
        moveDown(coordTile1.y + 1, coordTile2.y, coordTile2.x, pathIsValid, moveIsValid);
        if (moveIsValid.value)
          return true;
      }
    }
    
    
    if (coordTile2.y < coordTile1.y) {
      _pointsDirectionSwitch = new PVector[0];
      _pointsDirectionSwitch = (PVector[]) append(_pointsDirectionSwitch, coordTile1);
      println("Haut L1 (Deux lignes)");
      moveUp(coordTile1.y - 1, coordTile2.y, coordTile1.x, pathIsValid, moveIsValid);

      if (coordTile2.x < coordTile1.x) {
        println("Gauche L2 (Deux lignes)");
        moveLeft(coordTile1.x - 1, coordTile2.x, coordTile2.y, pathIsValid, moveIsValid);
        if (moveIsValid.value)
          return true;
      }
      if (coordTile2.y > coordTile1.y) {
        println("Droite L2 (Deux lignes)");
        moveRight(coordTile1.x + 1, coordTile2.x, coordTile2.y, pathIsValid, moveIsValid);
        if (moveIsValid.value)
          return true;
      }
    }
    
    
    if (coordTile2.y > coordTile1.y) {
      _pointsDirectionSwitch = new PVector[0];
      _pointsDirectionSwitch = (PVector[]) append(_pointsDirectionSwitch, coordTile1);
      println("Bas L1 (Deux lignes)");
      moveDown(coordTile1.y + 1, coordTile2.y, coordTile1.x, pathIsValid, moveIsValid);

      if (coordTile2.x < coordTile1.x) {
        println("Gauche L2 (Deux lignes)");
        moveLeft(coordTile1.x - 1, coordTile2.x, coordTile2.y, pathIsValid, moveIsValid);
        if (moveIsValid.value)
          return true;
      }
      if (coordTile2.y > coordTile1.y) {
        println("Droite L2 (Deux lignes)");
        moveRight(coordTile1.x + 1, coordTile2.x, coordTile2.y, pathIsValid, moveIsValid);
        if (moveIsValid.value)
          return true;
      }
    }
    
    
    
    
    // ---------- Connexion en trois lignes ---------- \\
    // ---------- Première ligne = verticale (haut) ---------- \\
    if (canStartUp) {
      for (float pointY = coordTile1.y - 1; pointY >= 0; pointY--) {
        _pointsDirectionSwitch = new PVector[0];
        PVector firstPoint     = new PVector(coordTile1.x, coordTile1.y);
        _pointsDirectionSwitch = (PVector[]) append(_pointsDirectionSwitch, firstPoint);
        pathIsValid            = new BooleanWrapper(true);
        
       
        println("Haut L1 (Trois lignes)");
        moveUp(coordTile1.y - 1, pointY, coordTile1.x, pathIsValid, moveIsValid);
        if (moveIsValid.value)
          return true;
        

        // ---------- Deuxième ligne = horizontale ---------- \\    
        //Si le chemin est libre sur la ligne verticale de coordTile1.y jusqu'à pointY
        if (pathIsValid.value == true) {
              
          //Parcours l'axe horizontal vers la droite depuis la colonne de la tuile1 (coordTile1.x) jusqu'à la colonne de la tuile2 (coordTile2.x)
          //sur la ligne pointY
          if (coordTile1.x < coordTile2.x) {
            println("Droite L2 (Trois lignes)");
            moveRight(coordTile1.x + 1, coordTile2.x, pointY, pathIsValid, moveIsValid);
            if (moveIsValid.value)
              return true;
          }
                  
          //Parcours l'axe horizontal vers la gauche depuis la colonne de la tuile1 (coordTile1.x) jusqu'à la colonne de la tuile2 (coordTile2.x)
          //sur la ligne pointY
          if (coordTile1.x > coordTile2.x) {
            println("Gauche L2 (Trois lignes)");
            moveLeft(coordTile1.x - 1, coordTile2.x, pointY, pathIsValid, moveIsValid);
            if (moveIsValid.value)
              return true;
          }
        }
                
                  
        // ---------- Troisième ligne = verticale ---------- \\
        //Si le chemin est libre sur la ligne verticale ET horizontale de tuile1.x jusqu'à tuile2.x
        if (pathIsValid.value == true) {
          
          if (pointY > coordTile2.y) {
            println("Haut L3 (Trois lignes)");
            moveUp(pointY - 1, coordTile2.y, coordTile2.x, pathIsValid, moveIsValid);
            if (moveIsValid.value)
              return true;
          }
                               
          if (pointY < coordTile2.y) {
            println("Bas L3 (Trois lignes)");
            moveDown(pointY + 1, coordTile2.y, coordTile2.x, pathIsValid, moveIsValid);
            if (moveIsValid.value)
              return true;
          }
        }
      }
    }
    
    
    
    // ---------- Première ligne = verticale (bas) ---------- \\
    if (canStartDown) {
      for (float pointY = coordTile1.y + 1; pointY <= iBoard._boardHeight + 1; pointY++) {
        _pointsDirectionSwitch = new PVector[0];
        PVector firstPoint     = new PVector(coordTile1.x, coordTile1.y);
        _pointsDirectionSwitch = (PVector[]) append(_pointsDirectionSwitch, firstPoint);
        pathIsValid            = new BooleanWrapper(true);
        
        
        //Parcours l'axe vertical en descendant depuis la tuile1 jusqu'à la ligne numéro pointY
        if (pointY > coordTile1.y) {
          println("Bas L1 (Trois lignes)");
          moveDown(coordTile1.y + 1, pointY, coordTile1.x, pathIsValid, moveIsValid);
          if (moveIsValid.value)
            return true;
        }
            
                 
        // ---------- Deuxième ligne = horizontale ---------- \\    
        //Si le chemin est libre sur la ligne verticale de tuile1.y jusqu'à pointY
        if (pathIsValid.value == true) {
              
          //Parcours l'axe horizontal vers la droite depuis la colonne de la tuile1 (coordTile1.x) jusqu'à la colonne de la tuile2 (coordTile2.x)
          //sur la ligne pointY
          if (coordTile1.x < coordTile2.x) {
            println("Droite L2 (Trois lignes)");
            moveRight(coordTile1.x + 1, coordTile2.x, pointY, pathIsValid, moveIsValid);
            if (moveIsValid.value)
              return true;
          }
                  
          //Parcours l'axe horizontal vers la gauche depuis la colonne de la tuile1 (coordTile1.x) jusqu'à la colonne de la tuile2 (coordTile2.x)
          //sur la ligne pointY
          if (coordTile1.x > coordTile2.x) {
            println("Gauche L2 (Trois lignes)");
            moveLeft(coordTile1.x - 1, coordTile2.x, pointY, pathIsValid, moveIsValid);
            if (moveIsValid.value)
              return true;
          }
        }
                
                  
        // ---------- Troisième ligne = verticale ---------- \\
        //Si le chemin est libre sur la ligne verticale ET horizontale de tuile1.x jusqu'à tuile2.x
        if (pathIsValid.value == true) {
          if (pointY > coordTile2.y) {
            println("Haut L3 (Trois lignes)");
            moveUp(pointY - 1, coordTile2.y, coordTile2.x, pathIsValid, moveIsValid);
            if (moveIsValid.value)
              return true;
          }
                                      
          if (pointY < coordTile2.y) {
            println("Bas L3 (Trois lignes)");
            moveDown(pointY + 1, coordTile2.y, coordTile2.x, pathIsValid, moveIsValid);
            if (moveIsValid.value)
              return true;
          }
        }
      }
    }
    
    
    
    // ---------- Première ligne = horizontale (gauche) ---------- \\
    if (canStartLeft) {
      for (float pointX = coordTile1.x - 1; pointX >= 0; pointX--) {
        _pointsDirectionSwitch = new PVector[0];
        PVector firstPoint = new PVector(coordTile1.x, coordTile1.y);
        _pointsDirectionSwitch = (PVector[]) append(_pointsDirectionSwitch, firstPoint);
        pathIsValid    = new BooleanWrapper(true);
        
         
        //Parcours l'axe horizontal en se dirigeant vers la gauche depuis la tuile1 jusqu'à la colonne numéro pointX
        if (pointX < coordTile1.x) {
          println("Gauche L1 (Trois lignes)");
          moveLeft(coordTile1.x - 1, pointX, coordTile1.y, pathIsValid, moveIsValid);
          if (moveIsValid.value)
            return true;
        }
        
             
        // ---------- Deuxième ligne = verticale ---------- \\    
        //Si le chemin est libre sur la ligne horizontale de tuile1.x jusqu'à pointX
        if (pathIsValid.value == true) {
              
          //Parcours l'axe vertical vers le bas depuis la ligne de la tuile1 (coordTile1.y) jusqu'à la ligne de la tuile2 (coordTile2.y)
          //sur la colonne pointX
          if (coordTile1.y < coordTile2.y) {
            println("Bas L2 (Trois lignes)");
            moveDown(coordTile1.y + 1, coordTile2.y, pointX, pathIsValid, moveIsValid);
            if (moveIsValid.value)
              return true;
          }
                  
          //Parcours l'axe vertical vers le haut depuis la ligne de la tuile1 (coordTile1.y) jusqu'à la ligne de la tuile2 (coordTile2.y)
          //sur la colonne pointX
          if (coordTile1.y > coordTile2.y) {
            println("Haut L2 (Trois lignes)");
            moveUp(coordTile1.y - 1, coordTile2.y, pointX, pathIsValid, moveIsValid);
            if (moveIsValid.value)
              return true;
          }
        }
                
                   
        // ---------- Troisième ligne = horizontale ---------- \\
        //Si le chemin est libre sur la ligne horizontale ET verticale de tuile1.y jusqu'à tuile2.y
        if (pathIsValid.value == true) {
          
          if (pointX > coordTile2.x) {
            println("Gauche L3 (Trois lignes)");
            moveLeft(pointX - 1, coordTile2.x, coordTile2.y, pathIsValid, moveIsValid);
            if (moveIsValid.value)
              return true;
          }
                                 
          if (pointX < coordTile2.x) {
            println("Droite L3 (Trois lignes)");
            moveRight(pointX + 1, coordTile2.x, coordTile2.y, pathIsValid, moveIsValid);
            if (moveIsValid.value)
              return true;
          }
        }
      }
    }
    
    
    
    // ---------- Première ligne = horizontale (droite) ---------- \\  
    if (canStartRight) {
      for (float pointX = coordTile1.x + 1; pointX <= iBoard._boardWidth + 1; pointX++) {
        _pointsDirectionSwitch = new PVector[0];
        PVector firstPoint = new PVector(coordTile1.x, coordTile1.y);
        _pointsDirectionSwitch = (PVector[]) append(_pointsDirectionSwitch, firstPoint);
        pathIsValid    = new BooleanWrapper(true);
        
 
        //Parcours l'axe horizontal en se dirigeant vers la droite depuis la tuile1 jusqu'à la colonne numéro pointX
        if (pointX > coordTile1.x) {
          println("Droite L1 (Trois lignes)");
          moveRight(coordTile1.x + 1, pointX, coordTile1.y, pathIsValid, moveIsValid);
          if (moveIsValid.value)
            return true;
        }
            
  
        // ---------- Deuxième ligne = verticale ---------- \\    
        //Si le chemin est libre sur la ligne horizontale de tuile1.x jusqu'à pointX
        if (pathIsValid.value == true) {
              
          //Parcours l'axe vertical vers le bas depuis la ligne de la tuile1 (coordTile1.y) jusqu'à la ligne de la tuile2 (coordTile2.y)
          //sur la colonne pointX
          if (coordTile1.y < coordTile2.y) {
            println("Bas L2 (Trois lignes)");
            moveDown(coordTile1.y + 1, coordTile2.y, pointX, pathIsValid, moveIsValid);
            if (moveIsValid.value)
              return true;
          }
                  
          //Parcours l'axe vertical vers le haut depuis la ligne de la tuile1 (coordTile1.y) jusqu'à la ligne de la tuile2 (coordTile2.y)
          //sur la colonne pointX
          if (coordTile1.y > coordTile2.y) {
            println("Haut L2 (Trois lignes)");
            moveUp(coordTile1.y - 1, coordTile2.y, pointX, pathIsValid, moveIsValid);
            if (moveIsValid.value)
              return true;
          }
        }
                
                  
        // ---------- Troisième ligne = horizontale ---------- \\
        //Si le chemin est libre sur la ligne horizontale ET verticale de tuile1.y jusqu'à tuile2.y
        if (pathIsValid.value == true) {
          
          if (pointX > coordTile2.x) {
            println("Gauche L3 (Trois lignes)");
            moveLeft(pointX - 1, coordTile2.x, coordTile2.y, pathIsValid, moveIsValid);
            if (moveIsValid.value)
              return true;
          }
                    
                    
          if (pointX < coordTile2.x) {
            println("Droite L3 (Trois lignes)");
            moveRight(pointX + 1, coordTile2.x, coordTile2.y, pathIsValid, moveIsValid);
            if (moveIsValid.value)
              return true;
          }
        }
      }
    }
    return false; //Move impossible
  }
  
}
