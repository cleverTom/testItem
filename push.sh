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

    #push 分支去远程仓库;
    git push origin daily/${version};
    if [ $? -eq 0 ]
    then
        echo -e "\033[32m 分支daily/${version}push==>远程仓库成功 \033[0m";
    else
        echo -e "\033[31m 分支daily/${version}push==>远程仓库失败 \033[0m";
        exit;
    fi
    git checkout
}

pushCDN