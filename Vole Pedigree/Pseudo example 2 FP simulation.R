#Pseudo example 2, simulation

I=12 #number of litters
J=rep(c(2,2,4,5,6,7), 2) #number of individuals/litter
sim.diff=0 #treatment effect
sd.litter=1 #difference between litters
sd.res=0.5 #difference within litter


pseud <- function(J){
  litter.ID=rep(c(1:I), each=J)
  animal.ID=sequence(J)
  treat.ID=rep(c(0,1), each=0.5*length(animal.ID)) #each group with parallel litter sizes
  
  mean.0=rep(rnorm(n=0.5*I, mean=0, sd=sd.litter), times=J[1:c(0.5*I)])
  mean.1=rep(rnorm(n=0.5*I, mean=sim.diff, sd=sd.litter), times=J[1:c(0.5*I)])
  y=rnorm(n=sum(J), mean=c(mean.0, mean.1), sd=sd.res)
  
  #Create Df
  data <- as.data.frame(cbind(litter.ID, animal.ID, treat.ID, y), row.names = NULL)
  
  #Type I errors
  p<- summary(lm(y~treat.ID, data=data))$coefficient[8]
  return(p)
}

sim.results<- do.call(rbind, lapply(1:1000, function(x) pseud())) #df of 1000 pvalues
sim.results

result<- t(do.call(cbind, mclapply(1:1000, function(x) do.call(rbind, lapply(J, function(x) pseud(x))), mc.cores = 4, mc.cleanup = TRUE)))

#Calculate Type I Error rate
prop <- function(x){
  pr <- length(x[x<0.05])/1000 #1000--> number of rows
  return(pr)
}
type <- apply(sim.results, 2, prop)
type

#False positive, with two groups of n=9
I=2 #number of groups
J=9 #number of individuals/group
sim.diff=0 #treatment effect
sd.group= 0#1 #difference between groups
sd.animal=1  #0.5 #difference within group


pseud <- function(J){
  group.ID=rep(c(1:I), each=J)
  animal.ID=sequence(rep(J, times=I))
  treat.ID=rep(c(0,1), each=0.5*length(animal.ID)) #each group with parallel litter sizes
  
  mean.0=rep(rnorm(n=0.5*I, mean=0, sd=sd.group), times=J)
  mean.1=rep(rnorm(n=0.5*I, mean=sim.diff, sd=sd.group), times=J)
  y=rnorm(n=J*I, mean=c(mean.0, mean.1), sd=sd.res)
  
  #Create Df
  data <- as.data.frame(cbind(group.ID, animal.ID, treat.ID, y), row.names = NULL)
  
  #Type I errors
  p<- summary(lm(y~treat.ID, data=data))$coefficient[8]
  return(p)
}

sim.results<- do.call(rbind, lapply(1:1000, function(x) pseud(J))) #df of 1000 pvalues
hist(sim.results)

library(parallel)
  result<- t(do.call(cbind, mclapply(1:1000, function(x) do.call(rbind, lapply(J, function(x) pseud(x))), mc.cores = 4, mc.cleanup = TRUE))) #WHAT IS THIS FOR?!?

#Calculate Type I Error rate
prop <- function(x){
  pr <- length(x[x<0.05])/1000 #1000--> number of rows
  return(pr)
}
type <- apply(sim.results, 2, prop)
type


#With independent samples
#False positive, with two groups of n=9

y = rnorm(n=J*I, mean=0, sd=sd.animal)


