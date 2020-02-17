hsbsimu<- function(N,n.balls=12,D=0.2,prop.sd=0.001){
  
  target.dens<-function(x,y){
    pairwise.dist<-as.numeric(dist(cbind(x,y)))
   
    ans<- all(x>=(0.5*D))&&all(x<=(1-0.5*D))&&all(y>=(0.5*D))&&
      all(y<=(1-0.5*D))&&all(pairwise.dist>=D)
    
    return(as.numeric(ans))
  }
  
  grid.x<-grid.y<-seq(0.5*D.1-0.5*D,by=D)
  grid<-expand(grid.x,grid.y)
  idx.x<-sample(length(grid.x),n.balls)
  idy.y<-sample(length(grid.y),n.balls)
  init.x<-grid.x[idx.x]
  init.y<-grid.y[idy.y]
  
  chain.x<-chain.y<-matrix(NA,N+1,n.balls)
  chain.x[1,]<-init.x
  chain.y[1,]<-init.y
  
  for (iter in 1:N){
    #prposition 1
    prop.x<-rnorm(n.balls,chain.x[iter,],prop.sd)
    prop.y<-rnorm(n.balls,chain.y[iter,],prop.sd)
    
    top<-target.dens(prop.x,prop.y)*
      prod(dnorm(chain.x[iter,],prop.x,prop.sd))*
      prod(dnorm(chain.y[iter,],prop.y,prop.sd))
    
    bottom<-target.dens(chain.x[iter,],chain.y[iter,])*
      prod(dnorm(chain.x[iter,],prop.x,prop.sd))*
      prod(dnorm(chain.y[iter,],prop.y,prop.sd))
    
    acc.prob<top/bottom
    print(acc.prob)
    
    #metropolis hastngs
    if(runif(1)>acc.prob){
      chain.x[iter+1,]<-prop.x
      chain.y[iter+1,]<-prop.y
    }else{
      chain.x[iter+1,]<-chain.x[iter,]
      chain.y[iter+1,]<-cahin.y[iter,1]
    }
  }
  return(list(chain.x=chain.x,chain.y=chain.y))
}