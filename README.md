#About 
dothisonthat.rb sequentially runs plain shell commands on one or more hosts in the specified order.  You need SSH public key authentication already setup on the target hosts.  You can run a single command across multiple hosts by running dothisonthat.rb from the command line with arguments, or you can feed dothisonthat.rb a list of commands and hosts by using some helper files.  See the Usage section below for more information.

#Usage
./dothisonthat.rb --help<p>

Specify commands followed by multiple hosts to run commands, sequentially, on all hosts in specified order.<br>
Example: ./dothisonthat.rb -c uptime,w,"ls -lah /" -w host1,host2,host3<br>
Example: ./dothisonthat.rb -c "sudo yum update -y" -w host1,host2<br>

Use do_this and on_that files<br>
Example: ./dothisonthat.rb -d do_this.txt -o on_that.txt<br>

##do_this.txt
Each command should be on one line; commands are run sequentially, not in parrallel (by design).  See the example do_this.txt.example in the repository.

##on_that.txt
On each line put the username with access followed by a space and then the hostname.  You should have public key authentication already setup on the host for the user specified.  See the example on_that.txt.example in the repository.
