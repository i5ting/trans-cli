# Guide

trans是一个在markdown文件加css来翻译文档的工具，使用ruby写的

以下是trans翻译工具使用说明文档

## 基础使用

### 翻译步骤

#### 第一步：编写markdown文章

	欢迎使用 Sketch 3 的用户手册，这个手册的内容同时适用于新手和熟练用户。
	如果你对于这个手册的内容有任何想法和疑问，请通过 [邮箱](mailto:mail@bohemiancoding.com)  随时联系我们。
	我们会不断的完善本手册。
 
 
	# 介绍（Introduction）


	Sketch is a vector drawing app intended for designers of all sorts. Vector-based drawing is by far the the best way to design websites, icons or interfaces. On top of this vector editing we have added support for basic bitmap styles, such as blur and color corrections.

	We’ve made Sketch both powerful and easy to understand. Experienced designers can easily transfer their existing skills in a matter of hours, and replace Adobe Photoshop, Illustrator or Fireworks for most digital design tasks.

	
	Sketch 是一款适用于所有设计师的矢量绘图应用。矢量绘图也是目前进行网页，图标以及界面设计的最好方式。但除了矢量编辑的功能之外，我们同样添加了一些基本的位图工具，比如模糊和色彩校正。
 
	我们尽力让 Sketch 容易理解并上手简单，有经验的设计师花上几个小时便能将自己的设计技巧在Sketch中自如运用。对于绝大多数的数字产品设计，Sketch 都能替代 Adobe Photoshop，Illustrator 和 Fireworks。

#### 第二部：使用标签

	<div class='zh'>
	Sketch 是一款适用于所有设计师的矢量绘图应用。矢量绘图也是目前进行网页，图标以及界面设计的最好方式。但除了矢量编辑的功能之外，我们同样添加了一些基本的位图工具，比如模糊和色彩校正。
 
	我们尽力让 Sketch 容易理解并上手简单，有经验的设计师花上几个小时便能将自己的设计技巧在Sketch中自如运用。对于绝大多数的数字产品设计，Sketch 都能替代 Adobe Photoshop，Illustrator 和 Fireworks。
	</div>

	<div class='en'>
	Sketch is a vector drawing app intended for designers of all sorts. Vector-based drawing is by far the the best way to design websites, icons or interfaces. On top of this vector editing we have added support for basic bitmap styles, such as blur and color corrections.

	We’ve made Sketch both powerful and easy to understand. Experienced designers can easily transfer their existing skills in a matter of hours, and replace Adobe Photoshop, Illustrator or Fireworks for most digital design tasks.
	</div>
	
	
#### 第三步：增加样式
	
	<style>
		.en {
			display:block;
			border: 1px solid lightblue;
			padding:25px;
		}
	
		.zh {
			display:block;
			border: 1px solid lightgreen;
			padding:5px;
		}
	</style>


	欢迎使用 Sketch 3 的用户手册，这个手册的内容同时适用于新手和熟练用户。
	如果你对于这个手册的内容有任何想法和疑问，请通过 [邮箱](mailto:mail@bohemiancoding.com)  随时联系我们。
	我们会不断的完善本手册。
	
	
	# 介绍（Introduction）

	<div class='zh'>
	Sketch 是一款适用于所有设计师的矢量绘图应用。矢量绘图也是目前进行网页，图标以及界面设计的最好方式。但除了矢量编辑的功能之外，我们同样添加了一些基本的位图工具，比如模糊和色彩校正。
 
	我们尽力让 Sketch 容易理解并上手简单，有经验的设计师花上几个小时便能将自己的设计技巧在Sketch中自如运用。对于绝大多数的数字产品设计，Sketch 都能替代 Adobe Photoshop，Illustrator 和 Fireworks。
	</div>

	<div class='en'>
	Sketch is a vector drawing app intended for designers of all sorts. Vector-based drawing is by far the the best way to design websites, icons or interfaces. On top of this vector editing we have added support for basic bitmap styles, such as blur and color corrections.

	We’ve made Sketch both powerful and easy to understand. Experienced designers can easily transfer their existing skills in a matter of hours, and replace Adobe Photoshop, Illustrator or Fireworks for most digital design tasks.
	</div>
	
### 掌握css基础，可以让你完成更多功能

如无基础可以参考[w3c school css](http://www.w3school.com.cn/css/css_syntax.asp)

### 如何自定义菜单


在toc_conf.js里，关于菜单部分的配置
 
	var transtool_opts = {
			toolbarselector:"#mp-menu",
			default_state:'all',
	    states:[
	        {
							'all':{
	              'icon':'icon-shop',
								'display':"全部",
	              click:function(){
	                  alert('zh111');
	              }
							},
	            'zh':{
	                'icon':'icon-world',
									'display':"中文",
	                click:function(){
	                    alert('zh111');
	                }
	            },
	            'en':{
	                'icon':'icon-cloud',
									'display':"英文",
	                click:function(){
	                    alert('en');
	                }
	            }
	        }
	    ]
	}
	
这里主要是states，在这里面增加或减少即可修改左侧菜单。

比如

	var transtool_opts = {
			toolbarselector:"#mp-menu",
			default_state:'all',
	    states:[
	        {
							'all':{
	              'icon':'icon-shop',
								'display':"全部",
	              click:function(){
	                  alert('zh111');
	              }
							},
	            'zh':{
	                'icon':'icon-world',
									'display':"中文",
	                click:function(){
	                    alert('zh111');
	                }
	            },
	            'en':{
	                'icon':'icon-cloud',
									'display':"英文",
	                click:function(){
	                    alert('en');
	                }
	            },
	            'todo':{
	                'icon':'icon-cloud',
									'display':"待处理",
	                click:function(){
	                    alert('en');
	                }
	            },
	            'review':{
	                'icon':'icon-cloud',
									'display':"审阅",
	                click:function(){
	                    alert('en');
	                }
	            }
							
	        }
	    ]
	}
	
修改markdown文件中的css样式，主要是增加todo和review对应的样式，如下

	<style>
		.en {
			display:block;
			border: 1px solid lightblue;
			padding:25px;
		}
	
		.zh {
			display:block;
			border: 1px solid lightgreen;
			padding:5px;
		}
	
		.todo {
			display:block;
			border: 1px dashed red;
			padding:15px;
		}
		
		.review {
			display:block;
			border: 1px dashed red;
			padding:15px;
		}
	</style>

## 高级feature

所谓高级也不过就是根据需求自己进行定制而已，加油吧

### 中英文切换

### 开发版本与发布版本切换

### 分配任务

### review

### todo

### 嵌入可运行demo

### 自定义修改i5ting_ztree_toc配置项

请自己按需修改，如有疑问，请到[i5ting_ztree_toc](https://github.com/i5ting/i5ting_ztree_toc)去提issue，我会尽力回复的

i5ting_ztree_toc的配置项如下：

```
//定义默认
$.fn.ztree_toc.defaults = {
	_zTree: null,
	_headers: [],
	_header_offsets: [],
	_header_nodes: [{ id:1, pId:0, name:"Table of Content",open:true}],
	debug: true,
	highlight_offset: 0,
	highlight_on_scroll: true,
	/*
	 * 计算滚动判断当前位置的时间，默认是50毫秒
	 */
	refresh_scroll_time: 50,
	documment_selector: 'body',
	is_posion_top: false,
	/*
	 * 默认是否显示header编号
	 */
	is_auto_number: false,
	/*
	 * 默认是否展开全部
	 */	
	is_expand_all: true,
	/*
	 * 是否对选中行，显示高亮效果
	 */	
	is_highlight_selected_line: true,
	step: 100,
	.....................
};
```
