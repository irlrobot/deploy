#!/usr/bin/env ruby
#
# Josh Campbell
# https://github.com/irlrobot/
#
# This is v1.0
#
# deploy.rb sequentially runs commands on one or more hosts in the specified order.
#
# Specify a command followed by multiple hosts to run that command on all the hosts.
# Example: ./deploy.rb uptime host1 host2 host3
# Example: ./deploy.rb "sudo yum update -y" host1 host2 host3
#
# Otherwise deploy.rb expects hosts.txt and commands.txt in same directory to specify commands and hosts.
#
# hosts.txt
# On each line put the username with access followed by a space and then the hostname.
# You should have public key authentication already setup on the host for the user specified,
# For example "josh splunk01.domain"
#
# commands.txt
# Each command should be on one line, Commands are run sequentially not in parrallel (by design).
# For example "sudo yum update -y"
#

require 'rubygems'
require 'net/ssh'

def ssh_exec(hostname, username, command)
  ssh = Net::SSH.start(hostname, username)
  ssh.open_channel do |channel|
      channel.request_pty do |c, success|
        if success
          c.exec(command)
          c.on_data do |ch, data|
            puts data
          end
        else
          puts "Failed to connect!"
        end
      end
    end
  ssh.close()
end

if ARGV.size > 0
  current_user = ENV['USER']
  command = ARGV[0]
  hosts = ARGV[1..ARGV.size]
  
  hosts.each do |host|
    puts "--------------------------------------------------"
    puts "--------------------------------------------------"
    puts "Deploying to #{host}"
    puts "--------------------------------------------------"
    begin
      ssh_exec(host, current_user, command)
      raise
    rescue
      puts "Can't connect to #{host}"
    end
  end
else
  File.open("hosts.txt").each_line do |host|
    username = host.split[0]
    hostname = host.split[1]
    puts "--------------------------------------------------"
    puts "--------------------------------------------------"
    puts "Deploying to #{hostname}"

    File.open("commands.txt").each_line do |command|
      puts "--------------------------------------------------"
      puts command  
      puts "--------------------------------------------------"
      begin
        ssh_exec(hostname, username, command)
        raise
      rescue
        puts "Can't connect to #{host}"
      end
    end 
  end
end
