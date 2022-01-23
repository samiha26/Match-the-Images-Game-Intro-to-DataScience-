# Resize images -----------------------------------------------------------

library(magick)


imgs <- list.files(path = "file/square images/", pattern = "JPEG$", full.names = TRUE)
for (i in imgs) {
  img <- image_read(i)
  img <- image_scale(img, "120x139")
  image_write(image = img, path = i)
}


img <- image_read("file/3.JPEG")
img <- image_scale(img, "120x139")
image_write(image = img, path = "file/3.JPEG")
