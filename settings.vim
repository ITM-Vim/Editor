" General {
    set background=dark         " Assume a dark background

    " Allow to trigger background
    function! ToggleBG()
        let s:tbg = &background

        " Inversion
        if s:tbg == "dark"
            set background=light
        else
            set background=dark
        endif
    endfunction
    noremap <leader>bg :call ToggleBG()<CR>

    " if !has('gui')
        "set term=$TERM          " Make arrow and other keys work
    " endif
    filetype plugin indent on   " Automatically detect file types.
    syntax on                   " Syntax highlighting
    set mouse=a                 " Automatically enable mouse usage
    set mousehide               " Hide the mouse cursor while typing
    scriptencoding utf-8

    if has('clipboard')
        if has('unnamedplus')  " When possible use + register for copy-paste
            set clipboard=unnamed,unnamedplus
        else         " On mac and Windows, use * register for copy-paste
            set clipboard=unnamed
        endif
    endif

    " Most prefer to automatically switch to the current file directory when
    " a new buffer is opened; to prevent this behavior, add the following to
    " your .vimrc.before.local file:
    "   let g:ITM_VIM_no_autochdir = 1
    if !exists('g:ITM_VIM_no_autochdir')
        autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
        " Always switch to the current file directory
    endif

    set autowrite                                   " Automatically write a file when leaving a modified buffer
    set shortmess+=filmnrxoOtT                      " Abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set virtualedit=onemore                         " Allow for cursor beyond last character
    set history=1000                                " Store a ton of history (default is 20)
    set nospell                                     " Spell checking on
    set hidden                                      " Allow buffer switching without saving
    set iskeyword-=.                                " '.' is an end of word designator
    set iskeyword-=#                                " '#' is an end of word designator
    set iskeyword-=-                                " '-' is an end of word designator

    " Instead of reverting the cursor to the last position in the buffer, we
    " set it to the first line when editing a git commit message
    au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

    " http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
    " Restore cursor to file position in previous editing session
    " To disable this, add the following to your .vimrc.before.local file:
    "   let g:ITM_VIM_no_restore_cursor = 1
    if !exists('g:ITM_VIM_no_restore_cursor')
        function! ResCur()
            if line("'\"") <= line("$")
                silent! normal! g`"
                return 1
            endif
        endfunction

        augroup resCur
            autocmd!
            autocmd BufWinEnter * call ResCur()
        augroup END
    endif

    " Setting up the directories {
        set backup                  " Backups are nice ...
        if has('persistent_undo')
            set undofile                " So is persistent undo ...
            set undolevels=1000         " Maximum number of changes that can be undone
            set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
        endif

        " To disable views add the following to your .vimrc.before.local file:
        "   let g:ITM_VIM_no_views = 1
        if !exists('g:ITM_VIM_no_views')
            " Add exclusions to mkview and loadview
            " eg: *.*, svn-commit.tmp
            let g:skipview_files = [
                \ '\[example pattern\]'
                \ ]
        endif
    " }
" }


" Vim UI {
    if !exists('g:override_ITM_VIM_plugins') && filereadable(expand("~/.vim/plugin/vim-colors-solarized/colors/solarized.vim"))
        let g:solarized_termcolors=256
        let g:solarized_termtrans=1
        let g:solarized_contrast="normal"
        let g:solarized_visibility="normal"
        "color solarized             " Load a colorscheme
        "color bubblegum
        "color bubblegum-256-dark
        "color Tomorrow-Night-Eighties
        "color Tomorrow
    endif

    set tabpagemax=15               " Only show 15 tabs
    set showmode                    " Display the current mode

    set cursorline                  " Highlight current line

    highlight clear SignColumn      " SignColumn should match background
    highlight clear LineNr          " Current line number row will have same background color in relative mode
    "highlight clear CursorLineNr    " Remove highlight color from current line number

    if has('cmdline_info')
        set ruler                   " Show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
        set showcmd                 " Show partial commands in status line and
                                    " Selected characters/lines in visual mode
    endif

    if has('statusline')
        set laststatus=2

        " Broken down into easily includeable segments
        set statusline=%<%f\                     " Filename
        set statusline+=%w%h%m%r                 " Options
        if !exists('g:override_ITM_VIM_plugins')
            set statusline+=%{fugitive#statusline()} " Git Hotness
        endif
        set statusline+=\ [%{&ff}/%Y]            " Filetype
        set statusline+=\ [%{getcwd()}]          " Current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

    set backspace=indent,eol,start                  " Backspace for dummies
    set linespace=0                                 " No extra spaces between rows
    set number                                      " Line numbers on
    set relativenumber                              " Line relative numbers on
    set showmatch                                   " Show matching brackets/parenthesis
    set incsearch                                   " Find as you type search
    set hlsearch                                    " Highlight search terms
    set winminheight=0                              " Windows can be 0 line high
    set ignorecase                                  " Case insensitive search
    set smartcase                                   " Case sensitive when uc present
    set wildmenu                                    " Show list instead of just completing
    set wildmode=list:longest,full                  " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]                   " Backspace and cursor keys wrap too
    set scrolljump=5                                " Lines to scroll when cursor leaves screen
    set scrolloff=3                                 " Minimum lines to keep above and below cursor
    set autoread                                    " Auto-reloading a file in ViM as soon as it changes on disk
    set foldenable                                  " Auto fold code
    set foldmethod=indent                           " Fold method
    setlocal foldmethod=indent
    "set foldmethod=syntax                           " Fold method
    set list
    set listchars=tab:›\ ,trail:•,extends:#,nbsp:.  " Highlight problematic whitespace
" }


" Formatting {
    "set nowrap                      " Do not wrap long lines
    set wrap
    set textwidth=79
    set wrapmargin=79
    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=4                " Use indents of 4 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=4                   " An indentation every four columns
    set softtabstop=4               " Let backspace delete indent
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
    set splitright                  " Puts new vsplit windows to the right of the current
    set splitbelow                  " Puts new split windows to the bottom of the current
    set matchpairs+=<:>             " Match, to be used with %
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
    set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks

    " Remove trailing whitespaces and ^M chars
    " To disable the stripping of whitespace, add the following to your
    " .vimrc.before.local file:
    "   let g:ITM_VIM_keep_trailing_whitespace = 1
    autocmd FileType c,cpp,java,go,php,javascript,puppet,rust,twig,xml,yml,perl,sql autocmd BufWritePre <buffer> if !exists('g:ITM_VIM_keep_trailing_whitespace') | call StripTrailingWhitespace() | endif
    "autocmd FileType go autocmd BufWritePre <buffer> Fmt
    autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
    autocmd FileType haskell,puppet,ruby,yml setlocal expandtab shiftwidth=2 softtabstop=2
    " preceding line best in a plugin but here for now.

    autocmd BufNewFile,BufRead *.coffee set filetype=coffee

    " Workaround vim-commentary for Haskell
    autocmd FileType haskell setlocal commentstring=--\ %s
    " Workaround broken colour highlighting in Haskell
    autocmd FileType haskell,rust setlocal nospell
" }


" Key (re)Mappings {
    " The default leader is '\', but many people prefer ',' as it's in a standard
    " location. To override this behavior and set it back to '\' (or any other
    " character) add the following to your .vimrc.before.local file:
    "   let g:ITM_VIM_leader='\'
    if !exists('g:ITM_VIM_leader')
        let mapleader = ','
    else
        let mapleader=g:ITM_VIM_leader
    endif
    if !exists('g:ITM_VIM_localleader')
        let maplocalleader = '_'
    else
        let maplocalleader=g:ITM_VIM_localleader
    endif

    " The default mappings for editing and applying the ITM_VIM configuration
    " are <leader>ev and <leader>sv respectively. Change them to your preference
    " by adding the following to your .vimrc.before.local file:
    "   let g:ITM_VIM_edit_config_mapping='<leader>ec'
    "   let g:ITM_VIM_apply_config_mapping='<leader>sc'
    if !exists('g:ITM_VIM_edit_config_mapping')
        let s:ITM_VIM_edit_config_mapping = '<leader>ev'
    else
        let s:ITM_VIM_edit_config_mapping = g:ITM_VIM_edit_config_mapping
    endif
    if !exists('g:ITM_VIM_apply_config_mapping')
        let s:ITM_VIM_apply_config_mapping = '<leader>sv'
    else
        let s:ITM_VIM_apply_config_mapping = g:ITM_VIM_apply_config_mapping
    endif

    " Easier moving in tabs and windows
    " The lines conflict with the default digraph mapping of <C-K>
    " If you prefer that functionality, add the following to your
    " .vimrc.before.local file:
    "   let g:ITM_VIM_no_easyWindows = 1
    if !exists('g:ITM_VIM_no_easyWindows')
        map <C-J> <C-W>j<C-W>
        map <C-K> <C-W>k<C-W>
        map <C-L> <C-W>l<C-W>
        map <C-H> <C-W>h<C-W>
    endif

    " Wrapped lines goes down/up to next row, rather than next line in file.
    noremap j gj
    noremap k gk

    " End/Start of line motion keys act relative to row/wrap width in the
    " presence of `:set wrap`, and relative to line for `:set nowrap`.
    " Default vim behaviour is to act relative to text line in both cases
    " If you prefer the default behaviour, add the following to your
    " .vimrc.before.local file:
    "   let g:ITM_VIM_no_wrapRelMotion = 1
    if !exists('g:ITM_VIM_no_wrapRelMotion')
        " Same for 0, home, end, etc
        function! WrapRelativeMotion(key, ...)
            let vis_sel=""
            if a:0
                let vis_sel="gv"
            endif
            if &wrap
                execute "normal!" vis_sel . "g" . a:key
            else
                execute "normal!" vis_sel . a:key
            endif
        endfunction

        " Map g* keys in Normal, Operator-pending, and Visual+select
        noremap $ :call WrapRelativeMotion("$")<CR>
        noremap <End> :call WrapRelativeMotion("$")<CR>
        noremap 0 :call WrapRelativeMotion("0")<CR>
        noremap <Home> :call WrapRelativeMotion("0")<CR>
        noremap ^ :call WrapRelativeMotion("^")<CR>
        " Overwrite the operator pending $/<End> mappings from above
        " to force inclusive motion with :execute normal!
        onoremap $ v:call WrapRelativeMotion("$")<CR>
        onoremap <End> v:call WrapRelativeMotion("$")<CR>
        " Overwrite the Visual+select mode mappings from above
        " to ensure the correct vis_sel flag is passed to function
        vnoremap $ :<C-U>call WrapRelativeMotion("$", 1)<CR>
        vnoremap <End> :<C-U>call WrapRelativeMotion("$", 1)<CR>
        vnoremap 0 :<C-U>call WrapRelativeMotion("0", 1)<CR>
        vnoremap <Home> :<C-U>call WrapRelativeMotion("0", 1)<CR>
        vnoremap ^ :<C-U>call WrapRelativeMotion("^", 1)<CR>
    endif

    " The following two lines conflict with moving to top and
    " bottom of the screen
    " If you prefer that functionality, add the following to your
    " .vimrc.before.local file:
    "   let g:ITM_VIM_no_fastTabs = 1
    if !exists('g:ITM_VIM_no_fastTabs')
        map <S-H> gT
        map <S-L> gt
    endif

    " Stupid shift key fixes
    if !exists('g:ITM_VIM_no_keyfixes')
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
    endif

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$

    " Code folding options
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

    " Most prefer to toggle search highlighting rather than clear the current
    " search results. To clear search highlighting rather than toggle it on
    " and off, add the following to your .vimrc.before.local file:
    "   let g:ITM_VIM_clear_search_highlight = 1
    if exists('g:ITM_VIM_clear_search_highlight')
        nmap <silent> <leader>/ :nohlsearch<CR>
    else
        nmap <silent> <leader>/ :set invhlsearch<CR>
    endif


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

    " Adjust viewports to the same size
    map <Leader>= <C-w>=

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
" }


" GUI Settings {
    " GVIM- (here instead of .gvimrc)
    if has('gui_running')
        set guioptions-=T           " Remove the toolbar
        set lines=40                " 40 lines of text instead of 24
        if !exists("g:ITM_VIM_no_big_font")
            if LINUX() && has("gui_running")
                set guifont=Andale\ Mono\ Regular\ 12,Menlo\ Regular\ 11,Consolas\ Regular\ 12,Courier\ New\ Regular\ 14
            elseif OSX() && has("gui_running")
                set guifont=Andale\ Mono\ Regular:h12,Menlo\ Regular:h11,Consolas\ Regular:h12,Courier\ New\ Regular:h14
            elseif WINDOWS() && has("gui_running")
                set guifont=Andale_Mono:h10,Menlo:h10,Consolas:h10,Courier_New:h10
            endif
        endif
    else
        if &term == 'xterm' || &term == 'screen'
            set t_Co=256            " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
        endif
        "set term=builtin_ansi       " Make arrow and other keys work
    endif
" }

" Functions {
    " Initialize directories {
        "function! InitializeDirectories()
            "let parent = $HOME
            "let prefix = 'vim'
            "let dir_list = {
                        "\ 'backup': 'backupdir',
                        "\ 'views': 'viewdir',
                        "\ 'swap': 'directory' }

            "if has('persistent_undo')
                "let dir_list['undo'] = 'undodir'
            "endif

            "" To specify a different directory in which to place the vimbackup,
            "" vimviews, vimundo, and vimswap files/directories, add the following to
            "" your .vimrc.before.local file:
            ""   let g:ITM_VIM_consolidated_directory = <full path to desired directory>
            ""   eg: let g:ITM_VIM_consolidated_directory = $HOME . '/.vim/'
            "if exists('g:ITM_VIM_consolidated_directory')
                "let common_dir = g:ITM_VIM_consolidated_directory . prefix
            "else
                "let common_dir = parent . '/.' . prefix
            "endif

            "for [dirname, settingname] in items(dir_list)
                "let directory = common_dir . dirname . '/'
                "if exists("*mkdir")
                    "if !isdirectory(directory)
                        "call mkdir(directory)
                    "endif
                "endif
                "if !isdirectory(directory)
                    "echo "Warning: Unable to create backup directory: " . directory
                    "echo "Try: mkdir -p " . directory
                "else
                    "let directory = substitute(directory, " ", "\\\\ ", "g")
                    "exec "set " . settingname . "=" . directory
                "endif
            "endfor
        "endfunction
        "call InitializeDirectories()
    " }

    " }

    " Strip whitespace {
    function! StripTrailingWhitespace()
        " Preparation: save last search, and cursor position.
        let _s=@/
        let l = line(".")
        let c = col(".")
        " do the business:
        %s/\s\+$//e
        " clean up: restore previous search history, and cursor position
        let @/=_s
        call cursor(l, c)
    endfunction
    " }

    " Shell command {
    function! s:RunShellCommand(cmdline)
        botright new

        setlocal buftype=nofile
        setlocal bufhidden=delete
        setlocal nobuflisted
        setlocal noswapfile
        "setlocal nowrap
        setlocal filetype=shell
        setlocal syntax=shell

        call setline(1, a:cmdline)
        call setline(2, substitute(a:cmdline, '.', '=', 'g'))
        execute 'silent $read !' . escape(a:cmdline, '%#')
        setlocal nomodifiable
        1
    endfunction

    command! -complete=file -nargs=+ Shell call s:RunShellCommand(<q-args>)
    " e.g. Grep current file for <search_term>: Shell grep -Hn <search_term> %
    " }

    function! s:IsSpf13Fork()
        let s:is_fork = 0
        let s:fork_files = ["~/.vimrc.fork", "~/.vimrc.before.fork", "~/.vimrc.plugins.fork"]
        for fork_file in s:fork_files
            if filereadable(expand(fork_file, ":p"))
                let s:is_fork = 1
                break
            endif
        endfor
        return s:is_fork
    endfunction

    function! s:ExpandFilenameAndExecute(command, file)
        execute a:command . " " . expand(a:file, ":p")
    endfunction

    function! s:EditSpf13Config()
        call <SID>ExpandFilenameAndExecute("tabedit", "~/.vimrc")
        call <SID>ExpandFilenameAndExecute("vsplit", "~/.vimrc.before")
        call <SID>ExpandFilenameAndExecute("vsplit", "~/.vimrc.plugins")

        execute bufwinnr(".vimrc") . "wincmd w"
        call <SID>ExpandFilenameAndExecute("split", "~/.vimrc.local")
        wincmd l
        call <SID>ExpandFilenameAndExecute("split", "~/.vimrc.before.local")
        wincmd l
        call <SID>ExpandFilenameAndExecute("split", "~/.vimrc.plugins.local")

        if <SID>IsSpf13Fork()
            execute bufwinnr(".vimrc") . "wincmd w"
            call <SID>ExpandFilenameAndExecute("split", "~/.vimrc.fork")
            wincmd l
            call <SID>ExpandFilenameAndExecute("split", "~/.vimrc.before.fork")
            wincmd l
            call <SID>ExpandFilenameAndExecute("split", "~/.vimrc.plugins.fork")
        endif

        execute bufwinnr(".vimrc.local") . "wincmd w"
    endfunction

    execute "noremap " . s:ITM_VIM_edit_config_mapping " :call <SID>EditSpf13Config()<CR>"
    execute "noremap " . s:ITM_VIM_apply_config_mapping . " :source ~/.vimrc<CR>"
" }
