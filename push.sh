#!/bin/bash

function pushCDN()
{
    git tag;
    while :
    do
    printf "请输入版本号version(比如:1.0.0): ";
    read version;
    if [ ${#version} != 0 ] 
    then
        git checkout -b daily/${version}
        if [ $? -ne 0 ]
        then
            echo -e "\033[31m 创建分支失败,分支已经存在 \033[0m";
            exit;
        else
            echo -e "\033[32m 成功创建日常分支daily/${version} \033[0m";
            break;
        fi
        
    else
        echo -e "\033[31m 输入不能为空,请重新输入version \033[0m";
    fi
    done;

     #推送到本地版本库
    printf "请输入本次上传版本的描述(尽量不为空): ";
    read description;
    git add .;
    git commit -m "${description}";
    if [ $? -ne 0 ]
    then
        echo -e "\033[31m 推送到本地版本库失败 \033[0m";
        exit;
    else
        echo -e "\033[32m 成功上传==>本地仓库 \033[0m";
        echo -e "\033[33m 正在上传分支daily/${version}==>远程仓库 \033[0m";
    fi

    #push分支去远程仓库;
    git push origin daily/${version};
    if [ $? -eq 0 ]
    then
        echo -e "\033[32m 分支daily/${version}push==>远程仓库成功 \033[0m";
    else
        echo -e "\033[31m 分支daily/${version}push==>远程仓库失败 \033[0m";
        exit;
    fi

    #切换到主分支
    git checkout master;
    if [ $? -eq 0 ]
    then
        echo -e "\033[32m 切换到主分支 \033[0m";
    else
         echo -e "\033[31m 切换到主分支失败 \033[0m";
         exit;
    fi

    #从远程仓库拉取
    git pull;
    if [ $? -eq 0 ]
    then
         echo -e "\033[32m 远程仓库pull成功 \033[0m";
        git merge daily/${version};
        if [ $? -eq 0 ]
        then
            echo -e "\033[32m 合并分支成功 \033[0m";
        else
            echo -e "\033[31m 合并分支daily/${version}失败 \033[0m";
            exit;
        fi
    else
        echo -e "\033[31m pull线上版本失败 \033[0m";
        exit;
    fi
    
    #推送主分支
    git push origin master;
    if [ $? -eq 0 ]
    then
        echo -e "\033[32m push主分支成功 \033[0m";
    else
        echo -e "\033[31m push主分支失败 \033[0m";
    fi

    #打publish的tag
    git tag publish/${version};
    if [ $? -eq 0 ]
    then
        echo "\033[32m tag成功 \033[0m"
    else
        echo -e "\033[31m 当前tag已经存在 \033[0m"
    fi

    #发布正式版本
    git push origin publish/${version};
    if [ $? -eq 0 ]
    then
        echo "发布线上版本成功,生成CDN网址是: ";
    else
        echo -e "\033[31m 发布CDN线上版本失败 \033[0m"
    fi
    #生成上传文件的地址
    dir=`pwd`;
    remote_name=${dir##*/};
    files="$dir/build/*";
    for file in ${files}
    do
    echo "//g.alicdn.com/tvtaobao-assets/${remote_name}/${version}/${file##*/}";
    done
    
}

pushCDN