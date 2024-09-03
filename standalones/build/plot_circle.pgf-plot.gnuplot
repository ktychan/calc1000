set table "plot_circle.pgf-plot.table"; set format "%.5f"
set format "%.7e";; set contour base; set cntrparam levels discrete 0; unset surface; set view map; set isosamples 1000; splot x**2 + y**2 - 25; 
