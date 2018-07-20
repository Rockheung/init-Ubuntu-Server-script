# Initailizing Ubuntu Server Script for Cloud Server

Feature: Install vim-bootsrtap, pip3, virtualenvwrapper without any key input

This script is for Linode StackScript but can be used for general Ubuntu server. Should be excute by root.

Warning: You should set password by `passwd` and login with formal way at least one time. Using `su -s /bin/bash` or `su` command would not load `.profile` and not be able to excute initial hook for virtualenvwrapper because only `.profile` can add user's home `.local/bin` into excute path by default.