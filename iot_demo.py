#!/usr/bin/python

import sys
import ssl
from AWSIoTPythonSDK.MQTTLib import AWSIoTMQTTClient
import json
import time

#Setup our MQTT client and security certificates
#Make sure your certificate names match what you downloaded from AWS IoT

mqttc = AWSIoTMQTTClient("1234")

#Use the endpoint from the settings page in the IoT console
mqttc.configureEndpoint("<PASTE YOUR ENDPOINT HERE>.amazonaws.com",8883)
mqttc.configureCredentials("./rootCA.pem","./privateKey.pem","./certificate.pem")

#Function to encode a payload into JSON
def json_encode(string):
        return json.dumps(string)

mqttc.json_encode=json_encode

#Declaring our variables
message ={
  'val1': "Value 1",
  'val2': "Value 2",
  'val3': "Value 3",
  'message': "Test Message"
}

#Encoding into JSON
message = mqttc.json_encode(message)

#This sends our test message to the iot topic
def send():
    mqttc.publish("iot", message, 0)
    print("Message Published")


#Connect to the gateway
mqttc.connect()
print("Connected")

#Loop until terminated
while True:
    send()
    time.sleep(5)

mqttc.disconnect()

