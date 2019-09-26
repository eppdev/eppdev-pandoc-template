---
title: "XXX项目软件开发需求说明书"
version: V0.2
author: "jinlong.hao"
date: "2019-08"
company: EPPDEV.CN
file-code: EPPDEV-TEMPLATE-SAMPLE-01
logo: true
history:
  - version: V0.1
    author: 郝金隆
    date: 2019-09-25
    desc: 创建第一份示例文档
  - version: V0.2
    author: 郝金隆
    date: 2019-09-26
    desc: 按照新的模板，增加了修订记录内容
...
 
 
# 文档概述
 
## 本文说明 
 
本文是markdown转换为pdf的示例文件[^1]，主要用于演示如何通过markdown转换为pdf文件

[^1]:测试脚注
 
## 文档保密要求
 
本文无任何保密要求，任何和均可自由使用
 
 
 
# 内容示例
 
## 这是正文内容 
 
这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文
这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文
这是正文
 
这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文
这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文这是正文
这是正文这是正文
 
 
## 基本格式 
 
**加粗字体**
 
*斜体*
 
~~删除线~~
 
> 这是引用
 
## 分割线 
 
----
 
## 超链接 
 
[百度](http://www.baidu.com)
 
## 列表
 
### 有编码列表
 
1. 列表
2. 列表
   1. 列表
   2. 列表
1. 列表
 
### 无编号列表
 
* 编号
* 编号
* 编号
  * 编号
  * 编号
* 编号
 
## 表格
 

| 标题1  | 标题2 | 标题3 |
| :-----: | :----- | -----: |
| 1      | aaa   | aaaaa |
| 2      | bbb   | bbbbb |

:测试表格



 
## 代码 
 
~~~java 
public static void main(){
   System.out.println("Hello, world!");
   int a = 2;
   int b = a + 2;
   System.out.println(a > 2 ? 1 : 0);
}
~~~

~~~sql
SELECT
    *
FROM eppdev_tables
WHERE name LIKE '%hell%'
    and id in ('aa', 'bbb')
    and create_time > '2019'; 
~~~

## 二级目录

正文

### 三级目录

正文

#### 四级目录 ####

()  

正文

##### 五级目录

正文

##### level5

pages

正文
