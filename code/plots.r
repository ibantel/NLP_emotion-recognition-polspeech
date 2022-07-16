###################################################################################################
##### Plotting first results                                                                  #####
#################################################################################################㐂

library(data.table)
library(tidyverse)
library(extrafont)
library(extrafontdb)
library(RColorBrewer)

windowsFonts("LM Roman 10" = windowsFont("LM Roman 10"))
windowsFonts("Palatino Linotype" = windowsFont("Palatino Linotype"))

###################################################################################################
##### Plot theme                                                                              #####
#################################################################################################㐂
theme_LaTeX <- function(){ 
  # font <- "LM Roman 10"
  font <- "Palatino Linotype"#assign font family up front; plot fonts: Computer Modern Serif, but Latin Modern looks similar. Google: LaTeX font in R; easiest with extrafonts # might need to re-install extrafonts; needs .\switchdrive\WORK\Z-Coding-other\lmroman10-regular-webfont.ttf to be installed for all users
  theme_minimal() %+replace%    #replace elements we want to change
    theme(
      #text = element_text(family="LM Roman 10"),
      #grid elements
      panel.grid.major = element_blank(),    #strip major gridlines
      panel.grid.minor = element_blank(),    #strip minor gridlines
      #axis.ticks = element_blank(),          #strip axis ticks
      #theme_minimal() already strips axis lines
      #text elements
      plot.title = element_text(             #title
        family = font,            #set font family
        size = 20,                #set font size
        #face = 'bold',            #bold typeface
        hjust = 0,                #left align
        vjust = 2),               #raise slightly
      plot.subtitle = element_text(          #subtitle
        family = font,            #font family
        hjust = 0,
        vjust = 2,
        size = 14),               #font size
      plot.caption = element_text(           #caption
        family = font,            #font family
        size = 9,                 #font size
        hjust = 0),               #right align
      axis.title = element_text(             #axis titles
        family = font,            #font family
        size = 15),               #font size
      axis.text = element_text(              #axis text
        family = font,            #axis family
        size = 9),                #font size
      axis.text.x = element_text(            #margin for axis text
        margin=margin(5, b = 10)),
      axis.line = element_line(colour = "black"),
      axis.text.y = element_text(hjust = 1),
      panel.border = element_blank(),
      panel.background = element_blank(),
      # legend
      legend.title = element_text(family = font),
      legend.text = element_text(family = font),
      legend.position="bottom",
      # facet_wrap
      strip.text = element_text(family = "LM Roman 10", size = 12)
    )
}

###################################################################################################
##### Plots                                                                                   #####
#################################################################################################㐂
# Importing data

Con <- fread("./Data/Con2.csv")
Lab <- fread("./Data/Lab.csv")

Con$TM_BJ_01 <- factor(Con$TM_BJ_01, labels = c("May","Johnson"))
Lab$TM_BJ_01 <- factor(Lab$TM_BJ_01, labels = c("May","Johnson"))

df <- bind_rows(Con, Lab)

# fwrite(df, file = "./Data/UK_parl_combined.csv", append = F)

# Grouped aggregates - conservatives

Con %>% filter(!is.na(TM_BJ_01)) %>% ggplot() +
  geom_smooth(aes(x=month_year, y=vader_compound, group = TM_BJ_01, colour = TM_BJ_01)) + geom_vline(xintercept = "2019-07", color = "red") + xlab("Date") + 
  theme_minimal() + theme(legend.title = element_blank()) + theme(legend.position = "bottom")

Con %>% filter(!is.na(TM_BJ_01)) %>% ggplot() +
  geom_smooth(aes(x=month_year, y=txtblob_polarity, group = TM_BJ_01, colour = TM_BJ_01)) + geom_vline(xintercept = "2019-07", color = "red") + xlab("Date") + 
  theme_minimal() + theme(legend.title = element_blank()) + theme(legend.position = "bottom")

Con %>% filter(!is.na(TM_BJ_01)) %>% ggplot() + 
  geom_smooth(aes(x=month_year, y=txtblob_subjectivity, group = TM_BJ_01, colour = TM_BJ_01)) + geom_vline(xintercept = "2019-07", color = "red") + xlab("Date") + 
  theme_minimal() + theme(legend.title = element_blank()) + theme(legend.position = "bottom")

Con %>% filter(!is.na(TM_BJ_01)) %>% filter(!is.na(TM_BJ_01)) %>%  ggplot()  + coord_cartesian(ylim=c(-1, 1)) +
  geom_smooth(aes(x=month_year, y=flair, group = TM_BJ_01, colour = TM_BJ_01)) + geom_vline(xintercept = "2019-07", color = "red") + geom_vline(xintercept = "2019-05", color = "black")+ xlab("Date") + 
  theme_LaTeX()  + ylab("Avg. Sentiment (flair)") + theme(legend.title = element_blank()) + theme(legend.position = "bottom") + ggtitle("Conservative sentiment towards Johnson and May")
ggsave("./Plots/flair_con.pdf", device = cairo_pdf, height = 4, width = 8) 

Lab %>% filter(!is.na(TM_BJ_01)) %>% ggplot() +
  geom_smooth(aes(x=month_year, y=vader_compound, group = TM_BJ_01, colour = TM_BJ_01)) + geom_vline(xintercept = "2019-07", color = "red") + xlab("Date") + 
  theme_minimal() + theme(legend.title = element_blank()) + theme(legend.position = "bottom")

Lab %>% filter(!is.na(TM_BJ_01)) %>% ggplot() +
  geom_smooth(aes(x=month_year, y=txtblob_polarity, group = TM_BJ_01, colour = TM_BJ_01)) + geom_vline(xintercept = "2019-07", color = "red") + xlab("Date") + 
  theme_minimal() + theme(legend.title = element_blank()) + theme(legend.position = "bottom")

Lab %>% filter(!is.na(TM_BJ_01)) %>% ggplot() + 
  geom_smooth(aes(x=month_year, y=txtblob_subjectivity, group = TM_BJ_01, colour = TM_BJ_01)) + geom_vline(xintercept = "2019-07", color = "red") + xlab("Date") + 
  theme_minimal() + theme(legend.title = element_blank()) + theme(legend.position = "bottom")

Lab %>% filter(!is.na(TM_BJ_01)) %>% filter(!is.na(TM_BJ_01)) %>%  ggplot()  + coord_cartesian(ylim=c(-1, 1)) +
  geom_smooth(aes(x=month_year, y=flair, group = TM_BJ_01, colour = TM_BJ_01)) + geom_vline(xintercept = "2019-07", color = "red") + geom_vline(xintercept = "2019-05", color = "black")+ xlab("Date") + 
  theme_LaTeX()  + ylab("Avg. Sentiment (flair)")  + theme(legend.title = element_blank()) + theme(legend.position = "bottom") + ggtitle("Labour sentiment towards Johnson and May")
ggsave("./Plots/flair_lab.pdf", device = cairo_pdf, height = 4, width = 8) 

# Could also do by date or filter for agenda items containing 'prime minister'


###################################################################################################
##### Emotions                                                                                #####
#################################################################################################㐂


df2 <- fread("./Data/House_of_commons_predicted.csv")

test <- df2 %>% filter(!is.na(TM_BJ_01), party == "Con") %>% filter(!is.na(TM_BJ_01))
hist(test$DISGUST)
table(test$TM_BJ_01)

df2 %>% filter(TM_BJ_01 != "", party == "Con") %>% filter(!is.na(TM_BJ_01)) %>%  ggplot()  + # coord_cartesian(ylim=c(-1, 1)) +
  geom_smooth(aes(x=month_year, y=DISGUST, group = TM_BJ_01, colour = TM_BJ_01)) + geom_vline(xintercept = "2019-07", color = "red") + geom_vline(xintercept = "2019-05", color = "black")+ xlab("Date") + 
  theme_LaTeX()  + ylab("Avg. Disgust")  + theme(legend.title = element_blank()) + theme(legend.position = "bottom")

df2 %>% filter(TM_BJ_01 != "", party == "Lab") %>% filter(!is.na(TM_BJ_01)) %>%  ggplot()  + # coord_cartesian(ylim=c(-1, 1)) +
  geom_smooth(aes(x=month_year, y=DISGUST, group = TM_BJ_01, colour = TM_BJ_01)) + geom_vline(xintercept = "2019-07", color = "red") + geom_vline(xintercept = "2019-05", color = "black")+ xlab("Date") + 
  theme_LaTeX()  + ylab("Avg. Disgust")  + theme(legend.title = element_blank()) + theme(legend.position = "bottom")



df2 %>% filter(TM_BJ_01 != "", party == "Con") %>% filter(!is.na(TM_BJ_01)) %>%  ggplot()  + # coord_cartesian(ylim=c(-1, 1)) +
  geom_smooth(aes(x=month_year, y=ANGER, group = TM_BJ_01, colour = TM_BJ_01)) + geom_vline(xintercept = "2019-07", color = "red") + geom_vline(xintercept = "2019-05", color = "black")+ xlab("Date") + 
  theme_LaTeX()  + ylab("Avg. Anger")  + theme(legend.title = element_blank()) + theme(legend.position = "bottom")

df2 %>% filter(TM_BJ_01 != "", party == "Lab") %>% filter(!is.na(TM_BJ_01)) %>%  ggplot()  + # coord_cartesian(ylim=c(-1, 1)) +
  geom_smooth(aes(x=month_year, y=ANGER, group = TM_BJ_01, colour = TM_BJ_01)) + geom_vline(xintercept = "2019-07", color = "red") + geom_vline(xintercept = "2019-05", color = "black")+ xlab("Date") + 
  theme_LaTeX()  + ylab("Avg. Anger")  + theme(legend.title = element_blank()) + theme(legend.position = "bottom")



df2 %>% filter(party == "Lab", TM_BJ_01 == "")%>%  ggplot()  + coord_cartesian(ylim=c(.15, 0.25)) +
  geom_smooth(aes(x=month_year, y=DISGUST, group = TM_BJ_01, colour = TM_BJ_01)) + geom_vline(xintercept = "2019-07", color = "red") + geom_vline(xintercept = "2019-05", color = "black")+ xlab("Date") + 
  theme_LaTeX()  + ylab("Avg. Disgust") + theme(legend.position = "none")


df2 %>% filter(party == "Con", TM_BJ_01 == "")%>%  ggplot()   + coord_cartesian(ylim=c(.15, 0.25)) +
  geom_smooth(aes(x=month_year, y=DISGUST, group = TM_BJ_01, colour = TM_BJ_01)) + geom_vline(xintercept = "2019-07", color = "red") + geom_vline(xintercept = "2019-05", color = "black")+ xlab("Date") + 
  theme_LaTeX()  + ylab("Avg. Disgust") + theme(legend.position = "none")


df2 %>% filter(party == "Lab", TM_BJ_01 == "")%>%  ggplot()  + coord_cartesian(ylim=c(.125, 0.325)) +
  geom_smooth(aes(x=month_year, y=SHAME, group = TM_BJ_01, colour = TM_BJ_01))+ xlab("Date") + 
  theme_LaTeX()  + ylab("Avg. Shame") + theme(legend.position = "none")
ggsave("./Plots/shame_lab.pdf", device = cairo_pdf, height = 4, width = 8) 

df2 %>% filter(party == "Con", TM_BJ_01 == "")%>%  ggplot()   +  coord_cartesian(ylim=c(.125, 0.325)) +
  geom_smooth(aes(x=month_year, y=SHAME, group = TM_BJ_01, colour = TM_BJ_01)) + xlab("Date") + 
  theme_LaTeX()  + ylab("Avg. Shame") + theme(legend.position = "none")
ggsave("./Plots/shame_con.pdf", device = cairo_pdf, height = 4, width = 8) 

df2 %>% filter(party == "Lab", TM_BJ_01 == "")%>%  ggplot()  + # coord_cartesian(ylim=c(.15, 0.25)) +
  geom_smooth(aes(x=month_year, y=ANGER, group = TM_BJ_01, colour = TM_BJ_01)) + geom_vline(xintercept = "2019-07", color = "red") + geom_vline(xintercept = "2019-05", color = "black")+ xlab("Date") + 
  theme_LaTeX()  + ylab("Avg. Anger") + theme(legend.position = "none")


df2 %>% filter(party == "Con", TM_BJ_01 == "")%>%  ggplot()   +  # coord_cartesian(ylim=c(.15, 0.25)) +
  geom_smooth(aes(x=month_year, y=ANGER, group = TM_BJ_01, colour = TM_BJ_01)) + geom_vline(xintercept = "2019-07", color = "red") + geom_vline(xintercept = "2019-05", color = "black")+ xlab("Date") + 
  theme_LaTeX()  + ylab("Avg. Anger") + theme(legend.position = "none")


df2 %>% filter(party == "Lab", TM_BJ_01 == "")%>%  ggplot()  + # coord_cartesian(ylim=c(.15, 0.25)) +
  geom_smooth(aes(x=month_year, y=SADNESS, group = TM_BJ_01, colour = TM_BJ_01)) + geom_vline(xintercept = "2019-07", color = "red") + geom_vline(xintercept = "2019-05", color = "black")+ xlab("Date") + 
  theme_LaTeX()  + ylab("Avg. Sadness") + theme(legend.position = "none")


df2 %>% filter(party == "Con", TM_BJ_01 == "")%>%  ggplot()   + # coord_cartesian(ylim=c(.15, 0.25)) +
  geom_smooth(aes(x=month_year, y=SADNESS, group = TM_BJ_01, colour = TM_BJ_01)) + geom_vline(xintercept = "2019-07", color = "red") + geom_vline(xintercept = "2019-05", color = "black")+ xlab("Date") + 
  theme_LaTeX()  + ylab("Avg. Sadness") + theme(legend.position = "none")

###################################################################################################
##### Stacked plot of emotions                                                                #####
#################################################################################################㐂

# First I need to collapse all emotions into 

newdat <- df2 %>% select("month_year", "party", "ANGER", "DISGUST", "FEAR", "GUILT", "JOY", 
                         "SADNESS", "SHAME") %>%  pivot_longer(cols = c("ANGER", "DISGUST", "FEAR", "GUILT", "JOY", 
                                                                        "SADNESS", "SHAME"), names_to = "Emotion") %>% na.omit()

newdat_lab <- newdat %>% filter(party == "Lab") %>% group_by(month_year, Emotion) %>% summarize(
    n = sum(value, na.rm = T)
              ) %>% mutate(
                share = n / sum(n, na.rm = T)
                )

newdat_con <- newdat %>% filter(party == "Con") %>% group_by(month_year, Emotion) %>% summarize(
  n = sum(value, na.rm = T)
) %>% mutate(
  share = n / sum(n, na.rm = T)
)


ggplot(newdat_con, aes(x = month_year, y = share, group = Emotion, fill = Emotion)) + 
  geom_area(size=1) + xlab("Date") + ylab("Share") +  theme_LaTeX() +  theme(legend.position = "right") +
  scale_fill_brewer(palette = "Spectral") + scale_colour_brewer(palette = "Spectral")
ggsave("./Plots/emotions_con.pdf", device = cairo_pdf, height = 4, width = 8) 

ggplot(newdat_lab, aes(x = month_year, y = share, group = Emotion, fill = Emotion)) + 
  geom_area(size=1) + xlab("Date") + ylab("Share") +  theme_LaTeX() +  theme(legend.position = "right") +
  scale_fill_brewer(palette = "Spectral") + scale_colour_brewer(palette = "Spectral")
ggsave("./Plots/emotions_lab.pdf", device = cairo_pdf, height = 4, width = 8) 


# Now I look at the Brexit debate based on the term 'Brexit' in the agenda

brexit = df2[str_detect(df2$agenda, regex("withdrawal", ignore_case = T)) | str_detect(df2$agenda, regex("brexit", ignore_case = T)) | str_detect(df2$sentences, regex("brexit", ignore_case = T)) ,]

newdat <- brexit %>% select("month_year", "party", "ANGER", "DISGUST", "FEAR", "GUILT", "JOY", 
                         "SADNESS", "SHAME") %>%  pivot_longer(cols = c("ANGER", "DISGUST", "FEAR", "GUILT", "JOY", 
                                                                        "SADNESS", "SHAME"), names_to = "Emotion") %>% na.omit()

newdat_lab_brexit <- newdat %>% filter(party == "Lab") %>% group_by(month_year, Emotion) %>% summarize(
  n = sum(value, na.rm = T)
) %>% mutate(
  share = n / sum(n, na.rm = T)
)

newdat_con_brexit <- newdat %>% filter(party == "Con") %>% group_by(month_year, Emotion) %>% summarize(
  n = sum(value, na.rm = T)
) %>% mutate(
  share = n / sum(n, na.rm = T)
)

ggplot(newdat_con_brexit, aes(x = month_year, y = share, group = Emotion, fill = Emotion)) + 
  geom_area(size=1) + xlab("Date") + ylab("Share") +  theme_LaTeX() +  theme(legend.position = "right") +
  scale_fill_brewer(palette = "Spectral") + scale_colour_brewer(palette = "Spectral") 
ggsave("./Plots/emotions_con_braxit.pdf", device = cairo_pdf, height = 4, width = 8) 

ggplot(newdat_lab_brexit, aes(x = month_year, y = share, group = Emotion, fill = Emotion)) + 
  geom_area(size=1) + xlab("Date") + ylab("Share") +  theme_LaTeX() +  theme(legend.position = "right") +
  scale_fill_brewer(palette = "Spectral") + scale_colour_brewer(palette = "Spectral") + ggtitle("There's little joy in Brexit for Labour...")
ggsave("./Plots/emotions_lab_brexit.pdf", device = cairo_pdf, height = 4, width = 8) 

# And finally I compare sentences metioning a person to thoes mentioning an NORP (nationalities,religious, political)

person = df2[str_detect(df2$ners, regex("'PERSON'", ignore_case = F)) ,] # I do not yet account for the fact that multiple entity types may be present

norp = df2[str_detect(df2$ners, regex("'NORP'", ignore_case = F)) ,]

newdat_norp <- person %>% select("month_year", "party", "ANGER", "DISGUST", "FEAR", "GUILT", "JOY", 
                            "SADNESS", "SHAME") %>%  pivot_longer(cols = c("ANGER", "DISGUST", "FEAR", "GUILT", "JOY", 
                                                                           "SADNESS", "SHAME"), names_to = "Emotion") %>% na.omit()

newdat_pers <- norp %>% select("month_year", "party", "ANGER", "DISGUST", "FEAR", "GUILT", "JOY", 
                            "SADNESS", "SHAME") %>%  pivot_longer(cols = c("ANGER", "DISGUST", "FEAR", "GUILT", "JOY", 
                                                                           "SADNESS", "SHAME"), names_to = "Emotion") %>% na.omit()

newdat_lab_pers <- newdat_pers %>% filter(party == "Lab") %>% group_by(month_year, Emotion) %>% summarize(
  n = sum(value, na.rm = T)
) %>% mutate(
  share = n / sum(n, na.rm = T)
)

newdat_con_pers <- newdat_pers %>% filter(party == "Con") %>% group_by(month_year, Emotion) %>% summarize(
  n = sum(value, na.rm = T)
) %>% mutate(
  share = n / sum(n, na.rm = T)
)

newdat_lab_norp <- newdat_norp %>% filter(party == "Lab") %>% group_by(month_year, Emotion) %>% summarize(
  n = sum(value, na.rm = T)
) %>% mutate(
  share = n / sum(n, na.rm = T)
)

newdat_con_norp <- newdat_norp %>% filter(party == "Con") %>% group_by(month_year, Emotion) %>% summarize(
  n = sum(value, na.rm = T)
) %>% mutate(
  share = n / sum(n, na.rm = T)
)

ggplot(newdat_con_pers, aes(x = month_year, y = share, group = Emotion, fill = Emotion)) + 
  geom_area(size=1) + xlab("Date") + ylab("Share") +  theme_LaTeX() +  theme(legend.position = "right") +
  scale_fill_brewer(palette = "Spectral") + scale_colour_brewer(palette = "Spectral")
ggsave("./Plots/emotions_con_pers.pdf", device = cairo_pdf, height = 4, width = 8) 

ggplot(newdat_lab_pers, aes(x = month_year, y = share, group = Emotion, fill = Emotion)) + 
  geom_area(size=1) + xlab("Date") + ylab("Share") +  theme_LaTeX() +  theme(legend.position = "right") +
  scale_fill_brewer(palette = "Spectral") + scale_colour_brewer(palette = "Spectral") + ggtitle("...though persons don't seem to get a nice verbal treatment?")
ggsave("./Plots/emotions_lab_pers.pdf", device = cairo_pdf, height = 4, width = 8) 

ggplot(newdat_con_norp, aes(x = month_year, y = share, group = Emotion, fill = Emotion)) + 
  geom_area(size=1) + xlab("Date") + ylab("Share") +  theme_LaTeX() +  theme(legend.position = "right") +
  scale_fill_brewer(palette = "Spectral") + scale_colour_brewer(palette = "Spectral")
ggsave("./Plots/emotions_con_norp.pdf", device = cairo_pdf, height = 4, width = 8) 

ggplot(newdat_lab_norp, aes(x = month_year, y = share, group = Emotion, fill = Emotion)) + 
  geom_area(size=1) + xlab("Date") + ylab("Share") +  theme_LaTeX() +  theme(legend.position = "right") +
  scale_fill_brewer(palette = "Spectral") + scale_colour_brewer(palette = "Spectral") + ggtitle("...but slightly more towards nationalities/groups...")
ggsave("./Plots/emotions_lab_norp.pdf", device = cairo_pdf, height = 4, width = 8) 




