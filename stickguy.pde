//stickguy
// item 5: diversion that enemys go to
// item 6: explode random enemy
// item 7: random explosion
// item 8: send 2 other stickfigures to rob and kill an enemy
// item 9: 
// item 0: 

ArrayList<Button> bList = new ArrayList<Button>();
ArrayList<Enemy> ENEMY = new ArrayList<Enemy>();
ArrayList<Target> TARGET = new ArrayList<Target>();
Boss a = new Boss (400,-20,1,1000);
Target obj = new Target (int(random(800)),int(random(800)));
ArrayList<pewpew> bullet= new ArrayList<pewpew>();
pewpew b = new pewpew (400,400,5);
Button bsa = new Button (60, 80, 30, 20, 1);
Button bsb = new Button (60, 130, 30, 20, 2);
Button bsc = new Button (60, 180, 30, 20, 3);
Button bsd = new Button (60, 230, 30, 20, 4);
Button bsk = new Button (60, 630, 30, 20, 11);
Button bsl = new Button (15, 80, 40, 20, 12);
Button bsm = new Button (15, 130, 40, 20, 13);
Button bsn = new Button (15, 180, 40, 20, 14);
Button bso = new Button (15, 230, 40, 20, 15);
Button bsp = new Button (15, 630, 40, 20, 22);

int LOCKTIME=0;
int ELOCKTIME=0;
int gamestate=1;
int PX=400;
int PY=400;
int HY=-35; 
int HS=18;
int SCORE=0;
int PSP=2;
int MONEY=0;
int INVTIME=0;
int SHIELDS=0;
int WIPECHARGES=0;
int PEWPEWS=0;
int EFREEZES=0;
int MONEYX=5 ;
int ESP=1;
int BSU=500;
int BHP=100;
int BMONEY=0;
int TAMONT=1;
boolean WPressed=false;
boolean APressed=false;
boolean SPressed=false;
boolean DPressed=false;
boolean HPressed=false;
boolean PPressed=false;
boolean exchange=true;
boolean damageable=true;
boolean targetsetup=true;


void setup(){
 size(800,800);
 //for(int k=0; k<1; k++){
   ENEMY.add(new Enemy(int(random(width)),-20));
  // TARGET.add(new Target(int(random(800)),int(random(800))));
   frameRate=20;
// }
}
void draw(){
  if(targetsetup){
    TARGET = new ArrayList<Target>();
    for(int k=0; k<TAMONT; k++){
      TARGET.add(new Target(int(random(800)),int(random(800))));
    }
    targetsetup=false;
  }
  if(INVTIME==0){
    INVTIME++;
    damageable=true;
  }
  if(INVTIME>1){
    damageable=false;
  }
  if(ELOCKTIME==0){
    ELOCKTIME++;
  }
  ELOCKTIME--;
  INVTIME--;
  background(255,255,255);  

  if(gamestate==3){
    //gameover/hub
    ENEMY = new ArrayList<Enemy>();
    text( "shields="+SHIELDS,600,50);
    text( "wipecharges="+WIPECHARGES,507,100);
    text( "pewpews="+PEWPEWS,557,150);
    text( "efreezes="+EFREEZES,577,200);
    fill(0);
    textSize(40);
    text( "Score="+SCORE,200,50);
    fill(0);
    textSize(40);
    text( "hit space to try again",200,200);
    text( "hit e to leave",200,300);
    text( "hit c to shop",200,350);
    text( "hit m to observe boss list",200,400);    
    text( "Money="+MONEY,200,250);
    text( "Boss Coins="+BMONEY,200,450);
    text( "hit v to enter boss shop",200,500);
    //display scores
    //reset variables
    for(int k=0; k<1; k++){
    ENEMY.add(new Enemy(int(random(width)),-20));
    HS=18;
    HY=-35;
    PSP=2;
    ESP=1;
    }
    PX=400;
    PY=400;
    if(exchange){
      MONEY=MONEY+(SCORE*MONEYX);
      exchange=false;
    }
  }
  
  //gamestate
  else if(gamestate == 2){
    //maingame
    if(ELOCKTIME>0){
      background(0,150,255);
    }
    fill(0);
    textSize(40);
    text( "Score="+SCORE,200,50);
    text( "shields="+SHIELDS,600,50);
    text( "wipecharges="+WIPECHARGES,507,100);
    text( "pewpews="+PEWPEWS,557,150);
    text( "efreezes="+EFREEZES,577,200);
    text( "invincibility="+INVTIME,100,100);
    text( "money multiplier="+MONEYX,350,750);
    b.pewpewsprite();
    b.pewpewnyoom();
    b.pewpewhit();
  }
  else if(gamestate ==6){
    //bossselection
    textSize(40);
    text( "hit 1 to select boss 1",100,100);
    text( "hit x to leave list",300,700);
  }
  else if(gamestate == 7){
    //boss1
    background(255,0,0);
    for(int k=1; k<ENEMY.size(); k++){
     ENEMY.get(k).enemys();
     if(ELOCKTIME==0){
       ENEMY.get(k).enemynyoom();
     }
     if(damageable){
       if(dist(ENEMY.get(k).ENEMYX,ENEMY.get(k).ENEMYY,PX,PY)<HS+25){
         gamestate=3;
       }
     }
   }
    a.bosssprite();
    a.bossmurdercode();
    b.pewpewsprite();
    b.pewpewnyoom();
    b.pewpewhit();
    BSU--;
    if(BSU<1){
      ENEMY.add(new Enemy(a.BOSSX,a.BOSSY));
      BSU=75;
    }
    if(LOCKTIME>0){
      LOCKTIME--;
    }
    fill(0);
    textSize(40);
    text( "Score="+SCORE,200,50);
    text( "shields="+SHIELDS,600,50);
    text( "wipecharges="+WIPECHARGES,500,100);
    text( "pewpews="+PEWPEWS,500,150);
    text( "efreezes="+EFREEZES,577,200);
    text( "invincibility="+INVTIME,100,100);
    text( "money multiplier="+MONEYX,350,750);
    text( "Boss health="+BHP,350,450);
    if(BHP==0||BHP<0){
      BMONEY=BMONEY+1;
      gamestate=3;
    }
  }
  //shop
  else if(gamestate == 4){
    text( "money="+MONEY,400,50);
    text( "money multiplier="+MONEYX,350,750);
    textSize(10);
    text( "shields="+SHIELDS,100,700);
    text( "wipecharges="+WIPECHARGES,100,715);
    text( "pewpews="+PEWPEWS,100,730);
    textSize(40);
    text( "hit x to leave shop",300,700);
    text( "shields cost 10 ",100,100);
    bsa.displaybutton1();
    bsl.displaybutton2();
    textSize(40);
    text( "wipecharges cost 25",100,150);
    bsb.displaybutton1();
    bsm.displaybutton2();
    textSize(40);
    text( "pewpews cost 5",100,200);
    bsc.displaybutton1();
    bsn.displaybutton2();
    textSize(40);
    text( "efreezes cost 15",100,250);
    bsd.displaybutton1();
    bso.displaybutton2();
    textSize(40);
    text( "multiplier cost 50",100,650);
    bsk.displaybutton1();
    bsp.displaybutton2();
    textSize(40);
    for(int b = 0; b < bList.size(); b++){
      if(bList.get(b).wasclicked()){
        if(MONEY==10||MONEY>10){
          if(bList.get(b).bp==1){
            MONEY=MONEY-10;
            SHIELDS=SHIELDS+1;
          }
        }
        if(MONEY==25||MONEY>25){
          if(bList.get(b).bp==2){
            MONEY=MONEY-25;
            WIPECHARGES=WIPECHARGES+1;
          }
        }
        if(MONEY==5||MONEY>5){
          if(bList.get(b).bp==3){
            MONEY=MONEY-5;
            PEWPEWS=PEWPEWS+1;
          }
        }
        if(MONEY==15||MONEY>15){
          if(bList.get(b).bp==4){
            MONEY=MONEY-15;
            EFREEZES=EFREEZES+1;
          }
        }
        if(MONEY==50||MONEY>50){
          if(bList.get(b).bp==11){
            MONEY=MONEY-50;
            MONEYX=MONEYX+1;
          }
        }
        if(MONEY==50||MONEY>50){
          if(bList.get(b).bp==12){
            MONEY=MONEY-50;
            SHIELDS=SHIELDS+5;
          }
        }
        if(MONEY==125||MONEY>125){
          if(bList.get(b).bp==13){
            MONEY=MONEY-125;
            WIPECHARGES=WIPECHARGES+5;
          }
        }
        if(MONEY==25||MONEY>25){
          if(bList.get(b).bp==14){
            MONEY=MONEY-25;
            PEWPEWS=PEWPEWS+5;
          }
        }
        if(MONEY==75||MONEY>75){
          if(bList.get(b).bp==15){
            MONEY=MONEY-75;
            EFREEZES=EFREEZES+5;
          }
        }
        if(MONEY==250||MONEY>250){
          if(bList.get(b).bp==22){
            MONEY=MONEY-250;
            MONEYX=MONEYX+5;
          }
        }
      }
    }
  }
  //boss shop
  else if(gamestate == 5){
    textSize(200);
    text( "OUT!!!",200,400);
    textSize(40);
    text( "money="+MONEY,400,50);
    text( "money multiplier="+MONEYX,350,750);
    text( "hit x to leave shop",300,700);
    textSize(10);
    text( "targets="+TAMONT,100,700);
    textSize(40);
    for(int b = 0; b < bList.size(); b++){
      if(bList.get(b).wasclicked()){
        
      }
    }
  }
  if(gamestate==2){
    if(HS == 1||HS == 2){
      PSP=5;
      ESP=2;
    }
    if(HS == 3||HS == 4){
      PSP=4;
      ESP=2;
    }
      if(HS == 5||HS == 6){
      PSP=3;
      ESP=2;
    }
      if(HS == 7||HS == 8){
      PSP=2;
      ESP=1;
    }
  }
  if(gamestate==7){
    if(HS == 1||HS == 2){
      PSP=5;
      ESP=1;
    }
    if(HS == 3||HS == 4){
      PSP=4;
      ESP=1;
    }
      if(HS == 5||HS == 6){
      PSP=3;
      ESP=1;
    }
      if(HS == 7||HS == 8){
      PSP=2;
      ESP=1;
    }
  }
  if(WPressed){
    PY-=PSP;
  }
  if(APressed){
    PX-=PSP;
  }
  if(SPressed){
    PY+=PSP;
  }
  if(DPressed){
    PX+=PSP;
  }
  if(HPressed){
    HY--;
    HS++;
    HS++;
  }
  if(PPressed){
    HY++;
    HS--;
    HS--;
  }
  if(PX<800){
    PX+=PSP;
  }
  if(PX>0){
    PX-=PSP;
  }
  if(PY<800){
    PY+=PSP;
  }
  if(PY>0){
    PY-=PSP;
  }
  playersprite();
  if(HS>100){
    HY++;
    HS--;
    HS--;
  }
  if(HS<1){
    HY--;
    HS++;
    HS++;
  }
 //draw enemys
 if(gamestate==2){
   for(int k=0; k<ENEMY.size(); k++){
     ENEMY.get(k).enemys();
     if(ELOCKTIME==0){
       ENEMY.get(k).enemynyoom();
     }
     if(damageable){
       if(dist(ENEMY.get(k).ENEMYX,ENEMY.get(k).ENEMYY,PX,PY)<HS+25){
         gamestate=3;
       }
     }
   }
   for (int k=0; k<TARGET.size(); k++){
     TARGET.get(k).targetsprite();
     TARGET.get(k).targetcontact();
   }
 }
 if(gamestate == 1){
   //startscreen
   background(155,0,255);
   fill(255,0,0);
   textSize(40);
   text( "welcome to random stick guy ",150,100);
   text("running from red spheres and",150,150);
   text("collecting blueish ones!",150,200);
   text("made by:",50,300);
   textSize(20);
   text("me",50,325);
   text("my teachers help",50,350);
   textSize(30);
   text("hit space to start",300,600);
   text("w a s d to move",300,640);
   text("h p to change head size",300,680);
   text("1 2 3 4 5 6 7 8 9 0 to use items",200,720);
   text("test stuff to gain more knowledge",200,760);  
   textSize(80);
   text("this is the only time",100,420);
   text("you see this screen",100,520);

  }
}
void keyPressed(){
  if(gamestate == 3){
    if(key == ' '){
      bullet= new ArrayList<pewpew>();
      SCORE=0;
      gamestate=2;
      exchange=true;
      targetsetup=true;
    }
    if(key=='e'||key=='E'){
      exit();
    }
    if(key=='M'||key=='m'){
      gamestate=6;
    }
  }
  if(gamestate==6){
    if(key=='X'||key=='x'){
      gamestate=3;
    }
    if(key=='1'||key=='!'){
      LOCKTIME=335;
      BSU=500;
      BHP=100;
      gamestate=7;
      a = new Boss(400, -20, 1,2500);
      bullet= new ArrayList<pewpew>();
    }
  }
  if(gamestate == 1){
    if(key == ' '){
      gamestate=2;
    }
  }
  if(gamestate == 2||gamestate == 7){
    if(LOCKTIME<1){
      if(key=='w'||key=='W'){
        WPressed=true;
      }
      if(key=='a'||key=='A'){
        APressed=true;
      } 
      if(key=='s'||key=='S'){
        SPressed=true;
      } 
      if(key=='d'||key=='D'){
        DPressed=true;
      } 
      if(key=='h'||key=='H'){
        HPressed=true;
      }
      if(key=='p'||key=='P'){
        PPressed=true;
      }
      if(SHIELDS>0){
        if(key=='1'||key=='!'){
          INVTIME=INVTIME+100;
          SHIELDS--;
        }
      }
      if(WIPECHARGES>0){
        if(key=='2'||key=='@'){
          ENEMY = new ArrayList<Enemy>();
          WIPECHARGES--;
          BHP=BHP-10;
          background(50,0,255);
        }
      }
      if(PEWPEWS>ENEMY.size()||PEWPEWS==ENEMY.size()){
        if(key=='3'||key=='#'){
          if(ENEMY.size()>0){
            bullet.add(new pewpew(PX,PY,4));
            PEWPEWS--;
          }
        }
      }
      if(EFREEZES>0){
        if(key=='4'||key=='$'){
          EFREEZES--;
          ELOCKTIME=ELOCKTIME+100;
        }
      }
    }
  }  
  if(gamestate == 3){
    if(key=='c'||key =='C'){
      gamestate=4;
    }
    if(key=='v'||key =='V'){
      gamestate=5;
    }
  }
}

void keyReleased(){
  if(gamestate == 4 || gamestate == 5){
      if(key=='x'||key =='X'){
        gamestate=3;
      }
  }
  if(key=='w'||key=='W'){
    WPressed=false;
  }
  if(key=='a'||key=='A'){
    APressed=false;
  } 
  if(key=='s'||key=='S'){
    SPressed=false;
  } 
  if(key=='d'||key=='D'){
    DPressed=false;
  } 
  if(key=='h'||key=='H'){
    HPressed=false;
  }
  if(key=='p'||key=='P'){
    PPressed=false;
  }
  
}

void mouseReleased(){
  bsa.release();
  bsb.release();
  bsc.release();
  bsd.release();
  bsk.release();
  bsl.release();
  bsm.release();
  bsn.release();
}
class Enemy{
  int ENEMYX;
  int ENEMYY;
  int ESP=1;
  Enemy(int tex, int tey){
    ENEMYX = tex;
    ENEMYY = tey;
  }
  void enemys(){
   //enemy
   fill(255,0,0);
   circle(ENEMYX,ENEMYY,30);
   circle(ENEMYX+random(-30,30),ENEMYY+random(-30,30),3);
   circle(ENEMYX+random(-30,30),ENEMYY+random(-30,30),3);
   circle(ENEMYX+random(-30,30),ENEMYY+random(-30,30),3);
   circle(ENEMYX+random(-30,30),ENEMYY+random(-30,30),3);
   circle(ENEMYX+random(-30,30),ENEMYY+random(-30,30),3);
   circle(ENEMYX+random(-30,30),ENEMYY+random(-30,30),3);
   
  }
  void enemynyoom(){
    nyoomsped();
    if(ENEMYX<PX){
       ENEMYX=ENEMYX+ESP;
     }
     if(ENEMYX>PX){
       ENEMYX=ENEMYX-ESP;
     }
     if(ENEMYY>PY){
       ENEMYY=ENEMYY-ESP;
     }
     if(ENEMYY<PY){
       ENEMYY=ENEMYY+ESP;
     }
  }
  void nyoomsped(){
    if(gamestate==2){
      if(HS == 1||HS == 2){
        ESP=2;
      }
      if(HS == 3||HS == 4){
        ESP=2;
      }
        if(HS == 5||HS == 6){
        ESP=2;
      }
        if(HS == 7||HS == 8){
        ESP=1;
      }
    }
  }
}
class Boss{
  int BOSSX;
  int BOSSY;
  int BSP=1;
  int BSPI=5000;
  Boss(int bx, int by, int bs, int bi){
    BOSSX = bx;
    BOSSY = by;
    BSP = bs;
    BSPI = bi;
  }
  void bossnyoom(){
    if(BOSSX<PX){
      BOSSX=BOSSX+BSP;
    }
    if(BOSSX>PX){
      BOSSX=BOSSX-BSP;
    }
    if(BOSSY>PY){
      BOSSY=BOSSY-BSP;
    }
    if(BOSSY<PY){
      BOSSY=BOSSY+BSP;
    }
  }
  void bossmurdercode(){
    if(damageable){
      if(dist(BOSSX,BOSSY,PX,PY)<HS+50){
        gamestate=3;
      }
    }
  }
  void bosssprite(){
    //boss
     fill(100,100,100);
     circle(BOSSX,BOSSY,50);
     circle(BOSSX+random(-50,50),BOSSY+random(-50,50),5);
     circle(BOSSX+random(-50,50),BOSSY+random(-50,50),5);
     circle(BOSSX+random(-50,50),BOSSY+random(-50,50),5);
     circle(BOSSX+random(-50,50),BOSSY+random(-50,50),5);
     circle(BOSSX+random(-50,50),BOSSY+random(-50,50),5);
     circle(BOSSX+random(-50,50),BOSSY+random(-50,50),5);
     fill(0,0,0);
     bossnyoom();
     bossnyoomer();
     }
  void bossnyoomer(){
    BSPI--;
    if(BSPI<1){
      BSP++;
      BSPI=1000;
    }
  }
}
void playersprite(){
  //player
  line(PX+random(-3,3),PY+random(23,27),PX+random(-3,3),PY-random(23,27));
  line(PX+random(-2,2),PY-20,PX+random(2,7),PY+random(1,5));
  line(PX+random(-2,2),PY-20,PX-random(2,7),PY+random(1,5));
  line(PX+random(-2,2),PY+25,PX-random(1,10),PY+random(35,40));
  line(PX+random(-2,2),PY+25,PX+random(1,10),PY+random(35,40));
  noFill();
  circle(PX,PY+HY,HS);
}
class pewpew{
  int PEWPEWX;
  int PEWPEWY;
  int pesp=1;
  pewpew(int pex, int pey, int pespe){
    PEWPEWX = pex;
    PEWPEWY = pey;
    pesp = pespe;
  }
  void pewpewhit(){
    for(int k=0;k<bullet.size();k++){      
      if(ENEMY.size()>0){
        if(dist(bullet.get(k).PEWPEWX,bullet.get(k).PEWPEWY,ENEMY.get(0).ENEMYX,ENEMY.get(0).ENEMYY)<32){
          ENEMY.remove(0);
          bullet.remove(k);
          BHP=BHP-2;
        }
      }
    }
  }
  void pewpewcode(){
    pewpewsprite();
    pewpewnyoom();
  }
  void pewpewsprite(){
   //pewpew
   for(int k=0;k<bullet.size();k++){
     fill(0,255,0);
     circle(bullet.get(k).PEWPEWX,bullet.get(k).PEWPEWY,3);
   }
  }
  void pewpewnyoom(){
    if(ENEMY.size()>0){
      for(int k=0;k<bullet.size();k++){
        if(bullet.get(k).PEWPEWX<ENEMY.get(0).ENEMYX){
            bullet.get(k).PEWPEWX=bullet.get(k).PEWPEWX+pesp;
          }
          if(bullet.get(k).PEWPEWX>ENEMY.get(0).ENEMYX){
            bullet.get(k).PEWPEWX=bullet.get(k).PEWPEWX-pesp;
          }
          if(bullet.get(k).PEWPEWY>ENEMY.get(0).ENEMYY){
            bullet.get(k).PEWPEWY=bullet.get(k).PEWPEWY-pesp;
          }
          if(bullet.get(k).PEWPEWY<ENEMY.get(0).ENEMYY){
            bullet.get(k).PEWPEWY=bullet.get(k).PEWPEWY+pesp;
          }
      }
    }
  }
}
class Target{
  int OX=int(random(800));
  int OY=int(random(800));
  Target(int tx, int ty){
    OX=tx;
    OY=ty;
  }
  void targetsprite(){
    //target
    fill(155,0,255);
    circle(OX,OY,30);
    circle(OX+random(-30,30),OY+random(-30,30),3);
    circle(OX+random(-30,30),OY+random(-30,30),3);
    circle(OX+random(-30,30),OY+random(-30,30),3);
    circle(OX+random(-30,30),OY+random(-30,30),3);
    circle(OX+random(-30,30),OY+random(-30,30),3);
    circle(OX+random(-30,30),OY+random(-30,30),3);
  }
  void targetcontact(){
    if(dist(OX,OY,PX,PY)<HS+25){
      OX=int(random(800));
      OY=int(random(800));
      SCORE=SCORE+1;
      ENEMY.add(new Enemy(int(random(width)),-20));
    }
  }
}
class Button{
  int bx;
  int by;
  int bw;
  int bh;
  int bp;
  boolean released;
  Button(int tx,int ty,int tw,int th,int tp){
    bx=tx;
    by=ty;
    bw=tw;
    bh=th;
    bp=tp;
    released=true;
    bList.add(this);
  }
  void displaybutton1(){
    fill(255,0,0);
    rect(bx,by,bw,bh);
    textSize(15);
    fill(0,0,0);
    text( "buy",bx+8,by+17);
  }
  void displaybutton2(){
    fill(255,0,0);
    rect(bx,by,bw,bh);
    textSize(15);
    fill(0,0,0);
    text( "buy 5",bx+3,by+17);
  }
  boolean wasclicked(){
    return (press() && (mouseX >bx && mouseX <bx+bw && mouseY > by && mouseY < by+bh));
  }
  boolean press(){
    if(released){
      released = false;
      return true;
    }
      return false;
  }
  void release(){
    for(int b = 0; b < bList.size(); b++){
       bList.get(b).released =true;
     }
  }
  
}
