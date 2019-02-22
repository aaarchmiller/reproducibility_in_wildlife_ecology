#' # Figure 2
#' 
#' Description: Scores by journal
#' 
#' Coder name(s): Althea ArchMiller
#' 
#' 
#' _____________________________________________________________________________
#' ## Preamble
#' 
#' Load libraries
#' 
#+ library, warnings = "hide"
library(ezknitr)
library(knitr)
library(devtools)
library(ggplot2)

#' Clear environment and set seed
#' 
remove(list=ls())
set.seed(8675)

#' _____________________________________________________________________________
#' ## Load Data
#' 
#' 
load(file = "data/processed_data/averages_of_reviewed_studies.Rdata")
load(file = "data/processed_data/reviewed_studies_data.Rdata")
load(file = "data/processed_data/all_studies_data.Rdata")



#' 
#' _____________________________________________________________________________
#' ## Empty dataset to fill in for plotting
#' 
#' 
plottingdata <- as.data.frame(matrix(NA, nrow = 9, ncol = 6))
colnames(plottingdata) <- c("Score", "SE", "upper", "lower", 
                            "Category", "journal")

#' ### Fill in with reproducibility of figures scores
#' 
#' JWM
plottingdata$Score[1] <- mean(averages$graphsReproduced[averages$journal=="JWM"])
plottingdata$SE[1] <- sd(averages$graphsReproduced[averages$journal=="JWM"])/
  sqrt(length(averages$graphsReproduced[averages$journal=="JWM"]))
plottingdata$Category[1] <- "Figures Reproduced"
plottingdata$journal[1] <- "JWM"

#' WSB
plottingdata$Score[2] <- mean(averages$graphsReproduced[averages$journal=="WSB"],
                             na.rm = T)
plottingdata$SE[2] <- sd(averages$graphsReproduced[averages$journal=="WSB"],
                         na.rm = T)/
  sqrt(length(averages$graphsReproduced[averages$journal=="WSB"])-1)
plottingdata$Category[2] <- "Figures Reproduced"
plottingdata$journal[2] <- "WSB"

#' Overall
plottingdata$Score[3] <- mean(averages$graphsReproduced,
                             na.rm = T)
plottingdata$SE[3] <- sd(averages$graphsReproduced,
                         na.rm = T)/
  sqrt(length(averages$graphsReproduced)-1)
plottingdata$Category[3] <- "Figures Reproduced"
plottingdata$journal[3] <- "Overall"


#' ### Fill in with reproducibility of numbers scores
#' 
#' JWM
plottingdata$Score[4] <- mean(averages$numbersReproduced[averages$journal=="JWM"])
plottingdata$SE[4] <- sd(averages$numbersReproduced[averages$journal=="JWM"])/
  sqrt(length(averages$numbersReproduced[averages$journal=="JWM"]))
plottingdata$Category[4] <- "Numbers Reproduced"
plottingdata$journal[4] <- "JWM"

#' WSB
plottingdata$Score[5] <- mean(averages$numbersReproduced[averages$journal=="WSB"],
                             na.rm = T)
plottingdata$SE[5] <- sd(averages$numbersReproduced[averages$journal=="WSB"],
                         na.rm = T)/
  sqrt(length(averages$numbersReproduced[averages$journal=="WSB"]))
plottingdata$Category[5] <- "Numbers Reproduced"
plottingdata$journal[5] <- "WSB"

#' Overall
plottingdata$Score[6] <- mean(averages$numbersReproduced,
                             na.rm = T)
plottingdata$SE[6] <- sd(averages$numbersReproduced,
                         na.rm = T)/
  sqrt(length(averages$numbersReproduced))
plottingdata$Category[6] <- "Numbers Reproduced"
plottingdata$journal[6] <- "Overall"


#' ### Fill in with reproducibility of conclusions scores
#' 
#' JWM
plottingdata$Score[7] <- mean(averages$conclusionsReproduced[averages$journal=="JWM"])
plottingdata$SE[7] <- sd(averages$conclusionsReproduced[averages$journal=="JWM"])/
  sqrt(length(averages$conclusionsReproduced[averages$journal=="JWM"]))
plottingdata$Category[7] <- "Conclusions Reproduced"
plottingdata$journal[7] <- "JWM"

#' WSB
plottingdata$Score[8] <- mean(averages$conclusionsReproduced[averages$journal=="WSB"],
                             na.rm = T)
plottingdata$SE[8] <- sd(averages$conclusionsReproduced[averages$journal=="WSB"],
                         na.rm = T)/
  sqrt(length(averages$conclusionsReproduced[averages$journal=="WSB"]))
plottingdata$Category[8] <- "Conclusions Reproduced"
plottingdata$journal[8] <- "WSB"

#' Overall
plottingdata$Score[9] <- mean(averages$conclusionsReproduced,
                             na.rm = T)
plottingdata$SE[9] <- sd(averages$conclusionsReproduced,
                         na.rm = T)/
  sqrt(length(averages$conclusionsReproduced))
plottingdata$Category[9] <- "Conclusions Reproduced"
plottingdata$journal[9] <- "Overall"

#' ### Calculate lower and upper limits for all categories
plottingdata$upper <- plottingdata$Score + plottingdata$SE
plottingdata$lower <- plottingdata$Score - plottingdata$SE

#' _____________________________________________________________________________
#' ## Create figure
#+ figure2
ggplot(data = plottingdata, aes(x = Category, y = Score, colour = journal))+
  geom_pointrange(aes(ymin = lower, ymax = upper, shape = journal), 
                 position = position_dodge(width = 0.6))+
  ylim(1,5)


#' _____________________________________________________________________________
#' ## Footer
#' 
devtools::session_info()
#' spun with:
#' ezknitr::ezspin(file = "programs/03_scores_by_journal_figure.R", keep_md = FALSE, out_dir = "html_reports", fig_dir = "figures")