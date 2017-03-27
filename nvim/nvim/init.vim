" ==================== 基本の設定 ==================== "
" 全般設定
set nocompatible            " 必ず最初に書く
set viminfo='20,<50,s10,h,! " YankRing用に!を追加
set shellslash              " Windowsでディレクトリパスの区切り文字に / を使えるようにする
set lazyredraw              " マクロなどを実行中は描画を中断
set t_Co=256
set termguicolors

source ~/.config/nvim/plugins.vim 
source ~/.config/nvim/local_setting.vim

runtime! settings/*.vim

"colorscheme lucius
colorscheme iceberg 

if has('unix') && !has('gui_running')
    inoremap <silent> <Esc> <Esc>
    inoremap <silent> <C-[> <Esc>
endif

" 「日本語入力固定モード」切替キー
inoremap <silent> <C-j> <C-r>=IMState('FixMode')<CR>
" " PythonによるIBus制御指定
let IM_CtrlIBusPython = 1

set tabstop=4 shiftwidth=4 softtabstop=0
set expandtab              " タブを空白文字に展開
set autoindent smartindent " 自動インデント，スマートインデント

" 入力補助
set backspace=indent,eol,start " バックスペースでなんでも消せるように
set formatoptions+=m           " 整形オプション，マルチバイト系を追加

" コマンド補完
set wildmenu           " コマンド補完を強化
set wildmode=list:full " リスト表示，最長マッチ

" 検索関連
set wrapscan   " 最後まで検索したら先頭へ戻る
set ignorecase " 大文字小文字無視
set smartcase  " 大文字ではじめたら大文字小文字無視しない
set incsearch  " インクリメンタルサーチ
set hlsearch   " 検索文字をハイライト

" ファイル関連
set nobackup   " バックアップ取らない
set autoread   " 他で書き換えられたら自動で読み直す
set noswapfile " スワップファイル作らない
set hidden     " 編集中でも他のファイルを開けるようにする

"表示関連
set showmatch         " 括弧の対応をハイライト
set showcmd           " 入力中のコマンドを表示
set number            " 行番号表示
set wrap              " 画面幅で折り返す
"set list              " 不可視文字表示
"set listchars=tab:>  " 不可視文字の表示方法
set notitle           " タイトル書き換えない
set scrolloff=5       " 行送り
set cursorline

" ステータスライン関連
set laststatus=2

" エンコーディング関連
set ffs=unix,dos,mac " 改行文字

" 文字コードの自動認識
" 適当な文字コード判別
set termencoding=utf-8
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp

" UTF-8の□や○でカーソル位置がずれないようにする
" Terminal.appはどっちにしてもダメ，PrivatePortsのiTermでやる
set ambiwidth=double


" Migemo
if has('migemo')
    set migemo
    set migemodict=/opt/local/share/migemo/utf-8/migemo-dict
endif

" Kaoriya
if has('kaoriya')
    " imを無効にする
    set iminsert=0
    set imsearch=0
endif

" ==================== キーマップ ==================== "
" 表示行単位で移動
noremap j gj
noremap k gk
vnoremap j gj
vnoremap k gk

inoremap OA <Up>
inoremap OB <Down>
inoremap OC <Right>
inoremap OD <Left>

noremap <C-s> :w<CR>

if !has('gui_running')
    set notimeout
    set ttimeout
    set timeoutlen=100
endif

" ハイライト消す
nmap <silent> gh :nohlsearch<CR>
  
" マウス操作を有効にする
set mouse=a

set tags=.tags;

nmap <C-]> g<C-]>

vnoremap <C-W>t gt

" Terminalモードからescで抜ける
tnoremap <silent> <ESC> <C-\><C-n>

set complete+=k    " 補完に辞書ファイル追加


syntax on " シンタックスカラーリングオン

filetype indent on " ファイルタイプによるインデントを行う
filetype plugin on " ファイルタイプごとのプラグインを使う
