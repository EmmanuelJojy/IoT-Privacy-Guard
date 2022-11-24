
#include <stdio.h>
#include <ESP8266WebServer.h>

#define server http_rest_server
#define HTTP_REST_PORT 80

#define LED1 5 // D1
#define LED2 4 // D2

char* ssid = "AndroidAP7AC7";
char* pass = "abcdefgh";
char* json = "abcdefghijklmnopqrstuvwxyz";

int sled1 = 0, sled2 = 0;

ESP8266WebServer server(HTTP_REST_PORT);

void refresh() {
  sprintf(json, "{\"LED1\":\"%d\", \"LED2\":\"%d\"}", sled1, sled2);
  server.send(200, "application/json", json);
}

void led1on() {
  Serial.println("HTTP GET called on LED-1-ON");
  digitalWrite(LED1, HIGH); sled1 = 1; refresh();
}

void led1off() {
  Serial.println("HTTP GET called on LED-1-OFF");
  digitalWrite(LED1, LOW); sled1 = 0; refresh();
}

void led2on() {
  Serial.println("HTTP GET called on LED-1-ON");
  digitalWrite(LED2, HIGH); sled2 = 1; refresh();
}

void led2off() {
  Serial.println("HTTP GET called on LED-1-OFF");
  digitalWrite(LED2, LOW); sled2 = 0; refresh();
}

void route() {
  server.on("/", HTTP_GET, refresh);
  server.on("/LED/1/ON", HTTP_GET, led1on);
  server.on("/LED/1/OFF", HTTP_GET, led1off);
  server.on("/LED/2/ON", HTTP_GET, led2on);
  server.on("/LED/2/OFF", HTTP_GET, led2off);  
}

void setup(void) {  
  pinMode(LED1, OUTPUT); digitalWrite(LED1, LOW);
  pinMode(LED2, OUTPUT); digitalWrite(LED2, LOW);
  delay(1000);
    
  Serial.begin(115200); 
  Serial.print("Connecting to: ");
  Serial.println(ssid);
  
  WiFi.mode(WIFI_STA); WiFi.begin(ssid, pass);
  while(WiFi.status() != WL_CONNECTED) { Serial.print("*"); delay(500); }
  
  Serial.print("\nConnected to Wi-Fi: "); Serial.println(WiFi.SSID());
  Serial.print("The URL of ESP8266 Web Server is: http://"); Serial.println(WiFi.localIP());  
  delay(1000);
  route(); server.begin();
  
  Serial.println("HTTP REST Server Live");
}

void loop(void) {
  server.handleClient();
}