#!/usr/bin/env ruby
# working with symfony https://github.com/geoffrey/vim-symfony
# github scripts http://vim-scripts.org/vim/scripts.html
# TVO https://github.com/vim-scripts/TVO--The-Vim-Outliner.git
# Conque http://code.google.com/p/conque/

git_bundles = [ 
    "https://github.com/msanders/snipmate.vim.git",
    "https://github.com/scrooloose/nerdtree.git",
    "https://github.com/tpope/vim-fugitive.git",
    "https://github.com/tpope/vim-surround.git",
    # "https://github.com/tomtom/tcomment_vim",
    "https://github.com/scrooloose/nerdcommenter.git",
    "https://github.com/vim-ruby/vim-ruby.git",
    "https://github.com/godlygeek/tabular.git",
    "https://github.com/mattn/zencoding-vim.git",
    "https://github.com/altercation/vim-colors-solarized.git",
    #["https://github.com/vim-scripts/Command-T.git", lambda {
        #puts "** Installing Command-T..."
        #FileUtils.cd("Command-T/ruby/command-t")
        #puts FileUtils.pwd
        ## NOTE use the same ruby version as vim
        #%x(ruby extconf.rb)
        #%x(make)
        #FileUtils.cd("../../..")
    #}],
    # "https://github.com/vim-scripts/mru.vim.git",
    "https://github.com/kien/ctrlp.vim.git",
    "https://github.com/vim-scripts/matchit.zip.git",
    "https://github.com/vim-scripts/jQuery.git",
    "https://github.com/vim-scripts/L9.git",
    # "https://github.com/vim-scripts/FuzzyFinder.git",
    # "https://github.com/Shougo/neocomplcache.git",
    "https://github.com/sukima/xmledit.git",
    "https://github.com/leshill/vim-json.git",
    # "https://github.com/xolox/vim-easytags.git",
    "https://github.com/vim-scripts/phpfolding.vim.git",
    "https://github.com/sjl/gundo.vim.git",
    "https://github.com/kchmck/vim-coffee-script.git",
    "https://github.com/majutsushi/tagbar.git",
    "https://github.com/tpope/vim-cucumber.git",
    "https://github.com/pangloss/vim-javascript.git",
    "https://github.com/tpope/vim-haml.git",
    "https://github.com/cakebaker/scss-syntax.vim",
    #"https://github.com/hail2u/vim-css3-syntax.git",
    "https://github.com/groenewege/vim-less",
    "https://github.com/plasticboy/vim-markdown.git",
    "https://github.com/digitaltoad/vim-jade",
    "https://github.com/wavded/vim-stylus.git",
    "https://github.com/mileszs/ack.vim.git",
    "https://github.com/beyondwords/vim-twig.git",
    #"https://github.com/othree/html5.vim.git",
    "https://github.com/shawncplus/phpcomplete.vim.git",
    "https://github.com/veloce/vim-behat.git",
    "https://github.com/scrooloose/syntastic.git",
    "https://github.com/mattn/gist-vim.git",
    "https://github.com/2072/PHP-Indenting-for-VIm.git",
]

require 'fileutils'
require 'open-uri'

bundles_dir = File.join(File.dirname(__FILE__), "bundle")

FileUtils.cd(bundles_dir)

notrash = ARGV.include?('--notrash')

unless notrash
    puts "Trashing everything (lookout!)"
    Dir["*"].each {|d| FileUtils.rm_rf d }
end

git_bundles.each do |url, func|
    dir = url.split('/').last.sub(/\.git$/, '')
    if notrash && File.exists?(dir)
        puts "  Skipping #{dir}"
        next
    end
    puts "  Unpacking #{url} into #{dir}"
    `git clone #{url} #{dir}`
    FileUtils.rm_rf(File.join(dir, ".git"))
    func.call unless func.nil?
end

puts "pathogen#helptags()..."
`vim -e -c "call pathogen#helptags()" -c q`
