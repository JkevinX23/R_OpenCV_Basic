library(opencv)
library(ggplot2)

test <- ocv_picture()
bitmap <- ocv_bitmap(test)
width <- dim(bitmap)[2]
heigth <- dim(bitmap)[3]

png('bg.png', width = width, height = heigth)
par(ask = FALSE)
print(ggplot2::qplot(speed,dist,data = cars, geom =c("smooth", "point")))
dev.off()
bg <- ocv_read('bg.png')
unlink('pg.png')
ocv_video(function(input){
  mask <- ocv_mog2(input)
  return (ocv_copyto(input,bg,mask))
})

# Overlay face filter
ocv_video(function(input){
  mask <- ocv_facemask(input)
  ocv_copyto(input, bg, mask)
})
