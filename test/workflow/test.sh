if [ ! -f "bin/act" ]; then
    curl https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash
    export PATH=$PATH:/root/bin
fi

bin/act -j test-reusable-workflow -P medium=ubuntu-latest -s USER_EMAIL="test@example.com" -s USER_NAME="Test Actions"