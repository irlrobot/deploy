#!/usr/bin/env ruby
#
# Josh Campbell
# https://github.com/irlrobot/dothisonthat
#
# This is v2.1
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
    puts "Connecting to #{host}"
    puts "--------------------------------------------------"
    begin
      puts "Running '#{command}'"
      puts "--------------------------------------------------"
      ssh_exec(host, current_user, command)
    rescue
      puts "Can't connect to #{host}. Check host or credentials."
    end
  end
else
  File.open("hosts.txt").each_line do |host|
    username = host.split[0]
    hostname = host.split[1]
    puts "--------------------------------------------------"
    puts "--------------------------------------------------"
    puts "Connecting to #{hostname}"
    puts "--------------------------------------------------"

    commands = ""
    File.open("commands.txt").each_line do |command|
      if commands == ""
        commands = commands + command.chomp
      else
        commands = commands + " && #{command.chomp}"
      end
    end  
    
    begin
      puts "Running '#{commands}'"
      puts "--------------------------------------------------"
      ssh_exec(hostname, username, commands)
    rescue
      puts "Can't connect to #{host.split[1]}. Check host or credentials."
    end
  end
end
