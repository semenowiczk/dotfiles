# Prompting.
# Print a carriage return just before printing a prompt in the line editor.
setopt PROMPT_CR
# Attempt to preserve a partial line (i.e. a line that did not end with a newline)
# that would otherwise be covered up by the command prompt due to the PROMPT_CR option.
setopt PROMPT_SP

# History.
# adds commands as they are typed, not at shell exit
setopt INC_APPEND_HISTORY
# share history across multiple zsh sessions
setopt SHARE_HISTORY

# Directory.
# Make cd push the old directory onto the directory stack.
setopt AUTO_PUSHD
# Don’t push multiple copies of the same directory onto the directory stack.
setopt PUSHD_IGNORE_DUPS
# Exchanges the meanings of ‘+’ and ‘-’ when used with a number to specify a directory in the stack.
setopt PUSHD_MINUS
