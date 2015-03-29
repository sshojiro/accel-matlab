
# accel-matlab-cli

To accelarate your matlab project

## INSTALL

You first install git for your machine.
THis commands should be used with git.

```bash
$ cd # now at $HOME directory
$ mkdir bin
$ cd bin/
$ git clone https://github.com/sshojiro/accel-matlab.git
$ vim ~/.bashrc
export PATH="$PATH:$HOME/bin/accel-matlab"
```

## START PROJECT

```bash
$ accel new sample_project
sample_project/experiments is generated.
sample_project/tests is generated.
sample_project/scripts is generated.
sample_project/results is generated.
sample_project/docs is generated.
sample_project/, is generated.
sample_project/data is generated.
sample_project/slides is generated.
sample_project/libs is generated.
```

## USAGE

```bash
$ accel
### ACCEL CLI ###
USAGE:
        run `accel new APP_NAME` to start new project
        run `accel g exp`:
!!! say sth as arguments !!!
        The syntax is...
                g lib DIRECTORY_NAME
                g script SCRIPT_NAME
                g exp EXPERIMENT_NAME
                g exp EXPERIMENT_TYPE/EXPERIMENT_NAME
                g model MODEL_NAME
```
