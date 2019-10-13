---
title: EPPDEV-PANDOC-TEMPLATE使用指南
version: V1.3
author: 郝金隆
date: 2019-09
file-code: EPPDEV-PANDOC-TEMPLATE-USAGE
header-right: 2019-09
logo: true
history:
  - version: V1.0
    author: 郝金隆
    date: 2019-09-25
    desc:
      - 1. 创建文档
      - 2. 完成第一版的文档说明
  - version: V1.1
    author: 郝金隆
    date: 2019-09-26
    desc: 增加了修订目录相关内容
  - version: V1.2
    author: 郝金隆
    date: 2019-09-28
    desc: 
      - 1.修改一级目录引导线的格式,增加点间距
      - 2.修改修订目录的格式，去掉内容空行，标题粗体
  - version: V1.3
    author: 郝金隆
    date: 2019-10-13
    desc:
      - 1.增加了与DevOps的自动化处理脚本
      - 2.增加了与DevOps集成的环境配置说明
...


# 工程说明 

本工程是个人根据实际需要参考相关网络文档，整理的通过pandoc转换为pdf的模板，
用于实现内部IT项目管理文档格式的标准化工作。


# 基础环境配置

markdown生成pdf主要需要使用Pandoc和Latex(texlive/miktex)两个工具，具体安装方式如下：

## Pandoc的安装

Pandoc是由John MacFarlane开发的标记语言转换工具，可实现不同标记语言间的格式转换，
堪称该领域中的“瑞士军刀”。Pandoc使用Haskell语言编写，以命令行形式实现与用户的交互，
可支持多种操作系统。

* Window下的安装：下载[安装包](https://github.com/jgm/pandoc/releases)直接安装即可
* Linux/FreeBSD下的安装：Pandoc已经包含在大部分Linux发行版的官方仓库中，
  直接使用诸如apt/dnf/yum/pacman之类的安装工具直接安装即可
* MacOS下的安装：建议通过HomeBrew进行安装即可

> 详细的安装说明参见：[官方安装文档](https://pandoc.org/installing.html)

## Latex的安装

latex工具，在windows下建议安装miktex，Linux和MacOS下建议安装texlive

* Windows下的安装：下载安装[miktex](https://miktex.org/download)，
  注意安装后需要再安装cjk,cjk-fonts等相关package
* Linux/FreeBSD下的安装：使用apt/dnf/yum/pacman/pkg等安装工具安装
  texlive、texlive-latex等相关软件包即
* MacOS下的安装：使用HomeBrew安装texlive即可


# 安装后的设置

## 配置Pandoc模板

为保证生成的pdf格式（自动插入封面、目录页、页眉页脚等信息），在本地环境中安装模板，具体步骤是：

* 下载[eppdev-pandoc-template模板](https://github.com/eppdev/eppdev-pandoc-template/releases)
  将其保存到本地
* 根据需要对模板进行相应的定制，具体定制方式参见下节
* 将修改后的模板文件复制到指定目录下[^filename]
  * Window下：C:/Users/USERNAME/AppDatax/Roaming/pandoc/templates
  * Linux/FreeBSD/MacOS：~/.pandoc/templates/

[^filename]: 如有不同需要，可以定制不同的模板，作不同的命名，复制到对应目录下

## 模板的定制

模板定制主要修改模板最前面的"〇、模板基础配置"相关内容，主要可修改的包括：

1. 公司和组织，目前默认是"EPPDEV.CN"
2. 正文缩进，目前默认是2em（2个中文字符，4个英文字符)
3. 主要中文字体和英文字体：目前都是微软雅黑
4. 页眉、页脚展示内容，目前是：
   1. 左页眉：title
   2. 右页眉："企业机密，请勿外传"
   3. 作页脚：company
   4. 右页脚：页码

> eisvogel模板原来右页眉默认是date，如需恢复为data，
  只需要将"EPPDEV.CN"改为&#36;date&#36;即可


现有内容如下：

~~~latex

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% 〇、模板基础配置
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 公司和组织
\newcommand*{\company}{$if(company)$$company$$else$EPPDEV.CN$endif$}

% 缩进
\newcommand*{\udfparindent}{2em}

% 主要中文字体
\newcommand*{\thecjkmainfont}{$if(CJKmainfont)$$CJKmainfont$$else$Microsoft YaHei$endif$}

% 主要英文字体
\newcommand*{\themainfont}{$if(mainfont)$$mainfont$$else$Microsoft YaHei$endif$}

% logo
\newcommand*{\thelogo}{$if(logo-url)$$logo-url$$else$logo.png$endif$}

% 页眉-左
\newcommand*{\headerleft}{$if(header-left)$$header-left$$else$$title$$endif$}

% 页眉-右
\newcommand*{\headerright}{$if(header-right)$$header-right$$else$企业机密，请勿外传$endif$}

% 页脚-左
\newcommand*{\footerleft}{$if(footer-left)$$footer-left$$else$\company$endif$}

% 页脚-右
\newcommand*{\footerright}{\thepage}

~~~


## 字体设置

目前页面默认的字体是微软雅黑，对于非Windows系统，可能不存在该字体，则有以下两种解决方案：

1. 手工安装微软雅黑字体（需要msyh,msyhbd两个文件）
2. 修改为其他字体，如苹方、文泉驿等

若需要多个团队共同使用，建议采用方案一。


# pdf文件的生成

## PDF文件指定metadata信息

在每个markdown最前面增加以下主要metadata信息，metadata内容开始行内容为三个“-”，结束行为三个“.”，示例如下：

~~~yml
title: EPPDEV-PANDOC-TEMPLATE使用指南
version: 1.0
author: 郝金隆
date: 2019-09
file-code: EPPDEV-PANDOC-TEMPLATE-USAGE
history:
  - version: V1.0
    author: 郝金隆
    date: 2019-09-25
    desc:
      - 1. 创建文档
      - 2. 完成第一版的文档说明
  - version: V1.1
    author: 郝金隆
    date: 2019-09-26
    desc: 增加了修订目录相关内容
~~~

其他可选配置项目如下：

1. subtitle: 副标题
2. header-left: 左页眉
3. header-right: 右页眉
4. footer-left: 左页脚
5. footer-right: 右页脚
6. company: 公司名称
7. CJKmainfont: 主要中文字体
8. mainfont: 主要字体
9. lot: 是否创建表格目录
10. lof: 是否创建图片目录
11. logo: 是否在封面显示logo（需要在markdown相同文件夹下有logo.png文件）

> 可选配置项中，建议除了subtitle外，全部在模板中定制，不在markdown文件中定制

## Markdown其他编写要求

pandoc默认使用的[pandoc_markdown](https://pandoc.org/MANUAL.html#pandocs-markdown)格式，
为避免markdown转pdf格式异常，在编写markdown的时候有几个原则要求：

* 每个标题前后都必须有空行
* 每个表格前后都必须有空行
* 每个代码块前后收必须有空行
* 每个列表前后必须有空行

> 总而言之，每个不同的格式和内容前后都需要有空行，详细内容参见
> [pandoc官方文档](https://pandoc.org/MANUAL.html#pandocs-markdown)


## 文件生成

配置完成后即可在通过pandoc命令生成pdf文件：

~~~shell
pandoc --listings --pdf-engine=xelatex --template eppdev-doc a.md -o a.pdf
~~~

> 若定制的模板修改了文件名，需要将命令中的eppdev-doc修改为修改后的文件名


# 与DevOps集成

本pandoc模板可以很容易的与gitlib-ci等devops工具相集成，实现pdf文件的自动生成，
这样就无需每个人都安装一套pandoc, texlive等环境，下文以gitlab为例，说明如何
与DevOps进行集成

## 发布与编译环境准备

首先需要再DevOps的执行节点进行环境配置[^executor]，要配置的环境包括：

[^executor]: 是指具体进行编译执行的环境，如gitlab-ci中的gitlab-runner所在的服务器

### 安装Pandoc

安装方式可参考上文，注意很多服务器操作系统(如CentOS)官方库的pandoc还是1.x版本，
使用该版本将不支持修订目录功能，建议手工安装最新的pandoc，具体可以通过官网下载
最新版本，解压缩以后，设置PATH环境变量即可

### 安装TexLive

安装方式同样可以参考上文，但是服务器操作系统版本一般相对比较第，建议手工安装最新
版本，可以从国内镜像如[华为](https://mirrors.huaweicloud.com/CTAN/systems/texlive/Images/)、
[清华](https://mirrors.tuna.tsinghua.edu.cn/CTAN/systems/texlive/Images/)等站点下载
最新的iso文件，当前最新为2019。具体安装命令如下：

~~~shell
wget https://mirrors.tuna.tsinghua.edu.cn/CTAN/systems/texlive/Images/texlive2019.iso
sudo mount ./texlive2019.iso /mnt
cd /mnt
sudo ./install_tl
~~~

安装完成后，需要将修改环境变量，将最新的texlive目录下的bin目录添加到环境变量中

### 安装template文件

根据需要，将eppdev_doc.latex文件复制到进行编译执行的服务器用户主目录(如gitlab-ci对应的
/home/gitlab-runner）下的.pandoc/templates目录下

### 安装字体

具体需安装的字体根据eppdev_doc.latex中的配置为准，本文以微软雅黑为例。将msyh.ttf,
msyhbd.ttf两个文件上传到服务器上，然后进行安装：

~~~shell
sudo mkdir /usr/share/fonts/chinese
sudo cp msyh*.ttf /usr/share/fonts/chinese
cd /usr/share/fonts/chinese
sudo mkfontsdir
sudo mkfontscale
~~~

### 配置目标目录

创建一个要发布的目标文档目录，提供编译执行者可读写的权限，以gitlab为例：

~~~shell
sudo  mkdir  /srv/doc
sudo chown gitlab-runner /srv/doc
~~~

> 配置好目录以后后续即可通过nginx/httpd的文件列表功能，或者通过rsync同步
> 到对应的文件管理服务器中，本文对此就不再赘述

### 安装pandoc_deploy.sh

将工程下载的pandoc_deploy.sh文件进行修改，将target_dir修改为上文创建的目标目录。
然后将其复制到/usr/bin目录下，并为其添加可执行权限

~~~shell
chmod a+x pandoc_deploy.sh
sudo cp pandoc_deploy.sh /usr/bin/
~~~

## DevOps的配置

### 主要配置方式

环境安装好了以后，即可在DevOps的环境中定义任务，完成自动的pdf生成工作，具体是的调用命令为：

~~~shell
/usr/bin/pandoc_deploy.sh 本工程对应的目录
~~~

> 注意：此处的目录为针对本工程的代码对应的所有目录


### gitlab-ci配置说明

在仓库主目录下创建.gitlab-ci.yml文件，示例内容如下：

~~~yml
stages:
  - deploy


doc-deploy:
  stage: deploy
  script:
    -  /usr/bin/pandoc_deploy.sh tmp_doc
  tags:
    - pandoc
~~~

上述配置主要说明如下：

1. stages: deploy, 是指本工程编译只有一个stage
2. doc-deploy: 是指定义的一个任务，其所属的stage为deploy
3. /usr/bin/pandoc_deploy.sh tmp_doc 是指本工程生成的pdf将复制到/srv/doc/tmp_doc目录下[^dir]
4. tags:pandoc, 是因为环境中有多个gitlab-runner，仅有该标签的runner配置了pandoc环境

[^dir]: 之所以是这个目录是因为pandoc_deploy.sh中的target_dir为/srv/doc


## 下一步的定制

可以根据需要对pandoc_deploy.sh进行修改，通过rsync将其与其他文档管理系统进行同步。
当然，若只是简单的通过httpd或者nginx进行文件展示，则该文件无需修改，
但是注意至少需要通过htpasswd进行权限验证，以避免企业机密的外泄！


# 引用参考 

本工程主要参考包括：

* [Eisvogel模板](https://github.com/Wandmalfarbe/pandoc-latex-template)：
  参考Eisvogel模板，针对国内环境的需要，做了个性化定制，主要取便在于
  * 指定了字体为微软雅黑，默认解决中文问题
  * 指定目录编号层级为5级
  * 解决了4、5级目录的格式问题，确保目录后有换行
  * 定制了页眉页脚内容
  * 增加了version属性，展示在封面上
  * 增加了file-code文档编号属性，用于在封面上的展示
  * 增加了company可选(默认在模板中设置，可以手工修改）属性，展示在封面和页脚上
  * 修改了页码格式
  * ...
* [formal-boot-title-page](https://www.latextemplates.com/template/formal-book-title-page):
  参考该模板修改了封面格式，主要修改点
  * 增加文档编号
  * 调整了author的展示
  * publisher改为company
  * 日期调整到company下 

# 许可

 版权所有：2019，[郝金隆](mailto:jinlong.hao@eppdev.cn)

 软件许可：[ANTI-996 License v1.0](https://github.com/eppdev/eppdev-pandoc-template/blob/master/LICENSE-CN)


# 附录

## Markdown概述

Markdown是一种轻量级标记语言，创始人为约翰·格鲁伯（英语：John Gruber）。
它允许人们“使用易读易写的纯文本格式编写文档，然后转换成有效的XHTML（或者HTML）文档”。
这种语言吸收了很多在电子邮件中已有的纯文本标记的特性。

由于Markdown的轻量化、易读易写特性，并且对于图片，图表、数学式都有支持，
当前许多网站都广泛使用 Markdown 来撰写帮助文档或是用于论坛上发表消息。
例如：GitHub、reddit、Diaspora、Stack Exchange、OpenStreetMap 、SourceForge等。
甚至Markdown能被使用来撰写电子书。

Markdown语法参见：[Markdown语法介绍(coding)](https://coding.net/help/doc/project/markdown.html)、
[Markdown基础介绍(简书)](https://www.jianshu.com/p/191d1e21f7ed)


## Markdown写作环境说明

Markdown的规范本身就是文本文档，故任何文本文件编辑器均可进行markdown文件的编辑，编辑markdown文件可以使用专业的编辑器，也可以在IDE环境中安装markdown的插件。

目前业内常用的markdown文件编辑器主要包括：

* sublime
* remarkable
* markdownpad
* Typora


IDE环境：

* Intellij IDEA：可以安装[markdown-navigator](https://plugins.jetbrains.com/plugin/7896-markdown-navigator)插件
  或者[markdown](https://plugins.jetbrains.com/plugin/7793-markdown)插件
* Eclipse: 可以安装[markdown-text-editor](https://marketplace.eclipse.org/content/markdown-text-editor)插件
* VSCode: 可以安装[markdown](https://code.visualstudio.com/docs/languages/markdown)插件

## 配置http环境的安全认证

以CentOS环境下的nginx为例

### 首先安装httpd-tools：

~~~shell
sudo yum install httpd-tools
~~~

### 然后创建密码文件

~~~shell
sudo mkdir /etc/nginx/pass
sudo htpasswd -cb /etc/nginx/pass/mypass eppdev 123
~~~

> 上述命令的作用是在该目录下创建一个mypass文件，用户名是eppdev，
> 密码是123

### 修改nginx配置

在/etc/nginx/nginx.conf文件中添加以下配置

~~~
   location /doc/ {
        alias /srv/doc/ ;
        auth_basic "Input Password:"; 
        auth_basic_user_file "/etc/nginx/pass/mypass"; 
        autoindex on;
        autoindex_exact_size off;
        autoindex_localtime on;
   }
~~~

上述代码的说明：

1. 前两行是指创建一个虚拟的链接子目录，映射到/srv/doc/目录下，即访问
   http://host:port/doc/即为对应的/srv/doc目录
2. 第3，4行是指使用的是基础的认证机制，认证文件即为上文创建的密码文件
3. 第5,6,7行是指启动文件夹文件索引功能，直接通过链接可以访问目录下的文件


