function fish_greeting
  echo "＼今日も一日がんばるぞい！／"
  # curl -s https://cdn.hinatazaka46.com/images/14/3b3/774d0334ec1fc84ab60426408d706.jpg | imgcat
  set n (random 1 27)
  imgcat $HOME/.greeting_img/$n.jpg
end
