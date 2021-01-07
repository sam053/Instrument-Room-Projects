//Coordinator code for Arduino Xbee Purdue Electronics Shop tutorial 
/*There is a bit more explaining to do for this example as compared to the
 * router code. Follow the comments to get a technical explination. The code here 
 * receives fram data from the xbee. Prints it so we can study it in the serial, and it also 
 * parses through it to determine if a bit on the router is set on or off.
 */
 
int readValue = 0;

void setup() {  //runs on the arduino once 
  Serial.begin(9600);  //set the baud rate ... the same as the Xbee's
  pinMode(13, OUTPUT); //set a DIO pin for your output
}

void loop() { //keeps running after setup 
  
  if(Serial.available() > 21) //check to see if we are recieving the data 
  {

    //***NOTE**** If you uncomment the first section the functionallity of the data will not work anymore
    //can't both be run at the same time as of now

  //Print Frame data Section
  //This section lets us see the stack from being interpreted at the time in the serial monitor.
/*   
    for(int i = 0; i < 22; i++){ //print all the bits of the current transmission 
      Serial.print(Serial.read(), HEX);
      Serial.print("_"); //spaces all the bits
    }
    Serial.println(); //helps keep spacing / easier to read 
*/


  //Parse frame data Section 
  //This section checks the stack frame of the data 
    if(Serial.read() == 0x7E) 
    {
      for(int i = 0; i < 19; i++)
      {
        byte discard = Serial.read();
      }
      
      readValue = Serial.read();
      Serial.println(readValue); 
      
      if(readValue == 0)
      {
        Serial.println("off");
        digitalWrite(13, LOW);
      }
      else if(readValue == 1)
      {
        Serial.println("on");
        digitalWrite(13, HIGH);
      }
    }
    
    Serial.println(); //easier to read

  }
}

  
