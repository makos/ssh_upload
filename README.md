# Directory scan and SSH upload tool

## Description
This Bash script naively checks for changes in a given directory and uploads new files to a remote server over SSH.
Warning: the uploaded files are removed after being succesfully uploaded.
If that behavior is unwanted, you can comment out lines 30 - 32 in the source file to disable that feature.

## Dependencies
`scp` (copy over SSH) is required.
Other than that, a working bash terminal.
Cron is recommended to schedule the script and make it run automatically.

## Configuration
The script **requires** a .db file in the directory you want to be monitored.
So, first do `touch .db` in the directory you want the script to be ran in.

Then, open up the source file and change the four variables HOST, PORT, ULDIR and LOCDIR to your needs.
* HOST - SSH server in format 'user@host'
* PORT - port number, even if default this needs to be specified
* ULDIR - directory on the remote server you want your files to be automatically
uploaded to
* LOCDIR - local directory to be monitored with trailing slash (ie. '~/files/', not '~/files')

And that's pretty much it.
