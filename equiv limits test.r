## setting data
nr_repl <- 2
nr_conc <- 11
nr_modelparam <- 8 # 4pl model with 2 IC50's
df <- 2 *( nr_repl) * nr_conc - 2 * nr_modelparam
t95 <- qt(0.975, df)


#################  All possible reference differences
########################################


### extra line added for test

refs <- read.table("refshillsope.txt", header = TRUE)

# Calculate distribution of differences
comb_all <- combn(1:nrow(refs), 2, FUN = NULL)

diffs_all <- combn(refs[,2], 2, diff)
error_all <- combn(refs[,3], 2, function(errors) sqrt(errors[1]^2 + errors[2]^2))

# CI limits 95%
CI_diff <- cbind(diffs_all - t95*error_all, diffs_all, diffs_all + t95*error_all)

#### Determine equivalence limits
# Max of 95%confindence limits
EL_max <- max(abs(CI_diff[,c(1, 3)]))
EL_max_1 <- sort(abs(CI_diff[,c(1, 3)]), decreasing = T)[2]
print(paste(EL_max, "is the equivalence limit"))

## plot CIs in one figure (to assess equivalence limits)
plot(CI_diff[,2], 1:nrow(CI_diff), xlim = c(-max(abs(CI_diff)), max(abs(CI_diff))), ylab = "Reference - Reference pair", xlab = "Difference Reference - Reference", main = "95% confidence interval Reference - Reference")
for (i in 1:nrow(CI_diff)) {
  lines(c(CI_diff[i, 1], CI_diff[i, 3]), c(i, i))
}
abline(v = 0, col = "red")
abline(v = c(-EL_max, EL_max), col = "green")
abline(v = c(-EL_max_1, EL_max_1), col = "blue")
