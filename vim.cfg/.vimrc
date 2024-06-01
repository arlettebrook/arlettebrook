""""""基本设置""""""
filetype on "开启文件类型侦测
filetype indent on  "适应不同语言的缩进
syntax enable "开启语法高亮功能
syntax on   "允许使用用户配色

""""""显示设置""""""
set shortmess=atI         "不显示启动提示信息
set laststatus=2          "总是显示状态栏,命令行（在状态行下）的高度，默认为1，这里是2。
" 我的状态行显示的内容（包括文件类型和解码）后续用插件美化。
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
"set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%]
"set cmdheight=2         " 命令行（在状态行下）的高度，默认为1，这里是2
set ruler                 "显示光标位置
set number                "显示行号
"set cursorline            "高亮显示当前行
"set cursorcolumn            "高亮显示当前列
set hlsearch                " 高亮搜索结果
set incsearch               "边输边高亮
set ignorecase              "搜索时忽略大小写
set smartcase				" 智能大小写匹配

"set relativenumber     "其他行显示相对行号
set scrolloff=5     "垂直滚动时光标距底部位置

""""""编码设置""""""
set fileencodings=utf-8,gb2312,gbk,gb18030,cp936    " 检测文件编码,将fileencoding设置为最终编码
set fileencoding=utf-8                              " 保存时的文件编码
set termencoding=utf-8                              " 终端的输出字符编码
set encoding=utf-8                                  " VIM打开文件使用的内部编码

""""""编辑设置""""""
set expandtab     "扩展制表符为空格
set tabstop=4     "制表符占空格数
set softtabstop=4 "将连续数量的空格视为一个制表符
set shiftwidth=4  "自动缩进所使用的空格数
set textwidth=80 "设置一行内容的宽度
set linebreak       "防止单词内部折行
set wrapmargin=5      "指定折行处与右边缘空格数
set smarttab        "使用智能制表符
set smartindent "智能缩进(好处是修改代码时会根据代码规则自动缩进，坏处是当用`:n,m>`对齐左侧的注释将不会被移动)
"set autoindent "自动缩进(这两个差不多，感觉在大括号自动配对时，用智能缩进好点)
set wildmenu      "vim命令自动补全
set autochdir     "自动定位当前目录。
set wrap          "启用自动换行"
set autoread        "文件改动时自动载入
set t_Co=256        "terminal Color 支持256色(默认是8色)
hi comment ctermfg=6 "设置注释颜色
set magic                   " 设置魔术
set guioptions-=T           " 隐藏gui工具栏
set guioptions-=m           " 隐藏gui菜单栏
set guioptions-=r           " 删去gui滚动条"
" 使用更友好的颜色方案
"colorscheme desert
" 设置背景色
set background=dark
" 显示命令输入
set showcmd

"设置gui字体
set guifont=Courier\ New:h20

" 设置宽高
"set lines=15 columns=50 

" 启用真彩色颜色支持，让配色方案显示更好。
set termguicolors



""""""插件vim-plug""""""

" 初始化 vim-plug
" Linux上默认
" call plug#begin()
" windows上自定义插件安装位置
call plug#begin('$VIM/vimfiles/plugged')
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" 添加插件列表,确保使用的是单引号。

" 一组默认配置-每个人都同样的配置
Plug 'tpope/vim-sensible'

Plug 'wakatime/vim-wakatime'

" 轻量级状态栏插件。
Plug 'itchyny/lightline.vim'

" Highlight copied text
Plug 'machakann/vim-highlightedyank'

" 支持多种编程语言的语法高亮。
Plug 'sheerun/vim-polyglot'

" 文件系统浏览器，提供树状目录视图。
Plug 'preservim/nerdtree'

" 成对添加、删除、高亮括号。 
Plug 'jiangmiao/auto-pairs'

" 黑色主题
Plug 'ajmwagar/vim-deus'

" 终端透明
Plug 'tribela/vim-transparent'

" 类似jetbrains主题
Plug 'kaicataldo/material.vim', { 'branch': 'main'  }

" 成对修改括号类字符：命令cs"'
Plug 'tpope/vim-surround'

" 快速注释：命令gcc
Plug 'tpope/vim-commentary'


" Call plug#end to update &runtimepath and initialize the plugin system.
" - It automatically executes `filetype plugin indent on` and `syntax enable`
" 结束插件配置
call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting

""""""插件vim-plug结束""""""


" material theme settings
"let g:material_theme_style = 'darker-community'
colorscheme material

"colorscheme deus

