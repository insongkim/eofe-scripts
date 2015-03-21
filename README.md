# eofe-scripts
Setup and Example scripts for R-based HPC at MIT

## Introduction
This set of files facilitates the installation of Rmpi on the
engaging1 cluster, and provides example scripts to test simple
parallel computing tasks in R.
[Rmpi](http://www.stats.uwo.ca/faculty/yu/Rmpi/) is a package for R
that allows R processes on separate machines to cooperate on parallel
computing tasks.  The scripts were last tested on December 18, 2014.

## Initial setup
This readme file assumes you already have access to the engaging1
(or *eo* in short) cluster.  Here is more information
[about the eo cluster](https://github.com/christophernhill/engaging1/blob/master/facility_notes).
Once you have logged into the cluster, you can create a copy of this
git repository by cloning it.  Run the following command at the shell
prompt

```
git clone https://github.com/insongkim/eofe-scripts.git
```
which will create a subdirectory named *eofe-scripts*.  Then, navigate
into the repository directory:

```
cd eofe-scripts
```

##Installing Rmpi
To install Rmpi and other R packages for parallel computing, run the
following from the command line:

```
source setup.sh
```

You will be prompted with the following questions:

```
@ Do you need to update and add modules to .bashrc? (Select Yes for
first time users)
[y/n]

@ Do you need to download Rmpi?
[y/n]

@ Do you need to install Rmpi?
[y/n]

@ Do you need to install misc. HPC R packages?
[y/n]
```

Answer "y" to each of these questions if this is your first time
running the script.

##Examples
Jobs on the cluster are managed through
[SLURM](http://en.wikipedia.org/wiki/Simple_Linux_Utility_for_Resource_Management).
With the exception of extremely simple tasks, all jobs should be
submitted through SLURM.

*test_ex2.sh* in the examples folder provides a template for a SLURM
 script. To run the script, `cd` to the examples folder, and call
 `sbatch`:

```
cd examples
sbatch test_ex2.sh
```

Among other things, the script specifies the
queue, number of nodes and cores, and time requested for the job to
run.  If the job takes longer to run than the amount of time
requested, it will be terminated before it completes.  However,
jobs that request for less time will move more quickly in the queue.  [More information about SLURM commands](https://rc.fas.harvard.edu/resources/documentation/convenient-slurm-commands/)
is available at this link.

The script executes `mpirun` and tells `mpirun` to launch one instance of R
and run *example2.R*. The R script generates 10 100k-by-10 dataframes,
and runs `lm` on these dataframes in parallel.

To check the status of your job, run

```
squeue -u  your_user_name
```

After the job is completed, you can view the output by running

```
more example2.Rout
```

##Acknowledgements
Parts of this readme and *setup.sh* were adapted from [Jonathan
Olmsted's setup scripts for R-based HPC at Princeton University](https://github.com/olmjo/tigress-scripts).
Greg Shomo (Engaging1 Admin) provided invaluable assistance with Rmpi setup.
