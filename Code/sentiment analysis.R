library(readxl)
library(tidyverse)
library(tidytext)
library(ggplot2)

data_frame <- read_excel("D:/AIUB/Thesis/GIT/Dataset/Processed Data.xlsx", sheet = "Dhaka Regency")
View(data_frame)

# Tokenization
tidy_data <- data_frame %>%
  unnest_tokens(word, Text)
View(tidy_data)

# Sentiment Lexicon
bing_lexicon <- get_sentiments("bing")

# Sentiment Analysis
sentiment_scores <- tidy_data %>%
  inner_join(bing_lexicon, by = "word")

# Summarize
sentiment_summary_bing <- sentiment_scores %>%
  group_by(sentiment) %>%
  summarize(total_count = n())

# Data Frame
sentiment_df_bing <- as.data.frame(sentiment_summary_bing)
print(sentiment_df_bing)

# Visualize
ggplot(sentiment_summary_bing, aes(x = sentiment, y = total_count, fill = sentiment)) +
  geom_bar(stat = "identity") +
  labs(title = "Sentiment Analysis", x = "Sentiment", y = "Total Count") +
  theme_minimal()

