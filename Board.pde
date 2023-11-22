class Board {
  
  int    _boardWidth;
  int    _boardHeight;
  int    _nbTiles;
  float  _widthTile;
  float  _heightTile;
  Tile[] _tiles;
  Tile[] _selectedTiles;
  int[]  _familyKey;
  boolean _drawing;
  Path pathToCheck;
  
  
  Board(int boardWidth, int boardHeight) {
   
    _boardWidth                        = boardWidth;
    _boardHeight                       = boardHeight;
    _nbTiles                           = boardWidth * boardHeight;
    _widthTile                         = width / (_boardWidth + 2);
    _heightTile                        = _widthTile * 1.5;
    _tiles                             = new Tile[_nbTiles];
    _selectedTiles                     = new Tile[0];
    _familyKey                         = new int[_nbTiles];
    _drawing                           = false;
    HashMap<Integer, PImage> _families = new HashMap<Integer, PImage>();



    //Chargement des images des tuiles (familles)
    img1 = loadImage("assets/1.png");
    img2 = loadImage("assets/2.png");
    img3 = loadImage("assets/3.png");
    img4 = loadImage("assets/4.png");
    img5 = loadImage("assets/5.png");
    img6 = loadImage("assets/6.png");
    img7 = loadImage("assets/7.png");
    
    //Association des familles de tuile à leur image respective
    _families.put(1, img1);
    _families.put(2, img2);
    _families.put(3, img3);
    _families.put(4, img4);
    _families.put(5, img5);
    _families.put(6, img6);
    _families.put(7, img7);
   
    //Génération d'un tableau de clés associés à des images
    int family = 1;
    for (int i = 0; i < _nbTiles; i++) {
      if (i == 36 || i == 72 || i == 108 || i == 124 || i == 136 || i == 140 || i == 144)
        family++;
      _familyKey[i] = family;
    }
    shuffleArray(_familyKey);
    
    //Génération du tableau des tuiles
    int idTile = 0;
    for (int ligne = 1; ligne < _boardHeight + 1; ligne++) {
        for (int colonne = 1; colonne < _boardWidth + 1; colonne++) { 
          _tiles[idTile] = new Tile(idTile, float(colonne), float(ligne), _widthTile, _heightTile, _familyKey[idTile], _families.get(_familyKey[idTile]), false);
          idTile++;
        }
    }
    
 }
 
 
 
 
  void displayTiles() {
    for (Tile tile : _tiles) {     
      if (tile.isPressed()) {
        
        if (_selectedTiles.length == 0 && tile._isVisible) {
          _selectedTiles = (Tile[]) append(_selectedTiles, tile);
          tile._isSelected = true;
        }
        
        if (_selectedTiles.length == 1 && tile._id != _selectedTiles[0]._id && tile._isVisible) {
          _selectedTiles   = (Tile[]) append(_selectedTiles, tile);
          tile._isSelected = true;   
        }
        
      }   
      tile.displayTile();
    } 
  }
}
