# About 
Do This On That (dtot) sequentially runs plain shell commands on one or more hosts in the specified order. You need SSH public key authentication already setup on the target hosts. You can run a single command across multiple hosts by running dtot from the command line with arguments, or you can feed dtot a list of commands and hosts by using some helper files.  See the Usage section below for more information.

# Usage
```gem install dtot```
<br>
```dtot --help```

Specify commands followed by multiple hosts to run commands, sequentially, on all hosts in specified order.  Uses the currently logged in, local user as the username on the target systems.

```dtot -c uptime,w,"ls -lah /" -w host1,host2,host3```<br>
```dtot -c "sudo yum update -y" -w host1,host2```

Or, use "do this" and "on that" files:<br>
```dtot -d do_this -o on_that```

## do_this
Each command should be on one line; commands are run sequentially, not in parrallel (by design).  See the example do_this in the examples directory of this repository.

## on_that
On each line put the username with access followed by a space and then the hostname.  You should have public key authentication already setup on the host for the user specified.  See the example on_that in the examples directory of this repository.

# Docker
First, retrieve the image from Docker Hub:
```
docker pull irlrobot/dtot
```

Next, create your do_this and on_that files in a directory on your local machine. I typically just use ~/Desktop on my Mac. 

Finally, run the below from the directory where your do_this and on_that files are located:
```
docker run --rm \
    -v ~/.ssh/id_rsa:/root/.ssh/id_rsa \
    -v ~/.ssh/id_rsa.pub:/root/.ssh/id_rsa.pub \
    -v ~/Desktop/do_this:/dtot/commands \
    -v ~/Desktop/on_that:/dtot/hosts \
    dtot
```
