# wl
Bash shell script to write stdout and stderr of following command to a log file. Usage:

```
wl <logfile name, preferrably without tailing .log extention> <command to be executed>
```

Script rotates exiting `<logfile>` with adding timestamp to its name. Everything after `<logfile>` is executed. Script piping stdout and stderr to the file with tee command. Temp exec file is created and executed in `$TEMP` folder. After successfull execution it is supposed to be deleted.
  
To the head of the `<logfile>` script adds timestamp of execution and the exact command to be executed. Alias related hacks are needed to workaround Bash limitation on aliases visibility in scripts.
