# testItem
测试用仓库,之后会多次删除
分支情况测试
测试git add
stage index暂存修改,多次之后提交到版本库
验证work tree
add之后,然后又修改了work tree的文件,是不会暂存的,也就是不会提交
git commit是检查索引去追踪文件变更,而不是工作目录
git diff是work tree的变更,--cached则是暂存的变更
测试分支是否拥有版本库还是和master公用一个版本库
