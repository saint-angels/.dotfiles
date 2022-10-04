# Resize all images in current folder in-place to width 512, keeping the aspect ratio
convert "*.png[512x]" -set filename:base "%[basename]" "%[filename:base].png"
