#!/usr/bin/env ruby

git_bundles = [
    "https://github.com/scrooloose/nerdtree.git",
    "https://github.com/altercation/vim-colors-solarized.git",
    "https://github.com/kien/ctrlp.vim.git",
    "https://github.com/godlygeek/tabular.git",
    "https://github.com/mileszs/ack.vim.git",
    "https://github.com/plasticboy/vim-markdown.git",
    "https://github.com/Lokaltog/powerline.git",
    "https://github.com/rodjek/vim-puppet.git",
    "https://github.com/airblade/vim-gitgutter.git",
    "https://github.com/tpope/vim-git.git",
    "https://github.com/tomtom/tcomment_vim.git",
    "https://github.com/vim-scripts/matchit.zip.git",
    "https://github.com/leshill/vim-json.git",
    "https://github.com/pangloss/vim-javascript.git",
    "https://github.com/hail2u/vim-css3-syntax.git",
    "https://github.com/groenewege/vim-less",
    "https://github.com/othree/html5.vim",
    "https://github.com/StanAngeloff/php.vim",

    "https://github.com/tpope/vim-repeat.git",
    "https://github.com/tpope/vim-surround.git",

    "https://github.com/sjl/clam.vim.git",
    "https://github.com/tpope/vim-eunuch.git",

    "https://github.com/mattn/webapi-vim.git",
    "https://github.com/mattn/gist-vim.git",

    "https://github.com/tpope/vim-tbone.git",
    "https://github.com/tpope/vim-fugitive.git",
    "https://github.com/walm/jshint.vim.git",
    "https://github.com/mattn/zencoding-vim.git",
    "https://github.com/robmiller/vim-movar.git",

    #"https://github.com/shawncplus/phpcomplete.vim.git",
    #"https://github.com/majutsushi/tagbar.git",

    "https://github.com/kchmck/vim-coffee-script.git",
    "https://github.com/evidens/vim-twig.git",
    "https://github.com/veloce/vim-behat.git",

    "https://github.com/vim-ruby/vim-ruby.git",
    "https://github.com/tpope/vim-cucumber.git",

    #"https://github.com/msanders/snipmate.vim.git",
    #"https://github.com/tpope/vim-haml.git",
    #"https://github.com/cakebaker/scss-syntax.vim",
    #"https://github.com/wavded/vim-stylus.git",
    #"https://github.com/digitaltoad/vim-jade",
    #"https://github.com/scrooloose/nerdcommenter.git",
]

hg_bundles = [
    #"https://bitbucket.org/ludovicchabant/vim-lawrencium",
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

hg_bundles.each do |url, func|
    dir = url.split('/').last.sub(/\.hg$/, '')
    if notrash && File.exists?(dir)
        puts "  Skipping #{dir}"
        next
    end
    puts "  Unpacking #{url} into #{dir}"
    `hg clone #{url} #{dir}`
    FileUtils.rm_rf(File.join(dir, ".hg"))
    func.call unless func.nil?
end

puts "pathogen#helptags()..."
`vim -e -c "call pathogen#helptags()" -c q`
