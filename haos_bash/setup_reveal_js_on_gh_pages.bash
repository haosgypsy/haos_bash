# This scripts take a new GitHub repository URL and creates a reveal.js gh-pages site.

# Use at your own risk!

function setup_reveal_js_on_gh_pages() {

:<<EOF

    remote_url=$1
    name_for_project_folder=$2
    
    git clone $remote_url $name_for_project_folder
    cd $name_for_project_folder
    mkdir pgs
    cd pgs
    git clone https://github.com/hakimel/reveal.js.git reveal_js
    cd reveal_js/
    rm -rf .git
    rm -rf test
    rm -f Gruntfile.js
    rm -f README.md
    rm -f bower.json
    rm -f package.json
    rm -f .travis.yml
    rm -f .gitignore

    cd ..
    cd ..
    
    git checkout -b gh-pages
    git add .
    git commit -m "Used script to add reveal js to new pgs directory."
    git push --all   
    git push -u origin gh-pages
EOF
}

function say_goodbye() {
    
    echo ""
    echo "Everything should be setup and ready to go!"
    echo ""

    local cloned_url="$1"

    local repos_url_at_github=${cloned_url%".git"}
    
    local git_hub_user_name="$1"
    git_hub_user_name=${git_hub_user_name/"https://github.com/"/""}
    git_hub_user_name=${git_hub_user_name%/*}
    
    local repos_name="$1" 
    repos_name=${repos_name%".git"} 
    repos_name=${repos_name#"https://github.com/"} 
    repos_name=${repos_name#"$git_hub_user_name/"} 
    
    local gh_pages_url="$1"
   
    gh_pages_url="http://$git_hub_user_name.github.io/$repos_name"
    
    echo "The repo's URL at GitHub is : $repos_url_at_github"
    echo "The GH-Pages root URL is : $gh_pages_url"
    echo "The index for your pages can be found at : $gh_pages_url/pgs/index.html"
    echo "The main index for the reveal.js slides can be found at : $gh_pages_url/pgs/reveal_js/index.html"
    echo "An intro to reveal.js can be found at : $gh_pages_url/pgs/reveal_js/demo.html"
    echo ""
    :<<EOF
    # the ever present ToDo items...
EOF
    read -n1 -r -p "Press any key to continue." not_used_key
    echo ""
    echo ""
    echo ""
    
    exit
}

function prompt_user_for_info_to_create_new_gh_pages_repo_with_reveal_js_at_github() {
    echo "Hi! This script has been created and tested to work with a URL for a new empty GitHub repository."
    echo "1 * Visit this URL : https://github.com/new"
    echo "Create a new repository and copy the repositories URL to your clipboard."
    echo "You can do that now, i'll wait here."
    
    read -p "Enter the GitHub repository : " repo_to_put_reveal_in
    read -p "Enter the GitHub repository : " name_for_repos_folder
    
:<<EOF
    
    setup_reveal_js_on_gh_pages "$repo_to_put_reveal_in" "$name_for_repos_folder"
    
    cd $GOPATH
    cd $name_for_repos_folder
    bash ../z_spring_2016_bash_toolset/haos_bash/append_the_basics_to_the_readme_file.bash 
    clear
EOF
    echo ""
    cd $GOPATH
    say_goodbye "$repo_to_put_reveal_in" "$name_for_repos_folder"
}

cd $GOPATH
#prompt_user_for_info_to_create_new_gh_pages_repo_with_reveal_js_at_github


if [[ ( -z "$1" ) && ( -z "$2" ) ]]
then
    prompt_user_for_info_to_create_new_gh_pages_repo_with_reveal_js_at_github
else
    setup_reveal_js_on_gh_pages "$1" "$2"
fi

say_goodbye "$1" "$2"

:<<EOF
EOF

# WISHLIST : Have it create a html file linking to all the decks.