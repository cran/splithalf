% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/testretest_multiverse.R
\name{testretest.multiverse}
\alias{testretest.multiverse}
\title{Multiverse of data processing decisions on test retest reliability estimates.}
\usage{
testretest.multiverse(
  data,
  specifications,
  test = "ICC2",
  outcome = "RT",
  score = "difference",
  var.participant = "subject",
  var.ACC = "correct",
  var.RT = "RT",
  var.time = "time",
  var.compare = "congruency",
  compare1 = "Congruent",
  compare2 = "Incongruent"
)
}
\arguments{
\item{data}{dataset}

\item{specifications}{list of data processing specifications}

\item{test}{test retest statistic, "ICC2", "cor", "ICC3"}

\item{outcome}{from splithalf() specifies the RT outcome - only "RT" available currently}

\item{score}{currently only "difference" scores are supported}

\item{var.participant}{= "subject",}

\item{var.ACC}{= "correct",}

\item{var.RT}{= "RT"}

\item{var.time}{codes the time variable (currently only works for 2 timepoints)}

\item{var.compare}{= "congruency" trial type used to create difference scores}

\item{compare1}{specifies the first trial type to be compared (e.g. "Congruent" trials)}

\item{compare2}{specifies the second trial type to be compared (e.g. "Incongruent" trials)}
}
\value{
Returns a multiverse object containing the reliability estimates and dataframes from all data processing specifications provided
}
\description{
This function enables the user to run a multiverse of data processing options and extract the resulting test-retest reliability estimates. The user specifies a set of data processing decisions and passes this to the function, along with specifying key variables within several "var." inputs (so that the function knows where to find your participant ids and RTs for example)
}
\details{
The (unofficial) function version name is "This function will help you pay the troll toll"
}
\examples{
\dontrun{
## see online documentation for examples
https://github.com/sdparsons/splithalf
## also see https://psyarxiv.com/y6tcz

n_participants <- 80 ## sample size
n_trials <- 120
n_blocks <- 2

sim_data_mv <- data.frame(participant_number = rep(1:n_participants,
                                                   each = n_blocks * n_trials),
                          trial_number = rep(1:n_trials,
                                             times = n_blocks * n_participants),
                          block_name = rep(c(1,2),
                                           each = n_trials,
                                           length.out = n_participants * n_trials * n_blocks),
                          trial_type = rep(c("congruent","congruent",
                                             "incongruent","incongruent"),
                                           length.out = n_participants * n_trials * n_blocks / 2),
                          RT = rnorm(n_participants * n_trials * n_blocks,
                                     500,
                                     200),
                          ACC = c(rbinom(n_participants *
                                           n_trials *
                                           n_blocks / 6,
                                         1, .5),
                                  rbinom(n_participants *
                                           n_trials *
                                           n_blocks / 6,
                                         1, .7),
                                  rbinom(n_participants *
                                           n_trials *
                                           n_blocks / 6,
                                         1, .9),
                                  rbinom(n_participants *
                                           n_trials *
                                           n_blocks / 6,
                                         1, .5),
                                  rbinom(n_participants *
                                           n_trials *
                                           n_blocks / 6,
                                         1, .7),
                                  rbinom(n_participants *
                                           n_trials *
                                           n_blocks / 6,
                                         1, .9)))

specifications <- list(
ACC_cutoff = c(0, 0.5),
RT_min           = c(0, 200),
RT_max            = c(2000, 3000),
RT_sd_cutoff      = c(0, 2),
split_by          = c("subject", "trial"),
averaging_method  = c("mean")
)

icc2 <- testretest.multiverse(data = sim_data_acc,
specifications,
test = "ICC2",
score = "difference",
var.participant = "participant_number",
var.ACC = "ACC",
var.RT = "RT",
var.time = "block_name",
var.compare = "trial_type",
compare1 = "congruent",
compare2 = "incongruent")

multiverse.plot(icc2)

}
}
