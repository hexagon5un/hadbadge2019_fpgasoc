#This is an example Makefile to build the audio demo example.

#The name of the app. The resulting file will be called APPNAME.elf.
APPNAME = synthtest

#Option 1 of indicating what files to compile: tell the SDK what directories contain
#source files. The SDK will then compile everything in these directories.
SRCDIRS = .

#Normally, you'd put the APSSDK_DIR in your environment. Here, we know where it is, so
#if people have not got it set, we assume the default relative directory to it.
APPSSDK_DIR ?= ../apps-sdk

BINFILES=test.raw

#Include the SDK makefile. It'll take care of the rest.
include $(APPSSDK_DIR)/sdk.mk

