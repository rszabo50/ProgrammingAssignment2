### Introduction


Matrix inversion of larger matrices can be a be a costly excersize, the
methods contained in this file provide a capability to store both the
original matrix and a calculated inverse value. This allows for a
check/fetch or caclulate/store action to take place which in the event of
continuous inversion requests over the same data set will drastically
reduce execution time during heavy simulations.


### Usage

sqmatrix <- replicate(10, rnorm(10))  # creates a random 10x10 matrix

cached <- makeCacheMatrix(sqmatrix)

cacheSolve(cached) # first time inverse is calculated and returned

cacheSolve(cached) # subsequence requests return cached inverse

sqmatrix <- replicate(10, rnorm(10))  # creates a new random 10x10 matrix

cached$set(sqmatrix) # stores the matrix and sets the cached
                       inverse value to NULL

cacheSolve(cached) # inverse is re-calculated and returned
