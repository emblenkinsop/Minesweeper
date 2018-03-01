
import de.bezier.guido.*;
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined


void setup ()
{
  size(400, 400);
  textAlign(CENTER, CENTER);

  // make the manager
  Interactive.make( this );

  //your code to initialize buttons goes here

  buttons = new MSButton [NUM_ROWS] [NUM_COLS];
  for (int i = 0; i<NUM_ROWS; i++) {
    for (int j = 0; j<NUM_COLS; j++)
      buttons[i][j] = new MSButton(i, j);
  }

  for (int i=0; i<75; i++)
    setBombs();
}
public void setBombs()
{
  int row = (int)(Math.random()*NUM_ROWS);
  int col = (int)(Math.random()*NUM_COLS);
  if (!bombs.contains(buttons[row][col]))
    bombs.add(buttons[row][col]);
}

public void draw ()
{
  background( 0 );
  if (isWon())
    displayWinningMessage();
}
public boolean isWon()
{
  //your code here
  return false;
}
public void displayLosingMessage()
{
  //your code here
}
public void displayWinningMessage()
{
  //your code here
}

public class MSButton
{
  private int r, c;
  private float x, y, width, height;
  private boolean clicked, marked;
  private String label;

  public MSButton ( int rr, int cc )
  {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    r = rr;
    c = cc; 
    x = c*width;
    y = r*height;
    label = "";
    marked = clicked = false;
    Interactive.add( this ); // register it with the manager
  }
  public boolean isMarked()
  {
    return marked;
  }
  public boolean isClicked()
  {
    return clicked;
  }
  // called by manager



  public void mousePressed () 
  {
    clicked = true;

    if (keyPressed) {
      marked = !marked;
      if (marked == true)
        clicked = true;
      else {
        marked = false;
        clicked = false;
      }
    } else if (bombs.contains(this)) {
      displayLosingMessage();
    } else if (countBombs(r, c)>0)
      label = Integer.toString(countBombs(r, c));

    else {
      if (isValid(r-1, c) && buttons[r-1][c].isClicked() == false)
        buttons[r-1][c].mousePressed();
      if (isValid(r-1, c-1) && buttons[r-1][c-1].isClicked() == false)
        buttons[r-1][c-1].mousePressed(); 
      if (isValid(r, c-1) && buttons[r][c-1].isClicked() == false)
        buttons[r][c-1].mousePressed();
      if (isValid(r+1, c-1) && buttons[r+1][c-1].isClicked() == false)
        buttons[r+1][c-1].mousePressed();
      if (isValid(r+1, c) && buttons[r+1][c].isClicked() == false)
        buttons[r+1][c].mousePressed();
      if (isValid(r+1, c+1) && buttons[r+1][c+1].isClicked() == false)
        buttons[r+1][c+1].mousePressed();
      if (isValid(r, c+1) && buttons[r][c+1].isClicked() == false)
        buttons[r][c+1].mousePressed();
      if (isValid(r-1, c+1) && buttons[r-1][c+1].isClicked() == false)
        buttons[r-1][c+1].mousePressed();
    }
  }

  public void draw () 
  {   
    //clicked = true;  //for testing
    if (marked)
      fill(0);
    else if ( clicked && bombs.contains(this) ) 
      fill(255, 0, 0);
    else if (clicked)
      fill( 200 );
    else 
    fill( 100 );

    rect(x, y, width, height);
    fill(0);
    text(label, x+width/2, y+height/2);
  }
  public void setLabel(String newLabel)
  {
    label = newLabel;
  }
  public boolean isValid(int r, int c)
  {
    return 0<=r&&r<NUM_ROWS && 0<=c&&c<NUM_COLS;
  }
  public int countBombs(int row, int col)
  {
    int numBombs = 0;
    for (int i=row-1; i<row+2; i++)
      for (int j=col-1; j<col+2; j++)
        if (isValid(i, j))
          if (bombs.contains(buttons[i][j]))
            numBombs++;
    return numBombs;
  }
}