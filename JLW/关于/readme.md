## 写在前面  

本站为放置精灵王游戏爱好者构建  

速度方面由于是挂载在cloudframe上，某些图片内容初次加载稍慢    

内容来源与qq群群文件  

处于某种未知原因搬到网页上方便查阅  

https://fzjlw.pages.dev/

## 如何使用  

左侧目录点击查阅，不确定内容左上角搜索框  

docsify本身缓存机制，新添加内容可能需要手动刷新  

## 本地使用  

 https://gitee.com/fzjlw/fzjlw  

右侧发行版下载, 也可以下载zip, 发行版版本落后

下载后文件请勿随意移动 start.exe需要位于docsify根目录，同时你可以将该启动应用于其他docsify应用  

## 添加内容  

考虑到这方面需求，使用docsify构建，不需要额外配置，仅需要掌握markdown语法即可  

本地下载后在对应的位置添加.md文件即可 

#### 注意事项  

- 内容可以有修正，原始文件名请勿修改, 必须保留原作者的相关信息  
  - xxx.sufix -> xxx.md(great)  
  - xxx.sufix -> yyy.md(bad)  

- 每行的终止符为两个空格。使用回车在渲染时可能无法准确识别  

- 标题请不要加**等格式，最好是仅使用#，其他格式docsify无法识别，可能造成内容无法跳转  

- 避免使用#一级标题，跳转后无法自动打开左侧目录  

- 每个文件开头应该有个标题，避免使用搜索时出现乱码  

- 如果可以的话，纯文字内容尽量转化成文字  
    - 非强制性要求，考虑到实际使用，保留图片也是一种选择  
    - 纯图片内容也应该加个二级标题  
    - eg: ## xxx  

- 文件路径不能带有空格，无法识别  

- 图片等非md格式内容需要放在_media文件夹下  

- 引入其他md的路径是并不完全是相对路径
  - /xxx/yyy/a.md
  - /xxx/yyy/b.md
  - 如果想要在a里面引用b, 不能直接`[显示的文字](b.md)`, docsify渲染后会将它视为根目录下的b.md
  - 正确做法是`[显示的文字](/xxx/yyy/a.md)` or `[显示的文字](/xxx/yyy/a.md#需要跳转的标题)`

- 添加完成后需要运行buildSidebar.exe构建侧边栏  

## 脚本说明  

- buildSidebar.exe 用于构建侧边栏，使用前请先阅读config.ini文件并修改对应路径
  - [buildSidebar github](https://github.com/xhuihuix/docsify-auto-sidebar-gen)
  - [buildSidebar gitee](https://gitee.com/xhuihuix/docsify-auto-sidebar-gen)

- build_simple_photo2md.py  用于批量转化单张图片为.md格式，一般使用不到  

- start.exe win下启动docsify，不需要额外安装其他内容  






