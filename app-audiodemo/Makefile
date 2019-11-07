#This is an example Makefile to build the audio demo example.
all: flash

#The name of the app. The resulting file will be called APPNAME.elf.
APPNAME = audiodemo

#Option 1 of indicating what files to compile: tell the SDK what directories contain
#source files. The SDK will then compile everything in these directories.
SRCDIRS = . subdir

#Normally, you'd put the APSSDK_DIR in your environment. Here, we know where it is, so
#if people have not got it set, we assume the default relative directory to it.
APPSSDK_DIR ?= ../apps-sdk

#Include the SDK makefile. It'll take care of the rest.
include $(APPSSDK_DIR)/sdk.mk

flash: $(APPNAME).elf
	sudo mount -o user,umask=000,utf8 /dev/sdc1 /tmp/badgemount
	cp $(APPNAME).elf /tmp/badgemount 
	sync
	sudo umount /tmp/badgemount
	-echo DONE
