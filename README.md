# My git hook sample

## How to use
1. Copy `.githooks` dir into your project root dir.
2. Enable hook script in `.githooks`
   - `git config --local core.hooksPath .githooks`
3. Set your name.
   - `git config --local user.name "your.name"`
4. Add execute permission to hooks and scripts
   - `chmod +x .githooks/pre-commit`
   - `chmod +x .githooks/pre-push`
   - `chmod +x .githooks/authorize.sh`
   - `chmod +x .githooks/pretest.sh`
5. Edit configure files.
6. That's all.

## Access configuration before commit/push
Edit `.githooks/commit_users.conf` or `.githooks/push_users.conf`

Sample is as follows:

```ini
# Committable users list.
# Section as branch name and option as user name.
# Branch name and user name can use wildpattern like *.

# no one commit to master
[master]

# no one commit to main
[main]

# only "root" commit to develop
[develop]
root

# everyone can commit to feature-*
[feature-*]
*

# Other branch can commit by all user.
```

## Test configuration before commit/push
Edit `.githooks/commit_pretest.conf` or `.githooks/push_pretest.conf`

Sample is as follows:

```ini
# Test on pre-commit.
# Section as branch name and options as test codes.

# test unittest, flake8, mypy when push to master
[master]
python -m unittest discover ./
flake8 ./
mypy ./

# test unittest, flake8, mypy when push to main
[main]
python -m unittest discover ./
flake8 ./
mypy ./

# test unittest, flake8, mypy when push to develop
[develop]
python -m unittest discover ./
flake8 ./
mypy ./

# test only flake8 when push to feature-*
[feature-*]
flake8 ./
```
