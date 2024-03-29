## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
knitr::opts_chunk$set(echo = TRUE)
knitr::opts_chunk$set(message = FALSE)
knitr::opts_chunk$set(warning = FALSE)
knitr::opts_chunk$set(results = "hide")
knitr::opts_chunk$set(fig.dim = c(6,4))




## ----setup--------------------------------------------------------------------
library("splithalf")
library("tidyr")


## ----generate_data------------------------------------------------------------
# Thanks to Nathaniel Haines for the suggestion and the starting code (https://github.com/sdparsons/splithalf/issues/9). 

set.seed(01042021)

n_participants <- 60 ## sample size
n_trials <- 80
n_blocks <- 2

sim_data <- data.frame(participant_number = rep(1:n_participants, 
                                                each = n_blocks * n_trials),
                       trial_number = rep(1:n_trials, 
                                          times = n_blocks * n_participants),
                       block_name = rep(c("A","B"), 
                                        each = n_trials, 
                                        length.out = n_participants * n_trials * n_blocks),
                       trial_type = rep(c("congruent","congruent",
                                          "incongruent","incongruent"),
                                        length.out = n_participants * n_trials * n_blocks / 2),
                       RT = rnorm(n_participants * n_trials * n_blocks, 
                                  500, 
                                  200),
                       ACC = 1)

sim_data_acc <- data.frame(participant_number = rep(1:n_participants, 
                                                    each = n_blocks * n_trials),
                       trial_number = rep(1:n_trials, 
                                          times = n_blocks * n_participants),
                       block_name = rep(c("A","B"), 
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





## ----test_setup---------------------------------------------------------------
params <- list(score = c("average",
                         "difference",
                         "difference_of_difference"),
               halftype = c("oddeven",
                            "halfs",
                            "random"),
               averae = c("mean",
                          "median") )

expand.grid(params) %>%
  dplyr::arrange(., score, halftype)


## ----rt_test1-----------------------------------------------------------------
splithalf(data = sim_data,
          outcome = "RT",
          score = "average",
          conditionlist = c("A", "B"),
          halftype = "oddeven",
          permutations = 500,
          var.RT = "RT",
          var.condition = "block_name",
          var.participant = "participant_number",
          var.compare = "trial_type",
          compare1 = "congruent",
          compare2 = "incongruent",
          average = "mean")

## ----rt_test2-----------------------------------------------------------------
splithalf(data = sim_data,
          outcome = "RT",
          score = "average",
          conditionlist = c("A", "B"),
          halftype = "oddeven",
          permutations = 500,
          var.RT = "RT",
          var.condition = "block_name",
          var.participant = "participant_number",
          var.compare = "trial_type",
          compare1 = "congruent",
          compare2 = "incongruent",
          average = "median")

## ----rt_test3-----------------------------------------------------------------
splithalf(data = sim_data,
          outcome = "RT",
          score = "average",
          conditionlist = c("A", "B"),
          halftype = "halfs",
          permutations = 500,
          var.RT = "RT",
          var.condition = "block_name",
          var.participant = "participant_number",
          var.compare = "trial_type",
          compare1 = "congruent",
          compare2 = "incongruent",
          average = "mean")

## ----rt_test4-----------------------------------------------------------------
splithalf(data = sim_data,
          outcome = "RT",
          score = "average",
          conditionlist = c("A", "B"),
          halftype = "halfs",
          permutations = 500,
          var.RT = "RT",
          var.condition = "block_name",
          var.participant = "participant_number",
          var.compare = "trial_type",
          compare1 = "congruent",
          compare2 = "incongruent",
          average = "median")

## ----rt_test5-----------------------------------------------------------------
splithalf(data = sim_data,
          outcome = "RT",
          score = "average",
          conditionlist = c("A", "B"),
          halftype = "random",
          permutations = 500,
          var.RT = "RT",
          var.condition = "block_name",
          var.participant = "participant_number",
          var.compare = "trial_type",
          compare1 = "congruent",
          compare2 = "incongruent",
          average = "mean",
          plot = TRUE)

## ----rt_test6-----------------------------------------------------------------
splithalf(data = sim_data,
          outcome = "RT",
          score = "average",
          conditionlist = c("A", "B"),
          halftype = "random",
          permutations = 500,
          var.RT = "RT",
          var.condition = "block_name",
          var.participant = "participant_number",
          var.compare = "trial_type",
          compare1 = "congruent",
          compare2 = "incongruent",
          average = "median",
          plot = TRUE)

## ----rt_test7-----------------------------------------------------------------
splithalf(data = sim_data,
          outcome = "RT",
          score = "difference",
          conditionlist = c("A", "B"),
          halftype = "oddeven",
          permutations = 500,
          var.RT = "RT",
          var.condition = "block_name",
          var.participant = "participant_number",
          var.compare = "trial_type",
          compare1 = "congruent",
          compare2 = "incongruent",
          average = "mean")

## ----rt_test8-----------------------------------------------------------------
splithalf(data = sim_data,
          outcome = "RT",
          score = "difference",
          conditionlist = c("A", "B"),
          halftype = "oddeven",
          permutations = 500,
          var.RT = "RT",
          var.condition = "block_name",
          var.participant = "participant_number",
          var.compare = "trial_type",
          compare1 = "congruent",
          compare2 = "incongruent",
          average = "median")

## ----rt_test9-----------------------------------------------------------------
splithalf(data = sim_data,
          outcome = "RT",
          score = "difference",
          conditionlist = c("A", "B"),
          halftype = "halfs",
          permutations = 500,
          var.RT = "RT",
          var.condition = "block_name",
          var.participant = "participant_number",
          var.compare = "trial_type",
          compare1 = "congruent",
          compare2 = "incongruent",
          average = "mean")

## ----rt_test10----------------------------------------------------------------
splithalf(data = sim_data,
          outcome = "RT",
          score = "difference",
          conditionlist = c("A", "B"),
          halftype = "halfs",
          permutations = 500,
          var.RT = "RT",
          var.condition = "block_name",
          var.participant = "participant_number",
          var.compare = "trial_type",
          compare1 = "congruent",
          compare2 = "incongruent",
          average = "median")

## ----rt_test11----------------------------------------------------------------
splithalf(data = sim_data,
          outcome = "RT",
          score = "difference",
          conditionlist = c("A", "B"),
          halftype = "random",
          permutations = 500,
          var.RT = "RT",
          var.condition = "block_name",
          var.participant = "participant_number",
          var.compare = "trial_type",
          compare1 = "congruent",
          compare2 = "incongruent",
          average = "mean",
          plot = TRUE)

## ----rt_test12----------------------------------------------------------------
splithalf(data = sim_data,
          outcome = "RT",
          score = "difference",
          conditionlist = c("A", "B"),
          halftype = "random",
          permutations = 500,
          var.RT = "RT",
          var.condition = "block_name",
          var.participant = "participant_number",
          var.compare = "trial_type",
          compare1 = "congruent",
          compare2 = "incongruent",
          average = "median",
          plot = TRUE)

## ----rt_test13----------------------------------------------------------------
splithalf(data = sim_data,
          outcome = "RT",
          score = "difference_of_difference",
          conditionlist = c("A", "B"),
          halftype = "oddeven",
          permutations = 500,
          var.RT = "RT",
          var.condition = "block_name",
          var.participant = "participant_number",
          var.compare = "trial_type",
          compare1 = "congruent",
          compare2 = "incongruent",
          average = "mean")

## ----rt_test14----------------------------------------------------------------
splithalf(data = sim_data,
          outcome = "RT",
          score = "difference_of_difference",
          conditionlist = c("A", "B"),
          halftype = "oddeven",
          permutations = 500,
          var.RT = "RT",
          var.condition = "block_name",
          var.participant = "participant_number",
          var.compare = "trial_type",
          compare1 = "congruent",
          compare2 = "incongruent",
          average = "median")

## ----rt_test15----------------------------------------------------------------
splithalf(data = sim_data,
          outcome = "RT",
          score = "difference_of_difference",
          conditionlist = c("A", "B"),
          halftype = "halfs",
          permutations = 500,
          var.RT = "RT",
          var.condition = "block_name",
          var.participant = "participant_number",
          var.compare = "trial_type",
          compare1 = "congruent",
          compare2 = "incongruent",
          average = "mean")

## ----rt_test16----------------------------------------------------------------
splithalf(data = sim_data,
          outcome = "RT",
          score = "difference_of_difference",
          conditionlist = c("A", "B"),
          halftype = "halfs",
          permutations = 500,
          var.RT = "RT",
          var.condition = "block_name",
          var.participant = "participant_number",
          var.compare = "trial_type",
          compare1 = "congruent",
          compare2 = "incongruent",
          average = "median")

## ----rt_test17----------------------------------------------------------------
splithalf(data = sim_data,
          outcome = "RT",
          score = "difference_of_difference",
          conditionlist = c("A", "B"),
          halftype = "random",
          permutations = 500,
          var.RT = "RT",
          var.condition = "block_name",
          var.participant = "participant_number",
          var.compare = "trial_type",
          compare1 = "congruent",
          compare2 = "incongruent",
          average = "mean",
          plot = TRUE)

## ----rt_test18----------------------------------------------------------------
splithalf(data = sim_data,
          outcome = "RT",
          score = "difference_of_difference",
          conditionlist = c("A", "B"),
          halftype = "random",
          permutations = 500,
          var.RT = "RT",
          var.condition = "block_name",
          var.participant = "participant_number",
          var.compare = "trial_type",
          compare1 = "congruent",
          compare2 = "incongruent",
          average = "median",
          plot = TRUE)

## ----acc_test1----------------------------------------------------------------
splithalf(data = sim_data_acc,
          outcome = "accuracy",
          score = "average",
          conditionlist = c("A", "B"),
          halftype = "oddeven",
          permutations = 500,
          var.RT = "RT",
          var.condition = "block_name",
          var.participant = "participant_number",
          var.compare = "trial_type",
          var.ACC = "ACC",
          compare1 = "congruent",
          compare2 = "incongruent",
          average = "mean")

## ----acc_test2----------------------------------------------------------------
splithalf(data = sim_data_acc,
          outcome = "accuracy",
          score = "average",
          conditionlist = c("A", "B"),
          halftype = "oddeven",
          permutations = 500,
          var.RT = "RT",
          var.condition = "block_name",
          var.participant = "participant_number",
          var.compare = "trial_type",
          var.ACC = "ACC",
          
          compare1 = "congruent",
          compare2 = "incongruent",
          average = "median")

## ----acc_test3----------------------------------------------------------------
splithalf(data = sim_data_acc,
          outcome = "accuracy",
          score = "average",
          conditionlist = c("A", "B"),
          halftype = "halfs",
          permutations = 500,
          var.RT = "RT",
          var.condition = "block_name",
          var.participant = "participant_number",
          var.compare = "trial_type",
          var.ACC = "ACC",
          compare1 = "congruent",
          compare2 = "incongruent",
          average = "mean")

## ----acc_test4----------------------------------------------------------------
splithalf(data = sim_data_acc,
          outcome = "accuracy",
          score = "average",
          conditionlist = c("A", "B"),
          halftype = "halfs",
          permutations = 500,
          var.RT = "RT",
          var.condition = "block_name",
          var.participant = "participant_number",
          var.compare = "trial_type",
          var.ACC = "ACC",
          compare1 = "congruent",
          compare2 = "incongruent",
          average = "median")

## ----acc_test5----------------------------------------------------------------
splithalf(data = sim_data_acc,
          outcome = "accuracy",
          score = "average",
          conditionlist = c("A", "B"),
          halftype = "random",
          permutations = 500,
          var.RT = "RT",
          var.condition = "block_name",
          var.participant = "participant_number",
          var.compare = "trial_type",
          var.ACC = "ACC",
          compare1 = "congruent",
          compare2 = "incongruent",
          average = "mean",
          plot = TRUE)

## ----acc_test6----------------------------------------------------------------
splithalf(data = sim_data_acc,
          outcome = "accuracy",
          score = "average",
          conditionlist = c("A", "B"),
          halftype = "random",
          permutations = 500,
          var.RT = "RT",
          var.condition = "block_name",
          var.participant = "participant_number",
          var.compare = "trial_type",
          var.ACC = "ACC",
          compare1 = "congruent",
          compare2 = "incongruent",
          average = "median",
          plot = TRUE)

## ----acc_test7----------------------------------------------------------------
splithalf(data = sim_data_acc,
          outcome = "accuracy",
          score = "difference",
          conditionlist = c("A", "B"),
          halftype = "oddeven",
          permutations = 500,
          var.RT = "RT",
          var.condition = "block_name",
          var.participant = "participant_number",
          var.compare = "trial_type",
          var.ACC = "ACC",
          compare1 = "congruent",
          compare2 = "incongruent",
          average = "mean")

## ----acc_test8----------------------------------------------------------------
splithalf(data = sim_data_acc,
          outcome = "accuracy",
          score = "difference",
          conditionlist = c("A", "B"),
          halftype = "oddeven",
          permutations = 500,
          var.RT = "RT",
          var.condition = "block_name",
          var.participant = "participant_number",
          var.compare = "trial_type",
          var.ACC = "ACC",
          compare1 = "congruent",
          compare2 = "incongruent",
          average = "median")

## ----acc_test9----------------------------------------------------------------
splithalf(data = sim_data_acc,
          outcome = "accuracy",
          score = "difference",
          conditionlist = c("A", "B"),
          halftype = "halfs",
          permutations = 500,
          var.RT = "RT",
          var.condition = "block_name",
          var.participant = "participant_number",
          var.compare = "trial_type",
          var.ACC = "ACC",
          compare1 = "congruent",
          compare2 = "incongruent",
          average = "mean")

## ----acc_test10---------------------------------------------------------------
splithalf(data = sim_data_acc,
          outcome = "accuracy",
          score = "difference",
          conditionlist = c("A", "B"),
          halftype = "halfs",
          permutations = 500,
          var.RT = "RT",
          var.condition = "block_name",
          var.participant = "participant_number",
          var.compare = "trial_type",
          var.ACC = "ACC",
          compare1 = "congruent",
          compare2 = "incongruent",
          average = "median")

## ----acc_test11---------------------------------------------------------------
splithalf(data = sim_data_acc,
          outcome = "accuracy",
          score = "difference",
          conditionlist = c("A", "B"),
          halftype = "random",
          permutations = 500,
          var.RT = "RT",
          var.condition = "block_name",
          var.participant = "participant_number",
          var.compare = "trial_type",
          var.ACC = "ACC",
          compare1 = "congruent",
          compare2 = "incongruent",
          average = "mean",
          plot = TRUE)

## ----acc_test12---------------------------------------------------------------
splithalf(data = sim_data_acc,
          outcome = "accuracy",
          score = "difference",
          conditionlist = c("A", "B"),
          halftype = "random",
          permutations = 500,
          var.RT = "RT",
          var.condition = "block_name",
          var.participant = "participant_number",
          var.compare = "trial_type",
          var.ACC = "ACC",
          compare1 = "congruent",
          compare2 = "incongruent",
          average = "median",
          plot = TRUE)

## ----acc_test13---------------------------------------------------------------
splithalf(data = sim_data_acc,
          outcome = "accuracy",
          score = "difference_of_difference",
          conditionlist = c("A", "B"),
          halftype = "oddeven",
          permutations = 500,
          var.RT = "RT",
          var.condition = "block_name",
          var.participant = "participant_number",
          var.compare = "trial_type",
          var.ACC = "ACC",
          compare1 = "congruent",
          compare2 = "incongruent",
          average = "mean")

## ----acc_test14---------------------------------------------------------------
splithalf(data = sim_data_acc,
          outcome = "accuracy",
          score = "difference_of_difference",
          conditionlist = c("A", "B"),
          halftype = "oddeven",
          permutations = 500,
          var.RT = "RT",
          var.condition = "block_name",
          var.participant = "participant_number",
          var.compare = "trial_type",
          var.ACC = "ACC",
          compare1 = "congruent",
          compare2 = "incongruent",
          average = "median")

## ----acc_test15---------------------------------------------------------------
splithalf(data = sim_data_acc,
          outcome = "accuracy",
          score = "difference_of_difference",
          conditionlist = c("A", "B"),
          halftype = "halfs",
          permutations = 500,
          var.RT = "RT",
          var.condition = "block_name",
          var.participant = "participant_number",
          var.compare = "trial_type",
          var.ACC = "ACC",
          compare1 = "congruent",
          compare2 = "incongruent",
          average = "mean")

## ----acc_test16---------------------------------------------------------------
splithalf(data = sim_data_acc,
          outcome = "accuracy",
          score = "difference_of_difference",
          conditionlist = c("A", "B"),
          halftype = "halfs",
          permutations = 500,
          var.RT = "RT",
          var.condition = "block_name",
          var.participant = "participant_number",
          var.compare = "trial_type",
          var.ACC = "ACC",
          compare1 = "congruent",
          compare2 = "incongruent",
          average = "median")

## ----acc_test17---------------------------------------------------------------
splithalf(data = sim_data_acc,
          outcome = "accuracy",
          score = "difference_of_difference",
          conditionlist = c("A", "B"),
          halftype = "random",
          permutations = 500,
          var.RT = "RT",
          var.condition = "block_name",
          var.participant = "participant_number",
          var.compare = "trial_type",
          var.ACC = "ACC",
          compare1 = "congruent",
          compare2 = "incongruent",
          average = "mean",
          plot = TRUE)

## ----acc_test18---------------------------------------------------------------
splithalf(data = sim_data_acc,
          outcome = "accuracy",
          score = "difference_of_difference",
          conditionlist = c("A", "B"),
          halftype = "random",
          permutations = 500,
          var.RT = "RT",
          var.condition = "block_name",
          var.participant = "participant_number",
          var.compare = "trial_type",
          var.ACC = "ACC",
          compare1 = "congruent",
          compare2 = "incongruent",
          average = "median",
          plot = TRUE)

## ----generate_mv_data---------------------------------------------------------
set.seed(01042021)

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



## ----create_specs-------------------------------------------------------------
specifications <- list(
  ACC_cutoff = c(0, 0.5),  
  RT_min           = c(0, 200),
  RT_max            = c(2000, 3000),
  RT_sd_cutoff      = c(0, 2),
  split_by          = c("subject", "trial"), 
  averaging_method  = c("mean")
)


## ----splithalf_for_mv, comment=FALSE, results='hide'--------------------------
mv_splithalf <- splithalf(data = sim_data,
                        outcome = "RT",
                        score = "difference",
                        conditionlist = c("A"),
                        halftype = "random",
                        permutations = 50,
                        var.RT = "RT",
                        var.condition = "block_name",
                        var.participant = "participant_number",
                        var.compare = "trial_type",
                        var.ACC = "ACC",
                        compare1 = "congruent",
                        compare2 = "incongruent",
                        average = "mean")

multiverse <- splithalf.multiverse(input = mv_splithalf,
                                   specifications = specifications)


## ----splithalf_for_mv_fig-----------------------------------------------------

multiverse.plot(multiverse = multiverse,
                title = "sim_multiverse")

## -----------------------------------------------------------------------------


## ----retest_mv1, comment=FALSE, results='hide'--------------------------------
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



## ----retest_mv2, comment=FALSE, results='hide'--------------------------------

icc3 <- testretest.multiverse(data = sim_data_acc,
                       specifications,
                       test = "ICC3",
                       
                       score = "difference",
                       
                       var.participant = "participant_number",
                       var.ACC = "ACC",
                       var.RT = "RT",
                       var.time = "block_name",
                       var.compare = "trial_type",
                       compare1 = "congruent",
                       compare2 = "incongruent") 

multiverse.plot(icc3)


## ----retest_mv3, comment=FALSE, results='hide'--------------------------------

retest_cor <- testretest.multiverse(data = sim_data_acc,
                       specifications,
                       test = "cor",
                       
                       score = "difference",
                       
                       var.participant = "participant_number",
                       var.ACC = "ACC",
                       var.RT = "RT",
                       var.time = "block_name",
                       var.compare = "trial_type",
                       compare1 = "congruent",
                       compare2 = "incongruent") 

multiverse.plot(retest_cor)



