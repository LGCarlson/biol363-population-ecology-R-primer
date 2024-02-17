# Intro to R
# BIOL363/BIOL898 Population Ecology 2024
# by Lindsay Carlson

# This code is meant to serve as an introduction to R Studio and the R coding language 

# *note, anything not preceded by a # in R will be treated as code.
# If you'd like to annotate your code (which I recommend), you must "hash it out" otherwise it will create an error. 

# R code is read by the computer like a book: left to right, top to bottom
# capitalization (and spelling) matter in R (there is no spell check or autocorrect)




####### Objective 1. Arithmetic operations, variable assignment, variable class, naming, and vector assignment ####### 

#### 1.1

# You can do basic math operations in R. The answer will be returned in the console below. For example:

2+2 

1-14

100/10

0.5*8

#### 1.2

# If you'd like to store a number or the result of an operation, you can assign it to a variable using <- 
# *you can also use =, but this gets confusing down the road with different equations/var types, so <- is preferred for assignment

a<-2+2

# Notice that the varible you created now appears in the top right corner, in your "environment"
# This is helpful for keeping track of what you've created so far
# If you'd like to print the value of the variable you've created in the console below, just run it like this:

a

# If you'd like to use a variable later, you can use functions on it, or do basic arithmetic as if it WERE whatever it is assigned to

a/4

#### 1.3

# If you'd like to determine what "type" or "class" a variable is, you can use the function "class"
# This function (and many others) are included base R (comes loaded with R, no packages needed)

class(a)

# Options for class types are numeric/integer (a number), character (a word), or logical (T/F)

# When assigning variables of different class types, we have to use different notation.

# For a single number or integer, you can assign directly 

b<-3.8

class( b)

# For a character, we must put the character within quotations

d<-"size"

class(d)

# For a logical, we can simple use capital T/F or all caps TRUE or FALSE directly, no quotations needed

e<-T

class(e)

# Notice that we can only do math on variables when they are numeric

a*b

b*d   #you will get an error message here

# But we can ask R questions about whether two things are equivalent, regardless of type using ==, it will return either TRUE or FALSE

b==d


#### 1.4

# We are not limited to assigning variables to single letters, we can name them whole words or word number combinations.
# One note though, you CANNOT assign something to a number, or to anything beginning with a number

# don't do this:   1<-10000
# or this:   1_data<- "my data here"

# but you can do this:

fish1_length<-137.5

# R ignores spaces for the most part, but not when naming variables, so you need to use _ or - if you'd like to create space in a var name
# *One more note on naming... you technically CAN name a variable the name of a function (i.e., "class"), but I do not recommend it


#### 1.5

# We aren't limited to just assigning one item to a variable, we can create a number of datatype
# First, lets explore how to create a vector

# The base R function c() or concatenate allows us to group things into one variable

our_first_vector<-c(1,2,3,4,5,6)

# We can create character vectors in the same way, but with quotations surrounding the words

our_second_vector<-c("duck","duck","goose")

# If you'd like to take a look at just one value of the vector, you can print the value by position using square brackets
our_second_vector[3]

# You can use this notation to overwrite one value of the vector, for example:
our_first_vector[1]<-NA

# Note that when assigning an NA value, you do not put quotations around NA, it is treated as a logical

# We can do math on vectors, if they are numeric (even if they contain NAs)
# And if we'd like to overwrite our original vector with that change, we can assign it to the original name

our_first_vector<-our_first_vector*100

# Run what we've made:
our_first_vector

# Just keep in mind that if you now rerun line 110, your changes will again be overwritten

# There are a few other useful functions for creating vectors, such as the rep() or repeat function

repeating_numbers_vector<-rep(1,15)
repeating_numbers_vector

# There are two "arguments" in this function. The first is the value you'd like to repeat
# The second is the number of times you'd like to repeat it

# You can also make character or logical vectors this way:

state_vec<-rep("Montana",3)

na_vec<-rep(NA,3)

# Next, the seq() function allows you to create a sequence from number x to number y, by step length z

seq(0,100,5)

# Here we've created a vector of numbers from 0 to 100, counting by 5




####### Objective 2. Creating matrices, matrix math, calling matrix values ####### 

#### 2.1

# Matrices are a rectangular arrangement of numbers in rows and columns, in R matrices are homogenous (numeric only), and 2D
# They are a very useful data format for arranging numeric data because you can do math on them directly

# To create a matrix, use the function matrix
# The arguments are data, nrow, ncol, and byrow (byrow defines whether data fills by row or column first)
# Look at the different arrangement when byrow=T vs F

row_matrix<-matrix(data=c(1, 2, 3, 4, 5, 6, 7, 8, 9), nrow = 3, ncol = 3, byrow = T)

col_matrix<-matrix(data=c(1, 2, 3, 4, 5, 6, 7, 8, 9), nrow = 3, ncol = 3, byrow = F)

row_matrix; col_matrix

# Create another matrix using rep() for data, rather than c()
# *note, you don't have to specify function arguments, so long as you put them in the right order
# I also didn't specify byrow because I'm filling the whole thing with the same value

another_matrix<-matrix(rep(0.1,9),3,3)


#### 2.2

# We can do math on matrices both by numbers AND by other matrices (so long as the other matrix is the same size/shape)

row_matrix-1

row_matrix*another_matrix


#### 2.3

# Though you can name the rows and columns in matrices, I don't find it that useful. I recommend using square brackets to call on a matrix

row_matrix[1,]  # calls entire first row

row_matrix[,1]  # calls entire first column

row_matrix[2,1]  # calls value from second row, first column

# Again, you can use this notation to assign or replace values

row_matrix[2,1] <- NA

row_matrix[3,] <- NA

row_matrix

# Let's create a blank matrix and fill it in manually

fill_matrix<-matrix(rep(NA,6),3,2)

# Fill col 1
fill_matrix[1,1] <- 300
fill_matrix[2,1] <- 100
fill_matrix[3,1] <- 25

# Fill col 2
fill_matrix[1,2] <- 0
fill_matrix[2,2] <- 0.7
fill_matrix[3,2] <- 0.1

fill_matrix





####### Objective 3. Mixed data types and creating data frames, data frame structure, accessing the data frame, other data holders ####### 

#### 3.1

# Though you can create a vector with mixed datatypes, it is not useful for most purposes
# When you have data with a mix of data types, a data frame (or tibble) is the most useful format
# There are many reasons you'd want to have mixed data types, for example, writing a linear model with both numeric and categorical variables

# We will use the function data.frame() in baseR to create a dataframe, the only arguments you need are the column names followed by the data
# Data in each column must be of the same length in a dataframe, and there are no row names
# *Note that it is okay to separate parts of a function on to different lines to make it more readable

super_sleepers <- data.frame(ranking=1:4,
                             animal_name=c("Koala", "Hedgehog", "Sloth", "Panda"),
                             country=c('Australia', 'Italy', 'Peru', 'China'),
                             daily_sleep_hours_mean=c(21, 18, 17, 10))

super_sleepers

# Another way to create a dataframe is to include existing vectors (again of the same length)
# First, use the length() function to check the length

length(state_vec);length(our_second_vector);length(na_vec)

another_df <- data.frame(state = state_vec, 
                         bird = our_second_vector, 
                         bill_length = na_vec)

another_df


#### 3.2

# A useful function for dealing with dataframes is str() which allows you to check the structure of each part of the dataframe
# The function tells us how large the df is, the class of each column, and proves an example of the first few values

str(super_sleepers)


#### 3.3

# To access parts of the dataframe, we will need to use different notation than for matrices
# Use the dataframe name then a dollar sign $, then the column name to refer to a column

super_sleepers$daily_sleep_hours_mean

# You can also use square brackets to call an entire column, but I feel this gets confusing/is not best practice

super_sleepers[4]

# To access a specific value, combine the df$column notation with square brackets, 
# This is selecting the value in the third row of the daily_sleep_hours_mean column

super_sleepers$daily_sleep_hours_mean[3]

# You can add a column to a dataframe using similar notation 
# You cannot add rows to a dataframe in this way

super_sleepers$continent<-c("Australia","Europe","South America","Asia")
  
# Also, you can do math on a dataframe column, so long as it is numeric

super_sleepers$daily_sleep_minutes_mean<-(super_sleepers$daily_sleep_hours_mean*60)

super_sleepers

# If you'd like to take a look at just the first part of your data (specified 2 rows), use the head() function 
# *note, this is more useful for super long dataframes, you wouldn't actually need to use it on this one

head(super_sleepers,2)


#### 3.4

# There are other types of objects in R that we can use to hold data, these are more complicated, so we will not cover them except to describe
# lists - R objects which contain elements of different types like − numbers, strings, vectors and another list inside it. 
          # A list can also contain a matrix or a function as its elements. A list is created using list() function.
# arrays - Arrays are the R data objects which can store data in more than two dimensions. 
          # For example − If we create an array of dimension (2, 3, 4) then it creates 4 rectangular matrices each with 2 rows and 3 columns. Arrays can store only data type.
          # An array is created using the array() function





####### Objective 4.loading tidyverse, pipes, tibbles, and data transformations with dplyr ####### 

#### 4.1

# We will begin using functions from the tidyverse to work with dataframes, because it is the most organized/current method
# First, load all packages in the tidyverse to your environment using the library() function
# The tidyverse contains many useful packages like tibble, dplyr, readr, and ggplot2; this way you don't need to load them individually

library(tidyverse)

# We will do some transformations on dates, which we will use the lubridate package for
# install.packages("lubridate")   #run this line if you have never loaded this package

library(lubridate)


#### 4.2

# So far, we have only done one function/action at a time
# In baseR, we can do multiple functions at once by nesting them, which would look like this: h(g(f(x))) 
# You're applying function f() on data x, then applying function g() on the outcome of f(x), which then becomes the argument of h()
# In tidyverse syntax, you’d write x %>% f %>% g %>% h
# Here, data is x and you're applying function f(), so on and so forth just as in baseR

# These three symbols together ( %>% ) are also known as a pipe 
# A pipe is a function from the magrittr (tidyverse) package 
# It passes the left hand side of the operator to the first argument on the right hand side of the operator. 

# These two lines of code are the same

str(another_df)

another_df %>% str()

# When writing a function that has the data object, then a comma separating other arguments, you don't need to include the comma

head(another_df,2)

another_df %>% head(2)

# A pipe isn't always necessary/efficient (as above), but it is useful for chaining multiple functions together without having to create an intermediate object


#### 4.3

# The readr (tidyverse) package has a function called read_csv() that removes some problems associated with read.csv() from baseR
# We can read in a .csv that is stored online on GitHub (data and code storage platform)
# Name this data cetaceans, check the structure, and look at the first 10 lines

cetaceans<-read_csv("https://raw.githubusercontent.com/LGCarlson/tidytuesday/master/data/2018/2018-12-18/allCetaceanData.csv")

str(cetaceans)

head(cetaceans,10)

class(cetaceans)

# When looking at this object, you will see it is called a tibble, and when checking the class, you will see tbl_df and data.frame
# A tibble is a variant of data frames that is used in the tidyverse, they work exactly the same
# Tibbles can contain column types formatted as dates, which is often useful

# The table() function is useful if you'd like to count the instances of discrete values

table(cetaceans$species)

# Here, we can see the number of records for each species


#### 4.4

# dplyr is maybe the most useful packages in all of R
# It provides a few functions that are absolutely essential for data wrangling/transformation. 
# There is a handy cheat sheet available here: https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf


#### 4.4.1 Formatting functions

############ select() - keep (or drop) columns by name

# When working with a large dataframe, sometimes you need to reduce the nubmer of variables and remove a specific one. 
# select() is an easy way to do that.

# For some reason, this dataset comes with an odd first column, lets remove it and overwrite the dataframe
# To negatively select (remove), use the minus sign and the column names to remove
# *note, when a dataframe heading begins with a number or special character, you must surround it with single quotations

cetaceans<-cetaceans %>%
  select(-'...1')

# To positively select (keep), just write the names of all columns you want to include in the new dataframe

parents_df<- cetaceans %>%
  select(name, mother, father)


############ rename() - rename columns in dplyr. The new name is in the first "" and the original name is second. 

# In this example, perhaps we want to rename the "originDate" column "acquisitionDate" to match the "acquisition" column

cetaceans<-cetaceans %>%
  rename("acquisitionDate" = "originDate")


############ mutate() - create new columns in an existing dataframe

# Here, we will use the lubridate package to extract the "year" from a column formatted as a date.
# *note: this function will not work if dates are formatted as characters/numbers
# We can also use the mutate column to do math on columns. Now, we are subtracting birthYear from our newly created acquisitionYear column
# This will give us the age at acquisition. For animals born in captivity, this will be 0. 
# For animals with unknown birthYears (NAs), the new column will be population by NAs

cetaceans<-cetaceans %>% 
  mutate(acquisitionYear = year(acquisitionDate)) %>% 
  mutate(acquisitionAge = acquisitionYear-birthYear)

# If we want to take a quick look at quantitative data, we can use the histogram hist() function to look at our data's distribution
# The plot should appear in the lower righthand corner of R Studio (click on the Plots tab, if not)

hist(cetaceans$acquisitionAge)

# Now let's look at the columns we've created

View(cetaceans)


#### 4.4.2 Filtering in dplyr

############ filter() - this function allows us to easily filter data by a row value, without removing any of the other column data

# Important to remember: select is for columns, filter is for rows
# Important to remember: you can't use logical rules in select, bu you can in filter

# The objective here is to reduce the rows/observations by a value critera or other condition. 

# operators include < (less than), > (greater than), == (exactly equal to), (!= not equal to) and is.na as well as a few other advanced options

# In the previous step, we calculated the age at acquisition for all individuals, but we had some illogical values

# Perhaps we only care about the age at acquisition for Bottlenose dolphins captured in the wild with known birth years
# The example highlights the utility of chaining these functions together that would otherwise need to be done in multiple steps
  
knownAge_Bottlenose <- cetaceans %>% 
  filter(species == "Bottlenose") %>%     #keep only bottlenose dolphins
  filter(acquisition == "Capture") %>%    #keep only individuals captured in the wild
  filter(!is.na(acquisitionAge)) %>%      #remove any NAs in aquisitionAge (we didn't know birthYear)
  filter(acquisitionAge >= 0)             #remove any impossible ages

# Now lets look at the histogram of ages of wild caught dolphins

hist(knownAge_Bottlenose$acquisitionAge)

# If we wanted to calculate the mean acquisition age, we can use the baseR function mean, same for min, max, sd, etc

mean(knownAge_Bottlenose$acquisitionAge); sd(knownAge_Bottlenose$acquisitionAge)
min(knownAge_Bottlenose$acquisitionAge); max(knownAge_Bottlenose$acquisitionAge)

# A note: when I originally wrote this code, I wrote "Captured" rather than "Capture" so may dataframe was length 0
# Because you must get capitalization and spelling correct for exact match filtering, you can use the unique function (or levels if a factor)

unique(cetaceans$acquisition)


#### 4.4.3 Grouping and summarizing

# Sometimes we want to calculate summary statistics (or just count occasions) by categorical groupings (or numeric ones like year)
# To do this, we can use the combination of group_by and summarise
# We will talk about these together because there isn't much use to grouping data by a categorical variable if you're not going to transform or summarize it in some way

############ group_by() - this function groups data by discrete levels

############ summarise - summarise data by functions of choice

# For this example, lets count the number of offspring from each "mother"

moms<-parents_df %>% 
  filter(!is.na(mother)) %>% 
  group_by(mother) %>% 
  summarise(number_offspring=n()) %>%    # n() function counts the number in each grouped level
  arrange(desc(number_offspring))        # function arrange orders things from low to high or if desc(), high to low

# This is essentially the same as doing table(parents_df$mother), except the result is a dataframe that is more easily usable
# Look at the data and explore mean number of offspring

moms

hist(moms$number_offspring)

mean(moms$number_offspring)

# We can also use summaries to calculate summary statistics like mean(), sd(), etc by level
# Using our knownAge_Bottlenose dataset, lets calculate the age at capture by sex

knownAge_Bottlenose %>% 
  group_by(sex) %>% 
  summarise(mean_acquisitionAge = mean(acquisitionAge), sd_acquisitionAge = sd(acquisitionAge), n_indivs = n())





####### Objective 5. Reading in data stored on your computer, data management best practices ####### 


#### 5.1

# Set your working directory using the setwd() funtion to whatever folder you have saved your data in
# Note, PC users may have to reverse direction of slashes when copying working directory from navigation, different notation for MAC

setwd("C:/Users/lcarlson/Documents/BIOL363 R workshop")     #YOU WILL NEED TO CHANGE THIS LINE

# In general, you should only read in .csv or .txt files into R   .xslx or regular excel files with multiple sheets will not be read properly
# This means that there should be no strange formatting, tables, or figures when you save as .csv
# When entering data into excel, do not enter 0s, "NA", or . as placeholders, just leave the row blank and R will read them as NAs

# This is data simulated for an elephant population with a random k from Lab 2

elephants<-read_csv("elephants_random_k.csv")

# t is the timestep (0-40)
# recall that we simulated five replicates population size for 40 timesteps
# p1-p5 are simulated population sizes for a random k between 180 and 360


#### 5.2

# When reading in new data, best practice is to look at it and make sure it looks as you would expect

# A few ways to do this include

# Check the structure and look at the first few rows

str(elephants)

head(elephants)

# Because all columns are numeric (doubles only), we can assume there are no unexpected placeholders (i.e.,  - . or "NA")
# If you'd like to check for the presence of actual NAs, you can use

table(is.na(elephants))  

# Because there are no NAs, all values are "False" in the table

# Another good thing to check are min and max values, we'll just do this for one column
min(elephants$p1);max(elephants$p1)





####### Objective 6. Plotting in baseR, plotting in ggplot2 ####### 


#### 6.1

# I personally find plotting in baseR quite clunky, but some folks prefer it and it is useful to understand

# First, you have to create a plot, which species the plot area for all data and tell it to add points with shape pch = 16 based on elephants$p1
plot(elephants$t, elephants$p1, col = "red", pch = 16, xlab = "Years", 
     ylab = "Elephant population in Pilanesburg NP", main = "Simulated with random K",
     xlim = c(0, max(elephants$t)), ylim = c(0,365))

# Next begin adding elements to the plot, these "stack" on the original plot area
# The lines function needs a color argument, but not pch (shape of point for scatter plot)
lines(elephants$t, elephants$p1, col = "red")

points(elephants$t, elephants$p2, col = "blue", pch = 16)
lines(elephants$t, elephants$p2, col = "blue")

points(elephants$t, elephants$p3, col = "green", pch = 16)
lines(elephants$t, elephants$p3, col = "green")

points(elephants$t, elephants$p4, col = "orange", pch = 16)
lines(elephants$t, elephants$p4, col = "orange")

points(elephants$t, elephants$p5, col = "purple", pch = 16)
lines(elephants$t, elephants$p5, col = "purple")

# Add a horizontal line denoting bounds of simulated K
abline(h = 180, col = "grey", lty = 2)
abline(h = 360, col = "grey", lty = 2)

# Add a legend
legend("bottomright", legend = c("p1", "p2", "p3", "p4", "p5"), col = c("red", "blue", "green", "orange", "purple"), pch = 16)

# To save this plot, click the "export" button on toolbar in the plots window (lower right hand)


#### 6.2

# The ggplot2 package is loaded with the tidyverse, so no need to load any packages

# ggplot2 draws plots for "long data", whereas the dataset we have is "wide"
# We will need to convert it using a tidyr function 

elephants_long <- pivot_longer(elephants, cols = c(2:6), names_to = "simulation", values_to = "population_size")

elephants_long

# It doesn't matter that it is now "out of order" as we would think of it, ggplot will organize it correctly

ggplot(elephants_long, aes(x = t, y = population_size, color = simulation)) +   # sets up plot area, x/y scaled set based on data provided
  geom_point(size=2, pch=16) +                                                  # add points (refers to data in aes) and customize size/shape
  geom_line(size=0.6) +                                                         # add lines (refers to data in aes)
  geom_hline(yintercept = 180, linetype = "dashed", color = "grey") +           # add horizontal lines showing simulated K limits
  geom_hline(yintercept = 360, linetype = "dashed", color = "grey") +
  scale_y_continuous(limits = c(0, 365)) +                                    # set y-axis limits
  labs(x = "Years", y = "Elephant population in Pilanesburg NP", 
       title = "Simulated with random K", color="Simulation number") +    # add axis labels, plot title, and change legend label
  theme_classic() + theme(legend.position = "bottom") 

# A few notes, everything in aes() within the original ggplot() is applied to whole plot, so in this case, the data and color by arguements
# ggplot is similar to other tidyverse functions in that you can chain them together, but note that it uses + rather than the pipe
# You can use scale_x_continuous or scale_y_continuous to change the x and y axis limits manually
# the theme() functions provide a variety of ways to customize your figure

# You can save your plot the same way (export) or 
# use the function ggsave(plot=last_plot(), filename="whateveryouwant.pdf",width=5, height=7) 
# to export to a pdf, jpg, or png with a custom size
