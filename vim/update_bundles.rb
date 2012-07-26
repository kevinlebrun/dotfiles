#!/usr/bin/env ruby

git_bundles = [
    # snipmate and dependencies
    "https://github.com/tomtom/tlib_vim.git",
    "https://github.com/MarcWeber/vim-addon-mw-utils.git",
    "https://github.com/honza/snipmate-snippets.git",
    "https://github.com/garbas/vim-snipmate.git",
    "https://github.com/scrooloose/nerdtree.git",
    "https://github.com/tpope/vim-fugitive.git",
    "https://github.com/tpope/vim-surround.git",
    "https://github.com/scrooloose/nerdcommenter.git",
    "https://github.com/vim-ruby/vim-ruby.git",
    "https://github.com/godlygeek/tabular.git",
    "https://github.com/mattn/zencoding-vim.git",
    #"https://github.com/altercation/vim-colors-solarized.git",
    "https://github.com/kien/ctrlp.vim.git",
    "https://github.com/vim-scripts/matchit.zip.git",
    "https://github.com/vim-scripts/L9.git",
    "https://github.com/sukima/xmledit.git",
    "https://github.com/leshill/vim-json.git",
    #"https://github.com/sjl/gundo.vim.git",
    "https://github.com/kchmck/vim-coffee-script.git",
    "https://github.com/majutsushi/tagbar.git",
    "https://github.com/tpope/vim-cucumber.git",
    "https://github.com/pangloss/vim-javascript.git",
    "https://github.com/tpope/vim-haml.git",
    "https://github.com/cakebaker/scss-syntax.vim",
    "https://github.com/groenewege/vim-less",
    "https://github.com/plasticboy/vim-markdown.git",
    "https://github.com/digitaltoad/vim-jade",
    "https://github.com/wavded/vim-stylus.git",
    "https://github.com/mileszs/ack.vim.git",
    "https://github.com/beyondwords/vim-twig.git",
    #"https://github.com/shawncplus/phpcomplete.vim.git",
    "https://github.com/veloce/vim-behat.git",
    #"https://github.com/scrooloose/syntastic.git",
    "https://github.com/mattn/webapi-vim.git",
    "https://github.com/mattn/gist-vim.git",
    "https://github.com/Lokaltog/vim-powerline.git",
    #"https://github.com/alfredodeza/jacinto.vim.git",
    #"https://github.com/zaiste/tmux.vim.git",
    "https://github.com/kight/CSS3-syntax-file-for-vim.git",
    "https://github.com/Lokaltog/vim-easymotion.git",
    "https://github.com/chrisbra/NrrwRgn.git",
    "https://github.com/sjl/clam.vim.git",
    #"https://github.com/jpalardy/vim-slime.git",
    #"https://github.com/benmills/vimux.git",
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
