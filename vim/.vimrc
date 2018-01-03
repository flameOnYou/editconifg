set nocompatible              " 去除VI一致性,必须要添加
filetype off                  " 必须要添加
set nu

"TAB替换为空格：
:set ts=4
:set expandtab
:%retab!

"将 https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim 下载下来的文件放在autoload文件夹中"
call plug#begin('$VIM/vimfiles/bundle/')


" 以下范例用来支持不同格式的插件安装.
" 请将安装插件的命令放在vundle#begin和vundle#end之间.
" Github上的插件
" 格式为 Plugin '用户名/插件仓库名'
Plug 'tpope/vim-fugitive'

"状态栏，装逼用的
Plug 'vim-airline/vim-airline'

" 来自 http://vim-scripts.org/vim/scripts.html 的插件
" Plug '插件名称' 实际上是 Plug 'vim-scripts/插件仓库名' 只是此处的用户名可以省略
Plug 'L9'

"彩虹括号
Plugin 'luochen1990/rainbow'
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle


" 本地的Git仓库(例如自己的插件) Plug 'file:///+本地插件仓库绝对路径'
"Plug 'file:///home/gmarik/path/to/plug'
"批量注释插件
Plug 'scrooloose/nerdcommenter'

"文件搜索
Plug 'junegunn/fzf',{ 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"主题
Plug 'sickill/vim-monokai'
" 插件在仓库的子目录中.
" 正确指定路径用以设置runtimepath. 以下范例插件在sparkup/vim目录下
Plug 'rstacruz/sparkup'
" 安装L9，如果已经安装过这个插件，可利用以下格式避免命名冲突
"Plug 'ascenator/L9', {'name': 'newL9'}
Plug 'davidhalter/jedi-vim'
Plug 'scrooloose/nerdtree'
" 你的所有插件需要在下面这行之前
"文件搜索插件
"这里要安装 apt install python-dev python3-dev
"然后cd ~/.vim/bundle/LeaderF
"运行./install
"查找的时候输入LeaderfFile 文件地址
Plug 'Yggdroot/LeaderF'
"vim文件内容搜索插件
Plug 'mileszs/ack.vim'
call plug#end()            " 必须
filetype plugin indent on    " 必须 加载vim自带和插件相应的语法和文件类型相关脚本
" 忽视插件改变缩进,可以使用以下替代:
"filetype plugin on
"
" 常用的命令
" :PluginList       - 列出所有已配置的插件
" :PluginInstall     - 安装插件,追加 `!` 用以更新或使用 :PluginUpdate
" :PluginSearch foo - 搜索 foo ; 追加 `!` 清除本地缓存
" :PluginClean      - 清除未使用插件,需要确认; 追加 `!` 自动批准移除未使用插件
"
" 查阅 :h vundle 获取更多细节和wiki以及FAQ
" 将你自己对非插件片段放在这行之后
"主题
syntax enable
"colorscheme monokai

color molokai
"设置mapleader
let mapleader = ","

"Nedtree
map <F3> :NERDTreeMirror<CR>
map <F3> :NERDTreeToggle<CR>
"共享剪切板
set clipboard=unnamed
"一键编辑配置文件
map <F12>:edit $MYVIMRC<CR>
"缩进尺寸为4个空格
set sw=4
"tab宽度为4个字符
set ts=4
"编辑时将所有tab替换为空格
set et
""按一次backspace就删除4个空格了
set smarttab
"ctags
set tags=~/.tags
"===========  F5 run python ====================  "ckly Run
""""""""""""""""""""""
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		    exec "!g++ % -o %<"
		    exec "!time ./%<"
	elseif &filetype == 'cpp'
		    exec "!g++ % -o %<"
		    exec "!time ./%<"
	elseif &filetype == 'java'
		    exec "!javac %"
		    exec "!time java %<"
	elseif &filetype == 'sh'
		    :!time bash %
	elseif &filetype == 'python'
		    exec "!time python2.7 %"
	elseif &filetype == 'html'
		    exec "!firefox % &"
	elseif &filetype == 'go'
	    "        exec "!go build %<"
		    exec "!time go run %"
	elseif &filetype == 'mkd'
		    exec "!~/.vim/markdown.pl % > %.html &"
		    exec "!firefox %.html &"
	endif
    endfunc
"ctrl+s保存
"很多终端中，CTRL-S按键是有特殊用途的。 "CTRL-S：挂起终端（XON）
""CTRL-Q：恢复终端（XOFF） "要禁止这些键盘映射，在~/.bashrc中加入 
"stty -ixon
"nmap<C-S> :update<CR>
"修改配置文件立即生效
"map<F12>:source $MYVIMRC<CR>
"
"fzf配置 在当前路径下搜索文件
nnoremap <C-S-R> :Files ./<CR>
"ack配置，unbuntu下需要先安装 apt install
"ack-grep,以下命令增加感叹号是因为不自动打开第一个文件
map <C-h> :Ack!<space>-i<space>
