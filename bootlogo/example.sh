#!/bin/bash

mkdir bootlogo.dir
cd bootlogo.dir
cpio -i < ../bootlogo
ls | cpio -ov > ../bootlogo.new
