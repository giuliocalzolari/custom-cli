#!/usr/bin/python
 
import os
import time
import sys
import math

if len(sys.argv) < 2:
    sys.exit('Usage: %s host-list.txt' % sys.argv[0])

os.system("echo \"["+time.strftime("%Y/%m/%d")+" "+time.strftime("%H:%M:%S")+"] Start Bulk Boot\"> /opt/shell/bulk.log ")
cfg = open( sys.argv[1], "r" )
lines = cfg.read().split('\n')

count = int(math.floor( sum(1 for line in lines) / 5 ))
print count

for i in range(0, count ):
	 
	 x = i * 5
	 platform = lines[x].strip(" ")
	 user = lines[x + 1].strip(" ")
	 pswd = lines[x + 2].strip(" ")
	 name = lines[x + 3].strip(" ")
	 host = lines[x + 4].strip(" ")
	 
	 #print host
	 if platform == 'linux':
		if user != 'root':
			user = user + ' --sudo '
		
		if pswd.endswith('.pem'):
			auth = " --identity-file /opt/shell/key/"+pswd
		else:
			auth = " -P "+ pswd	
		 	
		
		cmd = "/usr/bin/knife   bootstrap "+host+" --node-name "+name+"  -r recipe[chef-cookbook-ohai]  --config /etc/chef/knife.rb  -x "+user+"  "+auth +"  >> /opt/shell/bulk.log 2>&1" 
		
	 else:
		cmd = "/usr/bin/knife   bootstrap windows winrm "+host+" --node-name "+name+"  -r recipe[chef-cookbook-ohai]  --config /etc/chef/knife.rb  -x "+user+" -P "+pswd +" >> /opt/shell/bulk.log 2>&1" 

	 #print cmd + "\n"
     os.system(cmd)

