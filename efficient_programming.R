
# Install Packages
pkgs = c("compiler", "memoise", "microbenchmark")
# install.packages(pkgs)
lapply(pkgs, library, character.only = TRUE)

options(digits = 2)


#
# Memory allocation
#

method1 = function(n){
	vec = NULL
	for (i in seq_len(n))
		vec = c(vec, i)
	vec
}

method2 = function(n){
	vec = numeric(n)
	for (i in seq_len(n))
		vec[i] = i
	vec
}

method3 = function(n) seq_len(n)


n = 10^4
microbenchmark(times = 100, unit = "s",
	method1(n), method2(n), method3(n))

# Monte-Carlo example
monte_carlo = function(N){
	hits = 0
	for (i in seq_len(N)){
		u1 = runif(1)
		u2 = runif(1)
		if (u1^2 > u2)
			hits = hits +1
	}
	return(hits/N)
}

monte_carlo_vec = function(N) sum(runif(N)^2 > runif(N))/N

N = 500000
system.time(monte_carlo(N))
system.time(monte_carlo_vec(N))


#
# Factors, mainly used for categorical data
#

x = 4:6
c(x)
c(factor(x))

#
# The apply family
#
# install.packages("ggplot2movies")
data(movies, package = "ggplot2movies")

ratings = movies[,7:16]

popular = array(ratings, 1, nnet::which.is.max)
plot(table(popular))

#
# Caching variables
#

plot_mpg = function(row_to_remove){
	data(mpg, package = "ggplot2")
	mpg = mpg[-row_to_remove,]
	plot(mpg$cty, mpg$hwy)
	lines(lowess(mpg$cty, mpg$hwy), col = 2)
}

m_plot_mpg = memoise(plot_mpg)
microbenchmark(times = 10, unit = "ms", m_plot_mpg(10), plot_mpg(10))

#
# Function closures
#

stop_watch = function(){
	start_time = stop_time = NULL
	start = function() start_time <<- Sys.time()
	stop = function(){
		stop_time <-Sys.time()
		difftime(stop_time, start_time)
	}
	list(start = start, stop = stop)
}

watch = stop_watch()
watch$start()
watch$stop()