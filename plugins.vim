" Plugs {
    " Deps {
        Plug 'mileszs/ack.vim'
        if executable('ag')
            let g:ackprg = 'ag --nogroup --nocolor --column --smart-case'
        elseif executable('ack-grep')
            let g:ackprg="ack-grep -H --nocolor --nogroup --column"
            Plug 'mileszs/ack.vim'
        endif
    " }

    " In your .vimrc.before.local file
    " list only the Plugin groups you will use
    if !exists('g:ITM_VIM_plugin_groups')
        let g:ITM_VIM_plugin_groups=['general', 'writing', 'youcompleteme',
                    \ 'programming', 'python', 'javascript', 'html', 'misc']
    endif

    " To override all the included plugins, add the following to your
    " .vimrc.plugins.local file:
    "   let g:override_ITM_VIM_plugins = 1
    if !exists("g:override_ITM_VIM_plugins")

    " General {
        if count(g:ITM_VIM_plugin_groups, 'general')
            Plug 'tyru/open-browser.vim'
            Plug 'mhartington/oceanic-next'
            Plug 'tmhedberg/SimpylFold'
            " Plug 'Konfekt/FastFold'
            Plug 'scrooloose/nerdtree'
            Plug 'altercation/vim-colors-solarized'
            Plug 'ITM-Vim/vim-snippets'
            Plug 'spf13/vim-colors'
            Plug 'tpope/vim-surround'
            Plug 'tpope/vim-repeat'
            Plug 'rhysd/conflict-marker.vim'
            Plug 'jiangmiao/auto-pairs'
            Plug 'alvan/vim-closetag'
            Plug 'ward/VimCompletesMe'

            "Plug 'nvim-lua/plenary.nvim'
            Plug 'folke/todo-comments.nvim'


            " Ctrlp{
                Plug 'ctrlpvim/ctrlp.vim'
                Plug 'tacahiroy/ctrlp-funky'
            "}

            Plug 'terryma/vim-multiple-cursors'
            Plug 'vim-scripts/sessionman.vim'
            Plug 'vim-scripts/matchit.zip'

            Plug 'junegunn/vim-easy-align'
            Plug 'https://github.com/junegunn/vim-github-dashboard.git'
            Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
            Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

            " --- man pages, tmux
            " ---------------------------------------------
            Plug 'jez/vim-superman'
            Plug 'christoomey/vim-tmux-navigator'


            if (has("python") || has("python3")) && exists('g:ITM_VIM_use_powerline') && !exists('g:ITM_VIM_use_old_powerline')
                Plug 'Lokaltog/powerline', {'rtp':'/powerline/bindings/vim'}
            elseif exists('g:ITM_VIM_use_powerline') && exists('g:ITM_VIM_use_old_powerline')
                Plug 'Lokaltog/vim-powerline'
            else
                Plug 'vim-airline/vim-airline'
                Plug 'vim-airline/vim-airline-themes'
            endif
            Plug 'powerline/fonts'
            Plug 'bling/vim-bufferline'
            Plug 'easymotion/vim-easymotion'
            Plug 'jistr/vim-nerdtree-tabs'
            Plug 'flazz/vim-colorschemes'
            Plug 'mbbill/undotree'
            if !exists('g:ITM_VIM_no_views')
                Plug 'vim-scripts/restore_view.vim'
            endif
            Plug 'mhinz/vim-signify'
            Plug 'tpope/vim-abolish'
            Plug 'kana/vim-textobj-user'
            Plug 'kana/vim-textobj-indent'
            Plug 'gcmt/wildfire.vim'
        endif
    " }

    " Writing {
        if count(g:ITM_VIM_plugin_groups, 'writing')
            Plug 'vim-scripts/todo-txt.vim'
            Plug 'allisonlarson/todo-vim'
            Plug 'reedes/vim-litecorrect'
            Plug 'reedes/vim-textobj-sentence'
            Plug 'reedes/vim-textobj-quote'
            Plug 'reedes/vim-wordy'
        endif
    " }

    " General Programming {
        if count(g:ITM_VIM_plugin_groups, 'programming')
            " Pick one of the checksyntax, jslint, or syntastic
            Plug 'scrooloose/syntastic'
            Plug 'skanehira/docker-compose.vim'
            Plug 'skanehira/docker.vim'
            Plug 'tpope/vim-fugitive'
            Plug 'vim-scripts/bash-support.vim'
            Plug 'mattn/webapi-vim'
            Plug 'editorconfig/editorconfig-vim'
            Plug 'mattn/gist-vim'
            Plug 'scrooloose/nerdcommenter'
            Plug 'tpope/vim-commentary'
            Plug 'godlygeek/tabular'
            Plug 'luochen1990/rainbow'
            Plug 'Yggdroot/indentLine'
            Plug 'ryanoasis/nerd-fonts'
            Plug 'airblade/vim-gitgutter'
            Plug 'osyo-manga/vim-over'

            if executable('ctags')
                Plug 'majutsushi/tagbar'
            endif
        endif
    " }

    " Snippets & AutoComplete {
        if count(g:ITM_VIM_plugin_groups, 'snipmate')
            Plug 'garbas/vim-snipmate'
            " Source support_function.vim to support vim-snippets.
            if filereadable(expand("~/.vim/plugvim-snippets/snippets/support_functions.vim"))
                source ~/.vim/plugin/vim-snippets/snippets/support_functions.vim
            endif
        elseif count(g:ITM_VIM_plugin_groups, 'youcompleteme')
            "Plug 'Valloric/YouCompleteMe'
            Plug 'ycm-core/YouCompleteMe'
            Plug 'SirVer/ultisnips'
        elseif count(g:ITM_VIM_plugin_groups, 'neocomplcache')
            "Plug 'Shougo/neocomplcache'
            Plug 'Shougo/neosnippet'
            Plug 'Shougo/neosnippet-snippets'
        elseif count(g:ITM_VIM_plugin_groups, 'neocomplete')
            Plug 'Shougo/neocomplete.vim.git'
            Plug 'Shougo/neosnippet'
            Plug 'Shougo/neosnippet-snippets'
        endif
    " }

    " PHP {
        if count(g:ITM_VIM_plugin_groups, 'php')
            Plug 'ITM_VIM/PIV'
            Plug 'beyondwords/vim-twig'
            Plug 'dsawardekar/wordpress.vim'
            Plug 'shawncplus/phpcomplete.vim'
            Plug 'arnaud-lb/vim-php-namespace'

            Plug 'tpope/vim-dispatch'
            Plug 'tpope/vim-projectionist'
            Plug 'noahfrederick/vim-laravel'
            Plug 'noahfrederick/vim-composer'
            Plug 'rafaelndev/deoplete-laravel-plugin', {'for': ['php'], 'do': 'composer install'}
        endif
    " }

    " Python {
        if count(g:ITM_VIM_plugin_groups, 'python')
            " Pick either python-mode or pyflakes & pydoc
            Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
            Plug 'vim-scripts/indentpython.vim'
            Plug 'sansyrox/vim-python-virtualenv'
            Plug 'mgedmin/python-imports.vim'
            Plug 'yssource/python.vim'
            Plug 'vim-scripts/python_match.vim'
            Plug 'vim-scripts/pythoncomplete'
            Plug 'lambdalisue/vim-django-support'
            Plug 'Coacher/vim-virtualenv'
            "Plug 'davidhalter/jedi-vim'
            Plug 'Glench/Vim-Jinja2-Syntax'
            Plug 'vim-scripts/Python-Documentation'
            Plug 'tell-k/vim-autopep8'
            Plug 'ryanoasis/vim-devicons'
            Plug 'ryanoasis/powerline-extra-symbols'
            Plug 'Xuyuanp/nerdtree-git-plugin'
            "Plug 'andviro/flake8-vim'
        endif
        " }

    " Javascript {
        if count(g:ITM_VIM_plugin_groups, 'javascript')
            Plug 'elzr/vim-json'
            Plug 'groenewege/vim-less'
            Plug 'pangloss/vim-javascript'
            Plug 'briancollins/vim-jst'
            Plug 'kchmck/vim-coffee-script'
        endif
    " }

    " Scala {
        if count(g:ITM_VIM_plugin_groups, 'scala')
            Plug 'derekwyatt/vim-scala'
            Plug 'derekwyatt/vim-sbt'
            Plug 'xptemplate'
        endif
    " }

    " Haskell {
        if count(g:ITM_VIM_plugin_groups, 'haskell')
            Plug 'travitch/hasksyn'
            Plug 'dag/vim2hs'
            Plug 'Twinside/vim-haskellConceal'
            Plug 'Twinside/vim-haskellFold'
            Plug 'lukerandall/haskellmode-vim'
            Plug 'eagletmt/neco-ghc'
            Plug 'eagletmt/ghcmod-vim'
            Plug 'Shougo/vimproc.vim'
            Plug 'adinapoli/cumino'
            Plug 'bitc/vim-hdevtools'
        endif
    " }

    " HTML {
        if count(g:ITM_VIM_plugin_groups, 'html')
            Plug 'hail2u/vim-css3-syntax'
            Plug 'vim-scripts/HTML-AutoCloseTag'
            Plug 'gorodinskiy/vim-coloresque'
            Plug 'tpope/vim-haml'
            Plug 'mattn/emmet-vim'
            Plug 'lepture/vim-jinja'
        endif
    " }

    " Ruby {
        if count(g:ITM_VIM_plugin_groups, 'ruby')
            Plug 'tpope/vim-rails'
            let g:rubycomplete_buffer_loading = 1
            "let g:rubycomplete_classes_in_global = 1
            "let g:rubycomplete_rails = 1
        endif
    " }

    " Puppet {
        if count(g:ITM_VIM_plugin_groups, 'puppet')
            Plug 'rodjek/vim-puppet'
        endif
    " }

    " Go Lang {
        if count(g:ITM_VIM_plugin_groups, 'go')
            "Plug 'Blackrush/vim-gocode'
            Plug 'fatih/vim-go'
        endif
    " }

    " Elixir {
        if count(g:ITM_VIM_plugin_groups, 'elixir')
            Plug 'elixir-lang/vim-elixir'
            Plug 'carlosgaldino/elixir-snippets'
            Plug 'mattreduce/vim-mix'
        endif
    " }

    " Misc {
        if count(g:ITM_VIM_plugin_groups, 'misc')
            Plug 'rust-lang/rust.vim'
            Plug 'tpope/vim-markdown'
            Plug 'spf13/vim-preview'
            Plug 'tpope/vim-cucumber'
            Plug 'cespare/vim-toml'
            Plug 'quentindecock/vim-cucumber-align-pipes'
            Plug 'saltstack/salt-vim'
        endif
    " }

    endif
" }

