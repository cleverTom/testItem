#!/bin/bash
dir=`pwd`;
remote_name=${dir##*/};
files="$dir/build/*";

for file in ${files}
do
    echo "//g.alicdn.com/tvtaobao-assets/${remote_name}/${version}/${file##*/}";
done


