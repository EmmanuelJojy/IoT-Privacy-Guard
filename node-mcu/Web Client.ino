
#include <stdio.h>
#include <ESP8266WebServer.h>

#define server http_rest_server
#define HTTP_REST_PORT 80

#define LED1 5 // D1
#define LED2 4 // D2

char* ssid = "AndroidAP7AC7";
char* pass = "abcdefghij";
char* json = "abcdefghijklmnopqrstuvwxyz";

ESP8266WebServer server(HTTP_REST_PORT);

void start() {
  Serial.println("ST");
  sprintf(json, "{\"msg\":\"msg\"}");
  server.send(200, "application/json", json);
}

void increment() {
  Serial.println("IN");
  sprintf(json, "{\"msg\":\"msg\"}");
  server.send(200, "application/json", json);
}

void route() {
  server.on("/ST", HTTP_GET, start);
  server.on("/IN", HTTP_GET, increment);  
}

void setup(void) {  
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