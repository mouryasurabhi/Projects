############## First implementation of the collapsed Gibbs sampler for the LDA #################

# For the mathematics formula and the notation : cf Wikipedia

#To implemente TargetDistrib : we first need to count the words of a certain theme in a doc

CountWords <- function(Z,W,topic,exclude,doc,voc){
  
  ## Count the number of words in doc of the same topic if voc = 0 
  ## If voc > 0 : count the words that are the voc-th in the Vocabluray and of the same topic 
  
  Corpus <- Z
  Corpus[[exclude[1]]][exclude[2]] <- NA #We exclude the topic of this word
  count <- 0
  
  if (voc == 0){
      
    for (d in 1:length(doc)){
      document <- Corpus[[doc[d]]]
      for (i in 1:length(document)){
        if (document[i]==topic){
          count <- count + 1
        }
      }  
  }
  }
  else{
    
    for (d in 1:length(doc)){
      document <- Corpus[[doc[d]]]
      Word_Doc <- W[[doc[d]]]
    
      for (j in 1:lenght(document)){
        
          if ((document[j]==topic) & (Word_Doc[j] == voc)){
            count <- count + 1
          }
        }  
    }
  }
  return(count)
}

# Pb : Huge complexity for massive application : last step of the project : find a solution
#V : Liste de tous les mots
#W : Liste de tous les mots PAR DOCUMENT

TargetDistrib <- function(Z,W,V,alpha,beta,val){
  
  ## Define the target distribution g evaluated for the value val
  ## We want the probability that n-th word of m-th document has v for topic
  ## So we will exclude this sample of the conditionnal (Gibbs Sampler)
  
  m <- val[1] # Document m
  n <- val[2] # Mot n
  v <- val[3] # Topic v
  
  top <- { (alpha[k] + 1 + CountWords(Z,W,topic=v,exclude=c(m,n),doc=c(m),voc=0)) * (beta[v] + 1 + CountWords(Z,W,topic=k,exclude=c(m,n),doc=1:length(Z),voc = W[[m]][n])) }
  
  bottom <- 0
  
  for (i in 1:length(V)){
    
    bottom <- bottom + CountWords(Z,W,topic=v,exclude=c(m,n),doc=1:length(Z),voc=V[i]) + beta[i] + 1
    
  }
  
  return(top/bottom)
}

## Finally : Let's implemente the Collapsed Gibbs Sampler :

CollapsedGibbsSampler <- function(N,W,V,alpha,beta,X0,K){
  
  X <- X0
  X.before <- X0
  
  for (i in 1:N){
    
    X.new <- X.before
    m.max <- length(X.new)
    
    X.star <- matrix(rep(NA,n.max*m.max),nrow=n.max)
    
    for (m in 1:m.max){
      
      for (n in 1:length(X.new[m])){
          
          topic <- sample(K,1) #On choisit le thème de manière uniforme
          val <- c(m,n,topic)
          X.star[[m]][n] = TargetDistrib(X.new,W,V,alpha,beta,k,val)
      }
    } 
    
    X <- c(X,X.star)
    X.before <- X.star
  }
  return(X)
}

########TEST : Application à divers articles de Wikipedia########
library(rvest)
library(tidyverse)

# Créer le tibble avec les textes

## Une fonction pour scraper et créer un df 

## cf internet : copié/collé

scrape_wiki <- function(url){
  url <- read_html(url)
  df <- tibble(text = url %>% html_nodes("p") %>% html_text(), 
               name = url %>% html_nodes("h1") %>% html_text())
  return(df)
}
url_list <- c("https://en.wikipedia.org/wiki/Marcel_Proust",
              "https://en.wikipedia.org/wiki/Natural_logarithm",
              "https://en.wikipedia.org/wiki/Radiohead")

data_Proust <- scrape_wiki(url_list[1])$text
data_log <- scrape_wiki(url_list[2])$text
data_Radiohead <- scrape_wiki(url_list[3])$text

## To reduce the data : we keep only one paragraph per corpus : the one with the more words

data_Proust <- data_Proust[which.max(str_count(data_Proust))]
data_Radiohead <- data_Radiohead[which.max(str_count(data_Radiohead))]
data_log <- data_log[which.max(str_count(data_log))]

data_Radiohead

## Remove the punctuation 

data_Radiohead <- gsub("[[:punct:]]", " ", data_Radiohead)
data_log <- gsub("[[:punct:]]", " ", data_log)
data_Proust <- gsub("[[:punct:]]", " ", data_Proust)
data_Proust <- gsub("[\n]", " ", data_Proust) #This was not a word.
data_Radiohead #It worked.

#Implement N : Number of words
test <- "Je compte actuellement 5 mots"
sapply(strsplit(test, " "), length) #Worked
N_Radiohead <- sapply(strsplit(data_Radiohead, " "), length)
N_Proust <- sapply(strsplit(data_Proust, " "), length)
N_log <- sapply(strsplit(data_log, " "), length)
N <- N_Radiohead+N_Proust+N_log
N #Number of words

#From text to list of words

####TO DO : Transform the text into a list of words 
####Then, the code to create W_int will work

test <- 



#Choice of topics : 

K <- 6 #Arbitrary

## Choice of alpha and beta

## First : no choice on alpha and beta :

alpha <- runif(n=K,min=0,max=1.5)
beta <- runif(n=N,min=0,max=1.5)


##Implement V (Give a number to each word) and W (idem but for each document)

#First stp : Gives an integer to each word, the same if words are the same

W_str <- list('Radiohead'=data_Radiohead,'Proust'=data_Proust,'log'=data_log)
W_int <- list(rep(NA,N_Radiohead),rep(NA,N_Proust),rep(NA,N_log))
k<-1
Integer_dico <- list()
for (doc in 1:3){
  for (i in 1:length(W_int[[doc]])){
    word <- W_str[[doc]][i]
    if(is.element(word, names(Integer_dico))){
      W_int[[doc]][i] <- Integer_dico$word
    }
    else{
      W_int[[doc]][i] <- k
      Integer_dico[[word]] = c(Integer_dico[[word]],k) #Mise à jour du dictionnaire
      k <- k+1
    }
  }
}
W_int

#V <- Join sur les documents de W

##Create W
theta <- dirichlet(beta)
W <- list('Radiohead'=rep(NA,N_Radiohead),'Proust'=rep(NA,N_Proust),'log'=rep(NA,N_log))
for (doc in 1:3){
  for i in (1:length(W[[doc]])){
    W[[doc]][i] <- theta[W_int[[doc]][i]] #Gives a probability to the words considering a uniform on a Dirichlet
  }
}