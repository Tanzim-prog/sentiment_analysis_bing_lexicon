#install.packages("rvest")
#install.packages("dplyr")

library(rvest)
library(dplyr)

hotel_review_dataset = data.frame()

link = "your page link here"
hotel = read_html(link)

reviewer_name = hotel %>% html_nodes(".uyyBf") %>% html_text() #replace this using selector gadget generated node
review = hotel %>% html_nodes(".vTVDc > .FKffI ._T") %>% html_text() #replace this using selector gadget generated node

hotel_review_dataset = data.frame(reviewer_name, review, stringsAsFactors = FALSE)

write.csv(hotel_review_dataset, "The CSV File Name.csv")
