if [! -f 'bin/act']; then
  curl https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash
fi

bin/act -j test-reusable-workflow