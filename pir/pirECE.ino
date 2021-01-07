/*This simple PIR example code was created 
 * for educational purposes by Purdue's ECE electronics
 * shop staff. Please feel free to adapt it or use is as 
 * need be. 
 */

const uint8_t PIR = 3;  //PIR sens
const uint8_t LED = 13; //status LED

void setup() {
  
  pinMode(PIR, INPUT);
  pinMode(LED, OUTPUT);

  Serial.begin(9600);   //start the serial, low baud just for test msgs 
}

void loop() {

  int pirSens = digitalRead(PIR);
  //int pirSens = analogRead(PIR); //analog processing

  //Serial.println(pirSens); //displays output


  if(pirSens == HIGH){
    digitalWrite(LED, HIGH); //turn on LED
    Serial.println("Detection!");
    delay(100);
  }else{
    digitalWrite(LED, LOW); //turn off LED
    Serial.println("Sensor Void.");
    delay(100); 
  }

  delay(1000); //slow check rate makes serial output more readable 

}
