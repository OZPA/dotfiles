function fish_greeting
  set n (random 1 32)
  imgcat $HOME/.greeting_img/$n.jpg
end
