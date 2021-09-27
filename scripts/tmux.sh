
#!/bin/bash

# 1. First you check if a tmux session exists with a given name.
tmux has-session -t=$1 2> /dev/null

# 2. Create the session if it doesn't exists.
if [[ $? -ne 0 ]]; then
  TMUX='' tmux new-session -d -s "$1"
fi

# 3. Attach if outside of tmux, switch if you're in tmux.
if [[ -z "$TMUX" ]]; then
  tmux attach -t "$1"
else
  tmux switch-client -t "$1"
fi

