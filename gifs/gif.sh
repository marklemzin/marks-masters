#Shell for creating gifs

ffmpeg -framerate 2 -pattern_type glob -i '*.jpg' out.gif