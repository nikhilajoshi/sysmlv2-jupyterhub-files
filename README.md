# What is it

This repo is an update editing files from pupster90/io_Hub_Setup to use helm 3.5 and jupyterhub version 1.1.0
It also changes the config.yaml to allow user to load different docker images for their notebook server - essentially adding the last option to launch a jupyter lab that includes SysMLv2 libraries from the SysMLv2 prototype release (April 2022).

To get instructions on how to install this on Google cloud kubernetes cluster, please view:
https://youtu.be/Mk6ZHVlw0Xs
You can essentially clone this repo instead of pupster90/io_Hub_Setup to achieve the result

The included Dockerfile is the one modified from gorenje/sysmlv2-jupyter-docker to allow launching in jupyterhub
the resulting docker image is hosted at hub.docker.com/najoshi/sysmlv2-jh:v4

.....
notes below are the original Readme instructions from pupster90
.....


# How to Finish Setting Up Jupyter

**PLEASE NOTE:** This file isn't done yet. (Taking a break after video) But if it's still not done by Christmas 2018, then yell at me in the youtube comments or on github and I'll get back to it! Also If you know how to get the usernames working let me know! :)

This readme explains how to finish setting up JupyterHub from my youtube tutorial. There are **2** important things that still need to be done:
1. Only allow specific users
2. Make JupyterHub work for *https*

Previously I have accomplished the first task so I will explain how to setup the usernames and sometime soone I will update the files in the repo. As for step 2, if someone else knows how this is done, please let me know!

# Setting Users:

**Basic Idea:** (will add this soon)






