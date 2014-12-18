eofe-scripts
============

Setup and Example scripts for R-based HPC at MIT

Introduction
---
This set of files facilitates the installation of Rmpi on the
engaging1 cluster, and provides example scripts to test simple
parallel computing tasks in R.
[Rmpi](http://www.stats.uwo.ca/faculty/yu/Rmpi/) is a package for R
that allows R processes on separate machines to cooperate on parallel computing tasks.

Initial setup
---
This readme file assumes you already have access to the engaging1
(or *eo* in short) cluster.  (Here is more information
[about the eo cluster](https://github.com/christophernhill/engaging1/blob/master/facility_notes).)
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

Installing Rmpi
---
To install Rmpi and other R packages for parallel computing, run

```
source setup.sh
```

You will be prompted with the following questions:

```
@ Do you need to download Rmpi?
[y/n]

@ Do you need to install Rmpi?
[y/n]

@ Do you need to install misc. HPC R packages?
[y/n]
```



