library(ggplot2)
library(ggvenn)

stack_hists <- function(vector1, vector2, name1 = "freebayes", name2 = "mpileup") {
  # Generates a stacked his using ggplot from 2 vectors
  df1 <- data.frame(name1, vector1)
  df2 <- data.frame(name2, vector2)
  names(df1) <- c("x", "y")
  names(df2) <- c("x", "y")
  df <- rbind(df1, df2)

  gh <- ggplot(df, aes(y, fill = x)) +
    geom_histogram() +
    ylab("Frequency") +
    labs(fill = 'Method')

  return(gh)
}

transform_counts <- function(df) {
  # Takes a df of counts and returns a list formatted for ggvenn
  # https://stackoverflow.com/questions/26761754/create-venn-diagram-using-existing-counts-in-r
  sets = vector(mode = 'list', length = ncol(df) - 1)
  names(sets) = names(df)[1:(ncol(df) - 1)]
  lastElement = 0
  for (i in 1:nrow(df)) {
    elements = lastElement:(lastElement + df[i, ncol(df)] - 1)
    lastElement = elements[length(elements)] + 1
    for (j in 1:(ncol(df) - 1)) {
      if (df[i, j] == 1) {
        sets[[j]] = c(sets[[j]], elements)
      }
    }
  }
  return(sets)
}

venn_by_counts <- function(count1, count2, common, name1 = "freebayes", name2 = "mpileup") {
  # Creates a venn diagram from raw count numbers
  df.counts <- as.data.frame(rbind(c(1, 1, common), c(1, 0, count1), c(0, 1, count2)))
  names(df.counts) <- c(name1, name2, "counts")
  return(ggvenn(transform_counts(df.counts), fill_color = c("red", "blue")))
}

barplot_by_indiv <- function(df1, df2, name1 = "freebayes", name2 = "mpileup") {
  # Combines 2 data frames and builds a double barplot from them
  ns <- c(names(df1), "fill")
  df1 <- cbind(df1, rep(name1, nrow(df1)))
  df2 <- cbind(df2, rep(name2, nrow(df2)))
  names(df1) <- ns
  names(df2) <- ns
  df <- rbind(df1, df2)
  gb <- ggplot(data = df, aes(x = INDV, y = MEAN_DEPTH, fill = fill)) +
    geom_bar(stat = "identity", position = position_dodge())

  return(gb)
}
