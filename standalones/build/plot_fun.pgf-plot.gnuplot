set table "plot_fun.pgf-plot.table"; set format "%.5f"
set format "%.7e";; set contour base; set cntrparam levels discrete 0; unset surface; set view map; set isosamples 1000; splot sin(y**2) + x**2/3 - 1; 
