#read raw data
raw_data <- data.frame()
for(src in c("test", "train")) {
       #from each data folder
       print((paste("reading ", src, "ing data...", sep="")))
       
       #read X, Y, and subject data
       x_data <- read.table(paste("./", src, "/X_", src, ".txt", sep=""))
       y_data <- read.table(paste("./", src, "/Y_", src, ".txt", sep=""))
       subject_data <- read.table(paste("./", src, "/subject_", src, ".txt", sep=""))
       
       #set Y's only column as X's activity_id column
       x_data$activity_id <- y_data$V1
       
       #set subject's only column as X's subject_id column
       x_data$subject_id <- subject_data$V1
       
       #add to raw data
       raw_data <- rbind(raw_data, x_data)
       
       #cleanup
       rm("x_data")
       rm("y_data")
}

#read columns and activity names
print("Reading labels...")
raw_col_names = read.table("features.txt", colClasses = "character")
raw_act_names = read.table("activity_labels.txt")

#set column names from spec, using make.names to replace all illegal
# characters (for variable names) with '.', and forcing unique names
print("Setting variable names...")
col_names = make.names(raw_col_names$V2, unique = TRUE)
names(raw_data)[1:(ncol(raw_data)-2)] <- col_names


#now the fun starts: load dplyr package
library(dplyr)

#wrap the data in a data-frame-table
dft_data <- tbl_df(raw_data)

#create tidy data
print("Tidying...")
#get activity names (good thing they're ordered by id...)
act_names <- raw_act_names$V2
tidy_data <-
       #select only the columns we're interested in
       # which are the variables containing 'mean.', 'std.', or '_id'
       # (which we added in the data merge)
       select(dft_data, contains("mean.", ignore.case = TRUE),
                   contains("std."), contains("_id")) %>%
       #set activity labels
       mutate(activity = act_names[activity_id]) %>%
       #drop activity_id
       select(-activity_id) %>%
       #group by activity and subject, so we can summarize by them
       group_by(activity, subject_id) %>%
       #summarize using 'mean' on each variable
       summarise_each(funs(mean))

#write tidy data
print("Writing tidy data...")
write.table(tidy_data, file = "tidy_data.txt", row.names = FALSE)
