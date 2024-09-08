library(openxlsx)
library(readxl)
library(stringr)
library(tm)

directory <- "D:/AIUB/Thesis/GIT/Dataset"
file_name <- "Hotel Review Data Table.xlsx"
sheet_index <- 1
file_path <- file.path(directory, file_name)
read_data <- read_excel(file_path, sheet = sheet_index)
dataset <- read_data
View(dataset)

# missing values finder
any(is.na(dataset))
clean_data <- na.omit(dataset)

#special character removal function
removeSpecialChars <- content_transformer(function(x) gsub("[^[:alnum:][:space:]]", "", x))

# corpus
corpus <- Corpus(VectorSource(dataset$Review))
corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, removeSpecialChars)
corpus <- tm_map(corpus, removeWords, stopwords("english"))
corpus <- tm_map(corpus, stemDocument)
corpus <- tm_map(corpus, stripWhitespace)

# trimming
corpus$Review <- str_trim(corpus$Review)

# corpus to a data frame
corpus_df <- data.frame(Text = sapply(corpus, as.character), stringsAsFactors = FALSE)

# data frame to xcel
write.xlsx(corpus_df, file = "D:/AIUB/Thesis/GIT/Dataset/Processed Data.xlsx", sheetName = "Dhaka Regency", rowNames = FALSE)