# Install pptp client
sudo apt-get install -y pptp-linux

# Configure the setting
sudo vim /etc/ppp/peers/pptpconf

# change the ip|name(username)|password
pty "pptp xxx.xxx.xxx.xxx --nolaunchpppd"
name xxx
password xxx
remotename PPTP
require-mppe-128
require-mschap-v2
refuse-eap
refuse-pap
refuse-chap
refuse-mschap
noauth
persist
maxfail 0
defaultroute
replacedefaultroute
usepeerdns

# Start and Stop the client
sudo pon pptpconf
poff pptpconf
