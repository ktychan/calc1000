set table "plot_rounded_square.pgf-plot.table"; set format "%.5f"
set format "%.7e";; set contour base; set cntrparam levels discrete 0; unset surface; set view map; set isosamples 1000; splot x**4 + y**4 - 5**4; 
