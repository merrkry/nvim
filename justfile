cleanup:
  trash-put ~/.local/state/nvim
  trash-put ~/.local/share/nvim
  trash-put ~/.cache/nvim

sync:
  git pull --autostash
  nvim --headless "+Lazy! restore" +qa
