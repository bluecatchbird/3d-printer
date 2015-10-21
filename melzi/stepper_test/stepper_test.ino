/********************************************************
**         More info about the project at:             **
**  http://lusorobotica.com/index.php?topic=106.0  **
**   by TigPT         at         [url=http://www.LusoRobotica.com]www.LusoRobotica.com[/url]  **
*********************************************************/

/*
#define X_STEP_PIN         15
#define X_DIR_PIN          21

*/
#define Y_STEP_PIN         22
#define Y_DIR_PIN          23
#define Y_MIN_PIN          19

#define LED_PIN            27
#define ENABLE_PIN       14



void setup() {
  pinMode(Y_STEP_PIN, OUTPUT);
  pinMode(Y_DIR_PIN, OUTPUT);

  // ENABLE
  pinMode(ENABLE_PIN, OUTPUT);
  digitalWrite(ENABLE_PIN, LOW);

  pinMode(LED_PIN, OUTPUT);
}

void step(boolean dir,int steps){
  
  digitalWrite(Y_DIR_PIN,dir);
  delay(50);
  
  for(int i=0;i<steps;i++)
  {
    digitalWrite(Y_STEP_PIN, HIGH);
    delayMicroseconds(200);


    digitalWrite(Y_STEP_PIN, LOW);
    delayMicroseconds(200);
  }
}

void loop()
{
  digitalWrite(LED_PIN, HIGH);
  step(true,1600);
  delay(500);

//  digitalWrite(LED_PIN, LOW);
//  step(false,16000);
//  delay(500);
}
