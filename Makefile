# -*- mode: Makefile; fill-column: 80; comment-column: 75; -*-
VAGRANT_BASEBOX_URL=http://3e04d893195703aea1e0-06bcca11dd89a6ee495a745305fe9588.r36.cf1.rackcdn.com/lxc-raring-amd64-2013-04-21.box
VAGRANT_BASEBOX_NAME=Ubuntu13.04

.PHONY: add_box up down destroy

add_box:
	vagrant box add $(VAGRANT_BASEBOX_NAME) $(VAGRANT_BASEBOX_URL)

up:
	vagrant up

down:
	vagrant halt

destroy:
	vagrant destroy
