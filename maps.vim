" Key mapping refers to creating a shortcut for repeating a sequence of keys or
" commands. You can map keys to execute frequently used key sequences or to
" invoke an Ex command or to invoke a Vim function or to invoke external
" commands. Using key maps you can define your own Vim commands.
"
" Vim supports several editing modes:
"  - normal
"  - insert
"  - replace
"  - visual
"  - select
"
" command-line and operator-pending. You can map a key to work in all or some
" of these modes.



let mapleader = ','
noremap j gj
noremap k gk
 " Map g* keys in Normal, Operator-pending, and Visual+select
  "noremap $ :call WrapRelativeMotion("$")<CR>
  "noremap <End> :call WrapRelativeMotion("$")<CR>
  "noremap 0 :call WrapRelativeMotion("0")<CR>
  "noremap <Home> :call WrapRelativeMotion("0")<CR>
  "noremap ^ :call WrapRelativeMotion("^")<CR>
  "" Overwrite the operator pending $/<End> mappings from above
  "" to force inclusive motion with :execute normal!
  "onoremap $ v:call WrapRelativeMotion("$")<CR>
  "onoremap <End> v:call WrapRelativeMotion("$")<CR>
  "" Overwrite the Visual+select mode mappings from above
  "" to ensure the correct vis_sel flag is passed to function
  "vnoremap $ :<C-U>call WrapRelativeMotion("$", 1)<CR>
  "vnoremap <End> :<C-U>call WrapRelativeMotion("$", 1)<CR>
  "vnoremap 0 :<C-U>call WrapRelativeMotion("0", 1)<CR>
  "vnoremap <Home> :<C-U>call WrapRelativeMotion("0", 1)<CR>
  "vnoremap ^ :<C-U>call WrapRelativeMotion("^", 1)<CR>

" The following two lines conflict with moving to top and
" bottom of the screen
" If you prefer that functionality, add the following to your
" .vimrc.before.local file:
"   let g:ITM_VIM_no_fastTabs = 1
if !exists('g:ITM_VIM_no_fastTabs')
  map <S-H> gT
  map <S-L> gt
endif

" General{


" }

" Stupid shift key fixes
  if has("user_commands")
    command! -bang -nargs=* -complete=file E e<bang> <args>
    command! -bang -nargs=* -complete=file W w<bang> <args>
    command! -bang -nargs=* -complete=file Wq wq<bang> <args>
    command! -bang -nargs=* -complete=file WQ wq<bang> <args>
    command! -bang Wa wa<bang>
    command! -bang WA wa<bang>
    command! -bang Q q<bang>
    command! -bang QA qa<bang>
    command! -bang Qa qa<bang>
  endif

  cmap Tabe tabe

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Code folding options {
  nmap <leader>f0 :set foldlevel=0<CR>
  nmap <leader>f1 :set foldlevel=1<CR>
  nmap <leader>f2 :set foldlevel=2<CR>
  nmap <leader>f3 :set foldlevel=3<CR>
  nmap <leader>f4 :set foldlevel=4<CR>
  nmap <leader>f5 :set foldlevel=5<CR>
  nmap <leader>f6 :set foldlevel=6<CR>
  nmap <leader>f7 :set foldlevel=7<CR>
  nmap <leader>f8 :set foldlevel=8<CR>
  nmap <leader>f9 :set foldlevel=9<CR>
" }

" Most prefer to toggle search highlighting rather than clear the current
" search results. To clear search highlighting rather than toggle it on
" and off, add the following to your .vimrc.before.local file:
"   let g:ITM_VIM_clear_search_highlight = 1
  "nmap <silent> <leader>/ :nohlsearch<CR>
nmap <silent> <leader>/ :set invhlsearch<CR>


" Find merge conflict markers
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>


" Shortcuts
" Change Working Directory to that of the current file
cmap cwd lcd %:p:h
cmap cd. lcd %:p:h

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Allow using the repeat operator with a visual selection (!)
" http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

" Some helpers to edit mode
" http://vimcasts.org/e/14
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%
map <leader>ve :tabnew ~/.vimrc <CR>

" Adjust viewports to the same size
map <Leader>= <C-w>=

map <Leader>t :terminal<Space>
map <leader>bo :OpenBrowser<Space>

" Map <Leader>ff to display all lines with keyword under cursor
" and ask which one to jump to
nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" Easier horizontal scrolling
map zl zL
map zh zH

" Easier formatting
nnoremap <silent> <leader>q gwip

" FIXME: Revert this f70be548
" fullscreen mode for GVIM and Terminal, need 'wmctrl' in you PATH
map <silent> <F11> :call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")<CR>


nnoremap <silent> <Space> :nohlsearch <CR>
"nnoremap <C-T> :tabnew
map t :tabnew<Space>
map so :source ~/.vimrc <CR>
map lr :AirlineRefresh <CR>
"map <C-Tab> :bnext <CR>
"map <c-S-Tab> :bprevious <CR>
"nnoremap tc :close
"map <C-S-tab> :bprevious<CR>
"map <C-tab>   :bnext<CR>
"inoremap <C-S-tab> <Esc>:bprevious<CR>i
"inoremap <C-tab>   <Esc>:bnext<CR>i
"inoremap <C-t>     <Esc>:tabnew<CR>

map ,fp :FZF <CR>
map ,ds :%s/\s\+$// <CR>
map ff :set ff=
map ft :setfiletype<Space>
map fe :set fileencoding=
map fo :foldopen <CR>
map fc :foldclose <CR>
"map <C-B> :!php % <Bar> clear <CR>

"" Map g* keys in Normal, Operator-pending, and Visual+selectn
"noremap $ :call WrapRelativeMotion("$")<CR>
"noremap <End> :call WrapRelativeMotion("$")<CR>
"noremap 0 :call WrapRelativeMotion("0")<CR>
"noremap <Home> :call WrapRelativeMotion("0")<CR>
"noremap ^ :call WrapRelativeMotion("^")<CR>

"" Overwrite the operator pending $/<End> mappings from above
"" to force inclusive motion with :execute normal!
"onoremap $ v:call WrapRelativeMotion("$")<CR>
"onoremap <End> v:call WrapRelativeMotion("$")<CR>

"" Overwrite the Visual+select mode mappings from above
"" to ensure the correct vis_sel flag is passed to function
"vnoremap $ :<C-U>call WrapRelativeMotion("$", 1)<CR>
"vnoremap <End> :<C-U>call WrapRelativeMotion("$", 1)<CR>
"vnoremap 0 :<C-U>call WrapRelativeMotion("0", 1)<CR>
"vnoremap <Home> :<C-U>call WrapRelativeMotion("0", 1)<CR>
"vnoremap ^ :<C-U>call WrapRelativeMotion("^", 1)<CR>

" WordPress{
  nnoremap <leader>co :Wcodexsearch <CR>
" }

"CtrlP{
    map ,fb :CtrlPBuffer <CR>
    map ,fm :CtrlPMRUFiles <CR>
    map ,fn :CtrlPFunky <CR>
    map ,wf :CtrlPfilter <CR>
    map ,wa :CtrlPaction <CR>
    map ,fl :CtrlPLine <CR>
    map ,fs :CtrlPCurFile <CR>
    map ,fu :CtrlPUndo <CR>
    map ,ft :CtrlPTag <CR>
"}

" Python {
  map <Leader>pa :Autopep8 <CR>
  map <Leader>pp :PyFlakeAuto <CR>
"}


" Fugitive {
    if isdirectory(expand("~/.vim/plugin/vim-fugitive/"))
      nnoremap <silent> <leader>gs :Gstatus<CR>
      nnoremap <silent> <leader>gd :Gdiff<CR>
      nnoremap <silent> <leader>gc :Gcommit<CR>
      nnoremap <silent> <leader>gb :Gblame<CR>
      nnoremap <silent> <leader>gl :Glog<CR>
      nnoremap <silent> <leader>gp :Git push<CR>
      nnoremap <silent> <leader>gr :Gread<CR>
      nnoremap <silent> <leader>gw :Gwrite<CR>
      nnoremap <silent> <leader>ge :Gedit<CR>
      " Mnemonic _i_nteractive
      nnoremap <silent> <leader>gi :Git add -p %<CR>
      nnoremap <silent> <leader>gg :SignifyToggle<CR>
    endif
"}
