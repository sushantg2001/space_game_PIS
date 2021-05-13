import ddf.minim.*;
import processing.serial.*;
Serial myPort;  // Create object from Serial class
Serial myPort2;
String val;
String val2;
Minim minim;
AudioPlayer a;
int x=890, y=950; 
int x1=300,y1=950;
int x2=1600,y2=950;
int width_r=70,height_r=70;
int width_a=70,height_a=70;
int screen=0;
int gameover=0;
int score=(950-y);
int temp=0;
int score1=(950-y1);
int lvl=0;
int temp1=0;
int score2=(950-y2);
int temp2=0;
int h1=0;
int h2=0;
int p1=0;
int p2=0;
int direction=0;
int direction2=0;
PImage rocket, background, asteroid,rocket2;          //image type variable to rocket

PImage[] asteroidRow1 = new PImage[5];
int[] ax= {0,400,800,1200,1600};

PImage[] asteroidRow2 = new PImage[4];
int[] a_row2_x={0,400,800,1200};

PImage[] asteroidRow3 = new PImage[5];
int[] a_row3_x={0,300,670,980,1458};
int[] ay={200,460,760};


PFont myFont;        // declare font type to myFont
void setup()
{ frameRate(240);
  size(1920, 1080);       // set the size of canvas
  rocket=loadImage("rocket.png");        //function to load the image in variable rocket 
  rocket2=loadImage("rocket2.png");  
  for (int i=0; i < asteroidRow1.length; i++) 
    asteroidRow1[i]=loadImage("asteroid"+i+".png");
     
  for (int i=0; i < asteroidRow2.length; i++)
    asteroidRow2[i]=loadImage("a2"+i+ ".png");  
    
   for(int i=0; i<asteroidRow3.length;++i)
     asteroidRow3[i]=loadImage("a3"+i+".png");
 
  background=loadImage("bg.jpg"); //background
  myFont = createFont("Arial", 60, true);  //used to create the font and save it ti the variable myFont
  textFont(myFont); //used to assign the textFont myFont 
  minim = new Minim(this);
  a = minim.loadFile("background.mp3");    //load aaa into a
 String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
 String portName2 = Serial.list()[1];
  myPort = new Serial(this, portName, 9600);
  myPort2 = new Serial(this,portName2, 9600); 
  a.play();
}

void draw()
{ 
  if(gameover==0)
{
  if(screen==0)
  {
  background(background);
  fill(134, 141, 135, 70);
  rect(0, 200, width, 100);
  fill(255, 0, 0);
  textAlign(CENTER);
  text("Click here for 1 player", width/2, 270);
  fill(134, 141, 135, 70);
  rect(0, 400, width, 100);
  fill(255, 0, 0);
  text("Click here for 2 player", width/2, 470);
  fill(134, 141, 135, 70);
  rect(0, 600, width, 100);
  fill(255, 0, 0);
  text("press esc to exit", width/2, 670);
  }
  
  if (keyPressed)
      if(keyCode == ESC)
         exit();
    
  if(screen==1)
  {
          background(background);
          image(rocket, x, y);
          imageMode(CORNER);
  
           for(int i=0;i<5;++i)
           {   
             image(asteroidRow1[i],ax[i],ay[0]);
             ax[i]=ax[i]+1+lvl;    
           }  
           for(int i=0;i<4;++i)
             {
                image(asteroidRow2[i],a_row2_x[i],ay[1]);
                a_row2_x[i]=a_row2_x[i]-1-lvl;  
             }
           
          for(int i=0;i<5;++i)
            {
                 image(asteroidRow3[i],a_row3_x[i],ay[2]); 
                 a_row3_x[i]=a_row3_x[i]+1+lvl;
            }
          
           for (int j=0; j<5; ++j)
              if (ax[j]>=width)
                  ax[j]=0;  
             
           for(int j=0; j<4; ++j)
             if (a_row2_x[j]<=0)
                 a_row2_x[j]=1920;    
            
          
          for(int j=0;j<5;++j)
            if(a_row3_x[j]>=width)
              a_row3_x[j]=0;
      
          if (y<=0)
            y=950;
          if (x<0)
            x=1920;
          if(x>1920)
            x=0;
          if(y>1080)
            y=950;
            for(int j=0; j<5; ++j)
              { if(x>=ax[j] && x<= (ax[j]+width_a) && y>=ay[0] && y<=(ay[0]+height_a))
                { ;    
                  
                  gameover=1;
                }
                if( (x+width_r)>=ax[j] && (x+width_r)<= (ax[j]+width_a) && y>=ay[0] && y<=(ay[0]+height_a))
                { ;    
                  gameover=1;
                  
                }  
                 if(x>=ax[j] && x<= (ax[j]+width_a) && (y+height_r)>=ay[0] && (y+height_r)<=(ay[0]+height_a))
                { ;    
                  gameover=1;
                  
                }  
                 if( (x+width_r)>=ax[j] && (x+width_r)<= (ax[j]+width_a) && (y+height_r)>=ay[0] && (y+height_r)<=(ay[0]+height_a))
                { ;    
                  gameover=1;
                  
                }       
                
              }
            for(int j=0; j<4; ++j)
              { if(x>=a_row2_x[j] && x<= (a_row2_x[j]+width_a) && y>=ay[1] && y<=(ay[1]+height_a))
                { ;    
                  gameover=1;
          
                }
                if( (x+width_r)>=a_row2_x[j] && (x+width_r)<= (a_row2_x[j]+width_a) && y>=ay[1] && y<=(ay[1]+height_a))
                { ;    
                  gameover=1;
                 
                }  
                 if(x>=a_row2_x[j] && x<= (a_row2_x[j]+width_a) && (y+height_r)>=ay[1] && (y+height_r)<=(ay[1]+height_a))
                { ;    
                  gameover=1;
                }  
                 if( (x+width_r)>=a_row2_x[j] && (x+width_r)<= (a_row2_x[j]+width_a) && (y+height_r)>=ay[1] && (y+height_r)<=(ay[1]+height_a))
                { ;    
                  gameover=1;
                }       
              }
    
    
           for(int j=0; j<5; ++j)
            { if(x>=a_row3_x[j] && x<= (a_row3_x[j]+width_a) && y>=ay[2] && y<=(ay[2]+height_a))
              { ;    
                gameover=1;
              }
              if( (x+width_r)>=a_row3_x[j] && (x+width_r)<= (a_row3_x[j]+width_a) && y>=ay[2] && y<=(ay[2]+height_a))
              { ;    
                gameover=1;
              }  
               if(x>=a_row3_x[j] && x<= (a_row3_x[j]+width_a) && (y+height_r)>=ay[2] && (y+height_r)<=(ay[2]+height_a))
              { ;    
                gameover=1;
              }  
               if( (x+width_r)>=a_row3_x[j] && (x+width_r)<= (a_row3_x[j]+width_a) && (y+height_r)>=ay[2] && (y+height_r)<=(ay[2]+height_a))
              { ;    
                gameover=1;
              }
            }
            score=950-y;
            if (score==870)
              temp=1;
             if(temp==1 && score ==0) 
              {
               lvl++;
               temp=0;
              }
            text("score:"+score,1700.0,50.0);
            text("Level:"+lvl,1700.0,100);
            



      /*val= myPort.readStringUntil('\n');
      
      val=trim(val);
      
      println(val);
      
      if(val=="0")
        println("touched");*/

  }          
    

if(screen==2)
  {       
      if (keyPressed)
      if(keyCode == ESC)
         exit();
         
          background(background);
          image(rocket,x1,y1);
          image(rocket2,x2,y2);
          imageMode(CORNER);
            
                     for(int i=0;i<5;++i)
           {   
             image(asteroidRow1[i],ax[i],ay[0]);
             ax[i]=ax[i]+1+lvl;    
           }  
           for(int i=0;i<4;++i)
             {
                image(asteroidRow2[i],a_row2_x[i],ay[1]);
                a_row2_x[i]=a_row2_x[i]-1-lvl;  
             }
           
          for(int i=0;i<5;++i)
            {
                 image(asteroidRow3[i],a_row3_x[i],ay[2]); 
                 a_row3_x[i]=a_row3_x[i]+1+lvl;
            }
          
           for (int j=0; j<5; ++j)
              if (ax[j]>=width)
                  ax[j]=0;  
             
           for(int j=0; j<4; ++j)
             if (a_row2_x[j]<=0)
                 a_row2_x[j]=1920;    
            
          
          for(int j=0;j<5;++j)
            if(a_row3_x[j]>=width)
              a_row3_x[j]=0;
          
          if (y1<=0)
           {y1=950;
            h1++;
            if(h1==3)
            p1++;
        }           
          if (x1<0)
            x1=1920;
          if(x1>1920)
            x1=0;
          if(y1>1080)
            y1=950;
                      
              
          if (y2<=0)
            {y2=950;
            h2++;
            if(h2==3)
            p2++;
           }
          if (x2<0)
            x2=1920;
          if(x2>1920)
            x2=0;
          if(y2>1080)
            y2=950;  

              
          if(h1==1 && h2==1)
            lvl=1;
          if(h1==2 && h2==2)
            lvl=2;
          if(h1==3 || h2==3)
          gameover=1;
          
          
            
            for(int j=0; j<5; ++j)
              { if(x1>=ax[j] && x1<= (ax[j]+width_a) && y1>=ay[0] && y1<=(ay[0]+height_a))
                {x1=300;
                 y1=950;
                }
                if( (x1+width_r)>=ax[j] && (x1+width_r)<= (ax[j]+width_a) && y1>=ay[0] && y1<=(ay[0]+height_a))
               { x1=300;
                y1=950;
                  
                }  
                 if(x1>=ax[j] && x1<= (ax[j]+width_a) && (y1+height_r)>=ay[0] && (y1+height_r)<=(ay[0]+height_a))
                {     
                x1=300;
                y1=950;
                  
                }  
                 if( (x1+width_r)>=ax[j] && (x1+width_r)<= (ax[j]+width_a) && (y1+height_r)>=ay[0] && (y1+height_r)<=(ay[0]+height_a))
                {     
                x1=300;
                y1=950;
                  
                }       
                
              }
            for(int j=0; j<4; ++j)
              { if(x1>=a_row2_x[j] && x1<= (a_row2_x[j]+width_a) && y1>=ay[1] && y1<=(ay[1]+height_a))
                { 
                x1=300;
                y1=950;
          
                }
                if( (x1+width_r)>=a_row2_x[j] && (x1+width_r)<= (a_row2_x[j]+width_a) && y1>=ay[1] && y1<=(ay[1]+height_a))
                {    
                x1=300;
                y1=950;
                 
                }  
                 if(x1>=a_row2_x[j] && x1<= (a_row2_x[j]+width_a) && (y1+height_r)>=ay[1] && (y1+height_r)<=(ay[1]+height_a))
                {    
                x1=300;
                y1=950;
                }  
                 if( (x1+width_r)>=a_row2_x[j] && (x1+width_r)<= (a_row2_x[j]+width_a) && (y1+height_r)>=ay[1] && (y1+height_r)<=(ay[1]+height_a))
                {     
                x1=300;
                y1=950;
                }       
              }
    
    
           for(int j=0; j<5; ++j)
            { if(x1>=a_row3_x[j] && x1<= (a_row3_x[j]+width_a) && y1>=ay[2] && y1<=(ay[2]+height_a))
              {
                x1=300;
                y1=950;
              }
              if( (x1+width_r)>=a_row3_x[j] && (x1+width_r)<= (a_row3_x[j]+width_a) && y1>=ay[2] && y1<=(ay[2]+height_a))
              {    
                x1=300;
                y1=950;
              }  
               if(x1>=a_row3_x[j] && x1<= (a_row3_x[j]+width_a) && (y1+height_r)>=ay[2] && (y1+height_r)<=(ay[2]+height_a))
              {     
                x1=300;
                y1=950;
              }  
               if( (x1+width_r)>=a_row3_x[j] && (x1+width_r)<= (a_row3_x[j]+width_a) && (y1+height_r)>=ay[2] && (y1+height_r)<=(ay[2]+height_a))
              {    
                x1=300;
                y1=950;
              }       
            }
            
            for(int j=0; j<5; ++j)
              { if(x2>=ax[j] && x2<= (ax[j]+width_a) && y2>=ay[0] && y2<=(ay[0]+height_a))
                {x2=1600;
                 y2=950;
                }
                if( (x2+width_r)>=ax[j] && (x2+width_r)<= (ax[j]+width_a) && y2>=ay[0] && y2<=(ay[0]+height_a))
               { x2=1600;
                y2=950;
                  
                }  
                 if(x2>=ax[j] && x2<= (ax[j]+width_a) && (y2+height_r)>=ay[0] && (y2+height_r)<=(ay[0]+height_a))
                {     
                x2=1600;
                y2=950;
                  
                }  
                 if( (x1+width_r)>=ax[j] && (x1+width_r)<= (ax[j]+width_a) && (y1+height_r)>=ay[0] && (y1+height_r)<=(ay[0]+height_a))
                {     
                x2=1600;
                y2=950;
                  
                }       
                
              }
            for(int j=0; j<4; ++j)
              { if(x2>=a_row2_x[j] && x2<= (a_row2_x[j]+width_a) && y2>=ay[1] && y2<=(ay[1]+height_a))
                { 
                x2=1600;
                y2=950;
          
                }
                if( (x2+width_r)>=a_row2_x[j] && (x2+width_r)<= (a_row2_x[j]+width_a) && y2>=ay[1] && y2<=(ay[1]+height_a))
                {    
                x2=1600;
                y2=950;
                 
                }  
                 if(x2>=a_row2_x[j] && x2<= (a_row2_x[j]+width_a) && (y2+height_r)>=ay[1] && (y2+height_r)<=(ay[1]+height_a))
                {    
                x2=1600;
                y2=950;
                }  
                 if( (x2+width_r)>=a_row2_x[j] && (x2+width_r)<= (a_row2_x[j]+width_a) && (y2+height_r)>=ay[1] && (y2+height_r)<=(ay[1]+height_a))
                {     
                x2=1600;
                y2=950;
                }       
              }
    
    
           for(int j=0; j<5; ++j)
            { if(x2>=a_row3_x[j] && x2<= (a_row3_x[j]+width_a) && y2>=ay[2] && y2<=(ay[2]+height_a))
              {
                x2=1600;
                y2=950;
              }
              if( (x2+width_r)>=a_row3_x[j] && (x2+width_r)<= (a_row3_x[j]+width_a) && y2>=ay[2] && y2<=(ay[2]+height_a))
              {    
                x2=1600;
                y2=950;
              }  
               if(x2>=a_row3_x[j] && x2<= (a_row3_x[j]+width_a) && (y2+height_r)>=ay[2] && (y2+height_r)<=(ay[2]+height_a))
              {     
                x2=1600;
                y2=950;
              }  
               if( (x2+width_r)>=a_row3_x[j] && (x2+width_r)<= (a_row3_x[j]+width_a) && (y2+height_r)>=ay[2] && (y2+height_r)<=(ay[2]+height_a))
              {    
                x2=1600;
                y2=950;
              }       
            }
            
     if(direction==1)
     {
       x1=x1+2;
     }
     if(direction==2)
     {
       x1=x1-2;
     }
     if(direction==3)
     {
       y1=y1-2;
     }
     if(direction2==1)
     {
       x2=x2-2;
     }
     if(direction2==2)
     {
       x2=x2+2;
     }
     if(direction2==3)
     {
       y2=y2-2;
     }
     

text("Player1:"+h1,1700.0,100);
text("Player2:"+h2,1700.0,170);

  
/*if(keyPressed)
  {if (keyCode == RIGHT)
    x1=x1+10;                  
  if  (keyCode == LEFT) 
    x1=x1-10;
  if (keyCode == UP)
    y1=y1-10; 
  }
  if(keyPressed)
  {if(key == 'a')
   x2=x2-10;
  if(key == 'd')
   x2=x2+10;
   if(key == 'w')
    y2=y2-10;}
*/

}//screen 2
  
}
if(gameover==1)
{ if(screen==1)
{ fill(41,36,218);
  rect(0,0,width,height);
  fill(255,0,0);
  textAlign(CENTER);
  textSize(100);
  text("GAME OVER",width/2,300);
  textSize(60);
  text("LEVEL -",900,400);
  text("SCORE -",900,500);
  text(lvl,1080,400);
  text(score,1080,500);
}
if(screen==2)
{
  fill(41,36,218);
  rect(0,0,width,height);
  fill(255,0,0);
  textAlign(CENTER);
  textSize(100);
  text("GAME OVER",width/2,300);
  textSize(150);
  if(p1==1)
  {text("PLAYER 1 WINS",width/2,600);}
  if(p2==1)
  {text("PLAYER 2 WINS",width/2,600);}
  }
}
}


  void serialEvent (Serial port){
  if(screen==1)
    {
    String val = port.readStringUntil('\n');
            
        if (val != null)
        { 
          val = trim(val); 
          String[] indata = split(val, ',');
          float up=float(indata[1]);
          if(up==1.0)
          {
          y=y-6;
          }
         float angle=float(indata[0]);
         if(angle>=250 && angle<=320)
         {
           x=x-10;
         }
         if(angle<=90 && angle>=30)
         {
           x=x+10;
         }
        
   }
    }
    
   if(screen==2)
   { if(port==myPort)
     {String val = port.readStringUntil('\n');
         if (val != null)
        { 
          val = trim(val); 
          String[] indata = split(val, ',');
          float up=float(indata[1]);
          if(up==1.0)
          {
          y1=y1-6;
          }
         float angle=float(indata[0]);
         if(angle>=250 && angle<=320)
         {
           x1=x1-10;
         }
         if(angle<=90 && angle>=30)
         {
           x1=x1+10;
         }
        }
     }
      if(port==myPort2)
      {String val2 = port.readStringUntil('\n');
            
        if (val2 != null)
        { 
          val2 = trim(val2); 
          String[] indata2 = split(val2, ',');
          float up2=float(indata2[1]);
          if(up2==1.0)
          {
          y2=y2-6;
          }
         float angle2=float(indata2[0]);
         if(angle2>=250 && angle2<=320)
         {
           x2=x2-10;
         }
         if(angle2<=90 && angle2>=30)
         {
           x2=x2+10;
         }
        }
      }
   }
     
  }



void keyPressed() 
{     
  //---CONTROLS PLAYER---//
  if(screen==1)
  {
  if (keyCode == RIGHT)
    x=x+10;                  // how much to move rocket left or right
  if  (keyCode == LEFT) 
    x=x-10;
  if (keyCode == UP)
    y=y-10;                  //how much to move rocket up and down
  }
    if(screen==2)
  {
  if (keyCode == RIGHT)
    direction=1;
  if  (keyCode == LEFT) 
     direction=2;
  if (keyCode == UP)
       direction=3;
  if(key == 'a')
     direction2=1;
  if(key == 'd')
     direction2=2;
   if(key == 'w')
      direction2=3;

}
}

void mousePressed()
{ if(gameover==0)
  {
   if(mouseX>=0 && mouseX<=width && mouseY>=200 && mouseY<=300)
   screen=1;
  if(mouseX>=0 && mouseX<=width && mouseY>=400 && mouseY<=500)
   screen=2;
  }
  if(gameover==1)
  { if(screen==1)
    {gameover=0;
    screen=0;
    x=890;
    y=950;
    lvl=0;
    score=0;}
    if(screen==2)
    {
    gameover=0;
    screen=0;
    x1=300;
    y1=950;
    x2=1600;
    y2=950;
    lvl=0;
    h1=0;
    h2=0;
    p1=0;
    p2=0;
    direction=0;
    direction2=0;
    score1=0;
    score2=0;
    textSize(60); 
}
    
}
}
