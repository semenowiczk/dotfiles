UseKeychain yes

# Keep the connection indefinitely for all jump boxes
#Host bastion
Host 10.2??.*.*
  ControlPersist yes
  User centos

Host jump*
  ProxyCommand none
####  ForwardAgent yes
####  StrictHostKeyChecking no
####  UserKnownHostsFile /dev/null
  LogLevel ERROR

Host 10.22?.*.*
  ProxyCommand ssh -q -W %h:%p -l ksemenowicz jump.ams.syseng.tmcs
  User tmweb
####  StrictHostKeyChecking   no
####  UserKnownHostsFile /dev/null
  LogLevel ERROR

Host fls1.sys.ams0.websys.tmcs
  KexAlgorithms diffie-hellman-group1-sha1
  Cipher 3des-cbc

Host *.tmcs 10.78.*.*
PubkeyAcceptedKeyTypes=+ssh-dss
User sre
AddKeysToAgent yes
UseKeychain yes
  ProxyCommand ssh -q -W %h:%p -l ksemenowicz jump.ams.syseng.tmcs

#### AddKeysToAgent yes
####UserKnownHostsFile=/dev/null
####StrictHostKeyChecking no
####ForwardAgent yes
ForwardX11 yes
ForwardX11Trusted yes
