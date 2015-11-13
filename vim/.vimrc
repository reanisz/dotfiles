" ==================== 基本の設定 ==================== "
" 全般設定
set nocompatible            " 必ず最初に書く
set viminfo='20,<50,s10,h,! " YankRing用に!を追加
set shellslash              " Windowsでディレクトリパスの区切り文字に / を使えるようにする
set lazyredraw              " マクロなどを実行中は描画を中断
set t_Co=256
source ~/.vimrc.plugin        " プラグイン周り
source ~/.vimrc.local
colorscheme lucius

let $CPP_STDLIB = "/usr/include/c++/"
set path+=$CPP_STDLIB

au BufReadPost $CPP_STDLIB/* if empty(&filetype) | set filetype=cpp | endif

au BufRead,BufNewFile *.html.ep  set filetype=html
au BufRead,BufNewFile *.als set filetype=alloy4
augroup filetypedetect
    au BufRead,BufNewFile *.dis* setfiletype dis
augroup END

" Powerline
" UTF-8 環境でないとうまく表示されない
set encoding=utf-8
" " フォントサイズはお好みで
set guifont=Ricty_for_Powerline:h10
" " こっちは日本語フォント
set guifontwide=Ricty:h10
" " `fancy' テーマに切り替え
let g:Powerline_symbols = 'fancy'
if has('unix') && !has('gui_running')
    inoremap <silent> <Esc> <Esc>
    inoremap <silent> <C-[> <Esc>
endif

" 「日本語入力固定モード」切替キー
inoremap <silent> <C-j> <C-r>=IMState('FixMode')<CR>
" " PythonによるIBus制御指定
let IM_CtrlIBusPython = 1

" タブ周り
" tabstopはTab文字を画面上で何文字分に展開するか
" shiftwidthはcindentやautoindent時に挿入されるインデントの幅
" softtabstopはTabキー押し下げ時の挿入される空白の量，0の場合はtabstopと同じ，BSにも影響する
set tabstop=4 shiftwidth=4 softtabstop=0
au BufNewFile,BufRead *.html set nowrap tabstop=2 shiftwidth=2
au BufNewFile,BufRead *.html.ep set nowrap tabstop=2 shiftwidth=2
au BufNewFile,BufRead *.json set nowrap tabstop=2 shiftwidth=2
au BufNewFile,BufRead *.css set nowrap tabstop=2 shiftwidth=2
au BufNewFile,BufRead *.less set nowrap tabstop=2 shiftwidth=2
au BufNewFile,BufRead *.mkd set nowrap tabstop=2 shiftwidth=2
au BufNewFile,BufRead *.hsp set filetype=hsp
au BufNewFile,BufRead Makefile set nowrap tabstop=8 shiftwidth=8

" その他ファイル特有の設定
au BufNewFile,BufRead *.pl imap <C-p> <C-x><C-o>
au BufNewFile,BufRead *.pm imap <C-p> <C-x><C-o>

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
" set list              " 不可視文字表示
" set listchars=tab:>  " 不可視文字の表示方法
set notitle           " タイトル書き換えない
set scrolloff=5       " 行送り

" ステータスライン関連
set laststatus=2

" エンコーディング関連
set ffs=unix,dos,mac " 改行文字

" 文字コードの自動認識
" 適当な文字コード判別
set termencoding=utf-8
set encoding=utf-8
set fileencodings=iso-2022-jp,utf-8,cp932,euc-jp


" UTF-8の□や○でカーソル位置がずれないようにする
" Terminal.appはどっちにしてもダメ，PrivatePortsのiTermでやる
set ambiwidth=double

" ファイルタイプ関連
" 使用できる色は
" :edit $VIMRUNTIME/syntax/colortest.vim
" :source %
" で、設定名と現在の色は
" :highlight

syntax on " シンタックスカラーリングオン

set complete+=k    " 補完に辞書ファイル追加
filetype indent on " ファイルタイプによるインデントを行う
filetype plugin on " ファイルタイプごとのプラグインを使う

" Omni補完関連
" $VIMRUNTIME/autoload/htmlcomplete.vimの645行目をコメントアウントしておくとhtmlの補完が小文字になる

set completeopt=menu,preview,menuone " 補完表示設定

" TabでOmni補完及びポップアップメニューの選択
function InsertTabWrapper(is_shift)
    if pumvisible()
        return a:is_shift ? "\<C-p>" : "\<C-n>"
    endif
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ 'k|<|/' " htmlで補完できるように<,/でもOmni補完
        return "\<tab>"
    elseif exists('&omnifunc') && &omnifunc == ''
        return a:is_shift ? "\<C-p>" : "\<C-n>"
    else
        return "\<C-x>\<C-o>"
    endif
endfunction

inoremap <tab> <C-r>=InsertTabWrapper(0)<CR>
" Shift-Tabはうまくいかないようだ
inoremap <S-tab> <C-r>=InsertTabWrapper(1)<CR>

function OmniCancelEsc()
    return pumvisible() ? "\<C-e>" : "\<esc>"
endfunction

" inoremap <esc> <C-r>=OmniCancelEsc()<CR>

function Omnijk(key)
    if !pumvisible()
        return a:key == "j" ? "\<C-j>" : "\<C-k>"
    endif
    return a:key=="j" ? "\<C-n>" : "\<C-p>"
endfunction

inoremap <C-j> <C-r>=Omnijk("j")<CR>
inoremap <C-k> <C-r>=Omnijk("k")<CR>

" 補完
function OmniNul()
    return "\<C-n>"
    if !pumvisible()
        return "\<C-n>\<C-p>"
    endif
    return "\<C-n>"
endfunction

inoremap <Nul> <C-r>=OmniNul()<CR>

" CRでOmni確定
function InsertCrWrapper()
    return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" inoremap <CR> <C-r>=InsertCrWrapper()<CR>

autocmd InsertCharPre * :call Omnijk("j")

" ポップアップメニューの色変える
highlight Pmenu ctermbg=lightcyan ctermfg=black 
highlight PmenuSel ctermbg=blue ctermfg=black 
highlight PmenuSbar ctermbg=darkgray 
highlight PmenuThumb ctermbg=lightgray

" バイナリモード
" bviとかHexEditor.appの方が楽
" vim -b : edit binary using xxd-format!
" augroup BinaryXXD
  " autocmd!
  " autocmd BufReadPre *.bin,*.swf let &binary =1
  " autocmd BufReadPost * if &binary | silent %!xxd -g 1
  " autocmd BufReadPost * set ft=xxd | endif
  " autocmd BufWritePre * if &binary | %!xxd -r | endif
  " autocmd BufWritePost * if &binary | silent %!xxd -g 1
  " autocmd BufWritePost * set nomod | endif
" augroup END

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

" コピペ
" Macの場合は普通にComamnd-C，Command-Vも使えたりする
if has('mac')
    map <silent> gy :call YankPB()<CR>
    function! YankPB()
        let tmp = tempname()
        call writefile(getline(a:firstline, a:lastline), tmp, 'b')
        silent exec ":!cat " . tmp . " | iconv -f utf-8 -t shift-jis | pbcopy"
    endfunction
endif
if has('win32')
    noremap gy "+y
    " ペーストがうまく動いてない
    noremap gp "+p
endif
  
" マウス操作を有効にする
set mouse=a
set ttymouse=xterm2

"英和辞書
command! -nargs=1 EDict :echo system("edict -v '<args>'")

nnoremap <C-K> :EDict <C-R><C-W><CR>
nnoremap ,<C-K> :EDict <C-R><C-W>

vnoremap <C-K> "wy:EDict <C-R>w<CR>
vnoremap ,<C-K> "wy:EDict <C-R>w

set tags=.tags;

nmap <C-]> g<C-]>

vnoremap <C-W>t gt

function! Test(file)
    let bufname = "TEST-RESULT-" . a:file
    let bn = bufwinnr(bufnr(l:bufname))
    if bn == -1
        new 
        setlocal buftype=nofile
        setlocal noswapfile
        setlocal bufhidden=wipe
        exec("file! " . l:bufname)
    else
        exec(l:bn . "wincmd w")
        exec("%delete")
    endif
    let result = system("atcoder test " . a:file)
    call append('.', split(l:result, '\n'))
endfunction

function! Submit(file)
    let result = system("atcoder submit " . a:file)
    echo "done."
endfunction

command Test :call Test(expand("%:r"))
nnoremap Q :<C-u>Test <CR>

command Submit :call Submit(expand("%:r"))
