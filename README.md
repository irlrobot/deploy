#About 
deploy.rb sequentially runs commands on one or more hosts in the specified order.  You need SSH public key authentication already setup on the target hosts.  You can run a single command across multiple hosts by running deploy.rb from the command line with arguments, or you can feed deploy.rb a list of commands and hosts by using some helper files.  See the Usage section below for more information.

#Usage
Specify a command followed by multiple hosts to run that command on all the hosts.<br>
Example: ./deploy.rb uptime host1 host2 host3<br>
Example: ./deploy.rb "sudo yum update -y" host1 host2 host3

Otherwise deploy.rb expects hosts.txt and commands.txt in same directory to specify commands and hosts.

##hosts.txt
On each line put the username with access followed by a space and then the hostname.  You should have public key authentication already setup on the host for the user specified.  See the example hosts.txt in the repository.

##commands.txt
Each command should be on one line; commands are run sequentially, not in parrallel (by design).  See the example commands.txt in the repository.
