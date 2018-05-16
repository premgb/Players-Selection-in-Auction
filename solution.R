#################################################################################################
# Optimization problem:                                                                         #
#   Prob statement - How to buy 20 players team (4-3-3) meeting certain criteria in an auction? #
#################################################################################################
##
#Player's profile (Sample data)
##
set.seed(123)
df <- data.frame(player_id = 1:50,
                 pos = sample(c('G', 'D', 'M', 'F'), 50, replace = T),
                 salary = rnorm(50, mean=1000000, sd=500))

##
#Solution
##
library(lpSolve)

#objective function
obj <- rep(1, nrow(df))

#constraints
con <- matrix(c(obj <- rep(1, nrow(df)),
                as.vector(df$salary),
                (df$pos == 'G') * 1,
                (df$pos == 'G') * 1,
                (df$pos == 'D') * 1,
                (df$pos == 'D') * 1,
                (df$pos == 'M') * 1,
                (df$pos == 'M') * 1,
                (df$pos == 'F') * 1,
                (df$pos == 'F') * 1), nrow = 10, byrow = T)
dir <- c("==", "<=", ">=", "<=", ">=", "<=", ">=", "<=", ">=", "<=")
rhs <- c(20,        #total number of players
         50000000,  #salary constraints
         2,         #Goalkeeper minimum number
         3,         #Goalkeeper maximum number
         5,         #Defender minimum number
         7,         #Defender maximum number
         4,         #Midfielder minimum number
         5,         #Midfielder maximum number
         4,         #Forward minimum number
         6)         #Forward maximum number

#solution
result <- lp ("max", obj, con, dir, rhs, all.bin=TRUE)

result$solution
# [1] 0 1 0 0 1 1 0 1 1 1 0 1 0 0 0 0 0 0 1 1 0 0 1 1 0 1 0 0 1 0 1 0 1 0 0 0 0 0 0 0 0 1 0 1 1 0 1 1 0 0
