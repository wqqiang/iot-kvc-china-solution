# Install pptp service
sudo apt-get update
sudo apt-get install pptpd

# Edit the pptp.conf
option /etc/ppp/pptpd-option			    # specify the location of the PPP options file
debug                                       # enable the debug mode
localip 192.168.0.1                         # virtual ip of the VPN server
remoteip 192.168.0.200-238,192.168.0.245    # the virtual IP assigned to the VPN client

# Edit the pptpd-options
sudo vi /etc/ppp/pptpd-options

name pptpd              		            # pptpd service name
refuse-pap                      		    # refuse the pap authentication mode
refuse-chap                     		    # refuse the chap authentication mode
refuse-mschap                   		    # refuse the mschap authentication mode
require-mschap-v2               	        # allow mschap-v2 authentication mode
require-mppe-128                	        # allow mppe 128 authentication mode
ms-dns 8.8.8.8                  		    # use Google DNS
ms-dns 8.8.4.4                  		    # use Google DNS
proxyarp                        		    # arp proxy
debug                           		    # debug mode
dump                            		    # print out all configuration information when the service starts
lock                            		    # lock the TTY device
nobsdcomp                       		    # disabling BSD compression mode
logfile /var/log/pptpd.log     	            # log path

# Edit the chap-secrets
# username	service type	password	ip
test    		pptp    		1234    		*

# restart the service 
sudo service pptpd restart

#Set ipv4 forward
sudo sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
sudo sysctl -p

# Set iptables
sudo iptables -t nat -A POSTROUTING -s 192.168.0.0/24 -o eth0 -j MASQUERADE

# Set MTU
sudo iptables -I FORWARD -s 192.168.0.0/24 -p tcp --syn -i ppp+ -j TCPMSS --set-mss 1300

# View the VPN status
ps -aux | grep pptpd

# show like below:
r   oot        	2144  	0.0  0.0   4660  3064 	?        	Ss   	May27   0:00 /usr/sbin/pptpd --fg
ubuntu     	36248  	0.0  0.0   7004  2184 	pts/0    	S+   	02:11   	0:00 grep --color=auto pptpd
