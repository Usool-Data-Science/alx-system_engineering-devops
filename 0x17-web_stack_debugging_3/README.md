This is the debugging task 3, we applied tmux, strace and puppet.
tmux: used for screen splitting and session management.
strace: to start a process and then curl that process from another terminal.
puppet: is used to make auto implementation of the error's correction.

How it is done:
1. First install puppet-lint and ruby:
$ apt-get install -y ruby
$ gem install puppet-lint -v 2.1.1

2. Install tmux:
sudo apt-get update
sudo apt-get install tmux

3. Split the screen using tmux.
On one screen check for process that are running apache
$ ps aux | grep apache

4. Run the process on another screen
$ sudo strace -p <PID e.g 670>

5. Wait for the process to run and see if its waiting for a command, then move back to previous window and curl twice to see if you get error message on both calls for each window respectively.
$ curl -sI 127.0.0.1

6. Inspect the error for a specific message like no such file or directory.

7. Close the tmux sessions and use grep to trace the file that is causing the error
$ tmux kill-session

8. Find which file is causing the "phpp" error and the specific line of that error.
$ grep -ro "phpp" /var/www/html
$ grep -n "phpp" <#SPECIFIC FILE WITH ERROR>

9. Go and check that line visually to know how to use sed to change it.

10. Setup the puppet file for the correction.


