# Resize images -----------------------------------------------------------

library(magick)


imgs <- list.files(path = "E:/UNIVERSITY OF MALAYA/WIA1007Assignment/", pattern = "JPEG$", full.names = TRUE)
for (i in imgs) {
  img <- image_read(i)
  img <- image_scale(img, "120x139")
  image_write(image = img, path = i)
}


img <- image_read("E:/UNIVERSITY OF MALAYA/WIA1007Assignment/3.JPEG")
img <- image_scale(img, "120x139")
image_write(image = img, path = "E:/UNIVERSITY OF MALAYA/WIA1007Assignment/3.JPEG")
