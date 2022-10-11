#!/usr/bin/env bash
## written in 10/6/2022 by NewSL
## 该脚本用于编译并运行java文件
javac $1 2>&1
wrongMsg=$(javac $1 2>&1)	#保存错误信息
if [[ -n $wrongMsg ]]	#	判断是否有错误信息生成
then	#编译java文件，生成所有.class文件
	echo "有错误，无法执行" 
	exit
fi

num=$(egrep -c 'class\ +(.*)[{$]' $1) #共有几个.class文件
echo "共有${num}个类"
if [[ $num == '1'  ]]; then
	classOnly=$(egrep '.*class\ +(.*)[{\n]' var01.java \
		| sed -r 's/.*class\ +(.*)[{\n]/\1/g')	#将唯一的类名提取出来
	echo $classOnly" :"
	java $classOnly	#运行唯一的一个类	
	exit
fi
egrep 'class\ +(.*)[{$]' $1 | sed -r 's/.*class\ +(.*)[{$]/\1/' |\
   awk ' {print NR" "$0}'	#列出所有的class
read -p "请输入所要运行的程序序号：" no #输入程序序号
egrep 'class\ +(.*)[{$]' $1 | sed -r 's/.*class\ +(.*)[{$]/\1/' |\
	awk 'NR == ""'$no'"" || "0"==""'$no'"" || "A"==""'$no'""\
	{cmd="java" ;print $0" :";system(cmd " "$0);}' #执行该程序	
#echo "no:${no}"	
#echo $[[ $no == "*" ]]
