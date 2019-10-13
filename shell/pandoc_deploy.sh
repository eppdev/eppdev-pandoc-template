#!/bin/sh

# #####################################################
# 
# 本脚本是针对eppdev-pandoc-template实现自动将markdown文件
# 生成pdf文件的处理脚本，可以配合gitlab-ci/jenkins等自动化
# 构建工具使用，其中配置参数和输入项包括：
#     1. 配置项target_path：所有生成pdf文件的根目录
#     2. 输入参数：仅一个，针对某一个工程的子目录地址
# 上述配置项和参数配合决定文件最终生成位置
#
# 文件版权所有：郝金隆（jinlong.hao@eppdev.cn), 2019
# 许可：ANTI-996 License V1.0
#
# 整体处理流程：
#     1. 遍历本目录，获取所有的markdown文件
#     2. 在本目录的output目录和目标目录下创建同样的目录结构
#     3. 获取当前时间戳，用于保存历史
#     4. 依次对比已生成的pdf文件生成时间和markdown文件的最后
#        修改时间，若有修改或未生成pdf文件，则生成pdf文件
#
# 环境依赖，对于要执行本脚本的环境，满足以下依赖条件：
#     1. pandoc: 2.0以上
#     2. texlive: 建议2017以上版本
#     3. 安装eppdev-pandoc-template模板
#     4. 安装template定义的字体（默认是msyh,msyhbd）
#
# #####################################################

# --------------------------------
# 0. 目录定义
# --------------------------------

# 此处需要修改为目录地址
target_path=/srv/doc/

# 输出的子目录地址
target_folder_name=$1


# -----------------------------------------------
# 1. 遍历本目录，获取所以的md文件
#    获取当前目录
# -----------------------------------------------
echo '任务01：获取所有的markdown文件及当前目录【开始】'

file_list=`find ./ | grep \\.md$`
cur_path=`pwd`

# 错误判断
if [[ $? -ne 0 ]]; then
	echo '任务01：获取所有的markdown文件及当前目录【失败】'
	exit 1
else
	echo '任务01：获取所有的markdown文件及当前目录【成功】'
fi

# -----------------------------------------------
# 2. 遍历所有文件，在本目录和目标目录下创建目录
# -----------------------------------------------
echo '任务02：创建目标目录结构【开始】'
for file in $file_list
do
	# 获取相对目录结构
	file_path=${file%/*}
	
	# 创建本工程内的目录
	mkdir -pv output/$file_path
        mkdir -pv $target_path/$target_folder_name/$file_path
        mkdir -pv $target_path/$target_folder_name/_his/$file_path
done

# 错误判断
if [[ $? -ne 0 ]]; then
	echo '任务02: 创建目标目录结构【失败】'
	exit 1
else 
	echo '任务02: 创建目标目录结构【成功】'
fi

# -----------------------------------------------
# 3. 获取当前的时间戳
# -----------------------------------------------
echo '任务03：获取当前时间戳【开始】'
datetime_str=`date +'%Y%m%d_%H%M%S'`
date_str=`date +'%Y%m%d'`

# 错误判断
if [[ $? -ne 0 ]]; then
	echo '任务03: 获取当前时间戳【失败】'
	exit 1
else 
	echo '任务03: 获取当前时间戳【成功】'
fi


# -----------------------------------------------
# 4. 依次判断md和pdf文件的修改时间，有更新则重新生成pdf文件
#    
# 注意：git时间需要通过git log获取，避免gitlab-ci更新修改时间
# -----------------------------------------------
echo '任务04：生成pdf文件【开始】'
for file in $file_list
do
	# 获取文件名
	file_name=${file%.*}
	file_path=${file%/*}
	target_pdf_file=$target_path/$target_folder_name/${file_name}.pdf
	target_pdf_his_file=$target_path/$target_folder_name/_his/${file_name}_${date_str}.pdf


	# 获取md文件修改时间戳
	md_dt_str=`git log --date=raw ${file} | grep Date | head -1`
	md_dt=`echo $md_dt_str | awk -F ' ' '{print $2}'`


	# 切换目录
	cd $file_path

	if [ ! -f "$target_pdf_file" ]; then
		echo "任务04：生成pdf文件，创建$target_pdf_file"
		pandoc --pdf-engine=xelatex --template=eppdev-doc --listings $cur_path/${file} -o ${target_pdf_file}
		cp ${target_pdf_file} ${target_pdf_his_file}
	else
		# 获取pdf的时间戳
		pdf_dt=`date +%s -r ${target_pdf_file}`

		if [ $md_dt -gt $pdf_dt ]; then 
			echo "任务04：生成pdf文件，创建$target_pdf_file"
			pandoc --pdf-engine=xelatex --template=eppdev-doc --listings $cur_path/${file} -o ${target_pdf_file}
			cp ${target_pdf_file} ${target_pdf_his_file}
		fi
	fi

	# 回到根目录
	cd $cur_path
done


# 错误判断
if [[ $? -ne 0 ]]; then
	echo '任务04: 生成pdf文件【失败】'
	exit 1
else 
	echo '任务04: 生成pdf文件【成功】'
fi


