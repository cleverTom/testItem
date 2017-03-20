#!/bin/sh

root="$HOME";

if [ -d "$root/.tmhr" ]
then
    echo "文件夹存在";
else
    echo "文件夹不存在";
fi