# Default target: generate the final report
all: output/heart_analysis.html

# Final report generation rule
output/heart_analysis.html: heart_analysis.Rmd .all_outputs
	Rscript -e "rmarkdown::render('heart_analysis.Rmd', output_file = 'output/heart_analysis.html')"


.all_outputs: output/table1.png output/scatter_plot.png output/primary_model.png output/secondary_model.png
	touch .all_outputs


output/table1.png: code/descriptive_analysis.R data/heart.csv
	Rscript code/descriptive_analysis.R && touch output/table1.png


output/scatter_plot.png: code/graphical_analysis.R data/heart.csv
	Rscript code/graphical_analysis.R && touch output/scatter_plot.png


output/primary_model.png: code/regression_analysis.R data/heart.csv
	Rscript code/regression_analysis.R && touch output/primary_model.png


output/secondary_model.png: code/regression_analysis.R data/heart.csv
	Rscript code/regression_analysis.R && touch output/secondary_model.png

install:
    Rscript -e 'if (!requireNamespace("renv", quietly = TRUE)) install.packages("renv"); renv::restore()'

.PHONY: clean
clean:
	rm -f output/*.png output/*.html .all_outputs

