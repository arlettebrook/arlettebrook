" Vim with all enhancements
source $VIMRUNTIME/vimrc_example.vim

" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

""""""基本设置""""""
filetype on "开启文件类型侦测
filetype indent on  "适应不同语言的缩进
syntax enable "开启语法高亮功能
syntax on   "允许使用用户配色

""""""显示设置""""""
set shortmess=atI         "不显示启动提示信息
set laststatus=2          "总是显示状态栏,命令行（在状态行下）的高度，默认为1，这里是2
" 我的状态行显示的内容（包括文件类型和解码）
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
"set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%]
"set cmdheight=2         " 命令行（在状态行下）的高度，默认为1，这里是2
set ruler                 "显示光标位置
set number                "显示行号
set cursorline            "高亮显示当前行
set cursorcolumn            "高亮显示当前列
set hlsearch                " 高亮搜索结果
set incsearch               "边输边高亮
set ignorecase              "搜索时忽略大小写
set smartcase

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
set guioptions-=T           " 隐藏工具栏
set guioptions-=m           " 隐藏菜单栏



set guifont=Courier\ New:h20

set lines=15 columns=50 



""""""插件""""""

""""""vim-plug""""""
call plug#begin('$VIM/vimfiles/plugged')
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

Plug 'wakatime/vim-wakatime'

"颜色主题
"Plug 'morhetz/gruvbox'
Plug 'Arlettebrook/seoul256.vim'

"状态栏主题
Plug 'Arlettebrook/lightline.vim'

"
Plug 'Arlettebrook/nerdtree'

"自动补全
Plug 'Arlettebrook/auto-pairs'


" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting


"autocmd vimenter * ++nested colorscheme gruvbox
"set background=dark    " Setting dark mode

let g:seoul256_background = 235
colo seoul256

" Start NERDTree and leave the cursor in it.
"autocmd VimEnter * NERDTree