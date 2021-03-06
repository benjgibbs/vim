autocmd!
so ~/.vim/plug-modules.vim

set tabstop=2
set shiftwidth=2
set laststatus=2
set bdir=~/tmp,~/,.
set directory=~/tmp,~/,.
set foldmethod=marker
set smartindent
set expandtab
set number
set showcmd
set wildmenu
set lazyredraw
set showmatch
set smartcase
set incsearch
set hlsearch
set confirm
set hidden


filetype indent on
filetype plugin indent on

syntax enable

runtime! ftplugin/man.vim

let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

set path+=/usr/include/**
set path+=/Library/Developer/CommandLineTools/usr/include/c++/v1/**
set path+=/usr/include/c++/4.2.1/**
set path+=/usr/local/include/**

syntax enable
if has('gui_running')
  "colorscheme burnttoast256
  set background=light
  colorscheme whitebox
  let g:airline#extensions#tabline#enabled = 1  
  let g:airline_powerline_fonts = 1
  set guifont=DejaVu\ Sans\ Mono\ For\ Powerline:h14
  set cursorline
else
  "set background=dark
  "colo 256-jungle
  set background=light
  colorscheme whitebox
endif

nmap <leader>m :CtrlPMRU<CR>
nmap <leader><space> :nohlsearch<CR>
nmap <leader>f :NERDTreeToggle %:h<CR>

au FileType make setlocal noexpandtab
au FileType c setlocal makeprg=cc\ -pthread\ -Wall\ %\ -o\ %:r 

au Filetype xml nmap <leader>F :%!xmllint --format --recover - 2>/dev/null<CR>
au Filetype rs nmap <leader>F :RustFmt<CR>
au BufNewFile,BufRead *.json nmap<leader>F :%!python -m json.tool<CR>
au BufNewFile,BufRead *.js nmap <leader>F :call JsBeautify()<cr> 

" Go lang
au FileType go call go#path#GoPath('/Users/ben/Git/GoCode')
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <Leader>d <Plug>(go-def)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
au FileType go nmap <Leader>i :GoImport 

" Rust
let g:rustfmt_autosave = 1

" Tags
fun! SetCTags()
  setlocal tags=~/.tags;/
  setlocal tags+=~/.local.tags
endfun

fun! SetRustTags()
  setlocal tags=./rusty-tags.vi;/
  setlocal tags+=$RUST_SRC_PATH/rusty-tags.vi
endfun

autocmd BufNewFile,BufRead *.rs call SetRustTags()
autocmd BufNewFile,BufRead *.c,*.cpp,*.h,*.hpp,*.cxx call SetCTags()
autocmd BufWrite *.rs :silent exec "!rusty-tags vi --start-dir=" . expand('%:p:h') . "&"
