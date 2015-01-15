################################################################################
## Matrix inversion of larger matrices can be a be a costly excersize, the 
## methods contained in this file provide a capability to store both the 
## original matrix and a calculated inverse value. This allows for a 
## check/fetch or caclulate/store action to take place which in the event of 
## continuous inversion requests over the same data set will drastically 
## reduce execution time during heavy simulations.
##
## example usage of these functions:
##
## sqmatrix <- replicate(10, rnorm(10))  # creates a random 10x10 matrix 
##
## cached <- makeCacheMatrix(sqmatrix)
## cacheSolve(cached) # first time inverse is calculated and returned
## cacheSolve(cached) # subsequence requests return cached inverse
##  
## sqmatrix <- replicate(10, rnorm(10))  # creates a new random 10x10 matrix 
## cached$set(sqmatrix) # stores the matrix and sets the cached 
##                                      inverse value to NULL
## cacheSolve(cached) # inverse is re-calculated and returned
################################################################################




## makeCacheMatrix - Creates a special matix object that can cache its inverse
##
## Args:
##   - m_matrix: matrix
##
## Usage:
## - To create a new object:
##        my_cached_matrix <- makeCacheMatrix(square_matrix)
## - set and get the matrix using:
##        my_cache_matrix$set(square_matrix)
##        my_cache_matrix$get()
## - set and get the inverse using:
##        my_cache_matrix$setinverse(square_matrix)
##        my_cache_matrix$getinverse()
##
## Returns:
##   an object with getters and setters for the matrix itself get(), set(value) and 
##   the inverse value getinverse(), setinverse(value)
##
makeCacheMatrix <- function(m_matrix = matrix()) {
  
  m_value <- NULL
  set <- function(y) {
    m_matrix <<- y
    m_value <<- NULL
  }
  
  get <- function() m_matrix
  setinverse <- function(val) m_value <<- val
  getinverse <- function() m_value
  
  list(set = set, 
       get = get,
       setinverse = setinverse,
       getinverse = getinverse)
}


## cacheSolve - Creates a special matix object that can cache its inverse
##
## Args:
##   - cachematrix: cachematrix special object
##
## Returns:
##   a matrix that is the inverse of that stored in the cachematrix object.
##
##   if the matrix stored in the cachematrix has not been altered and the solve 
##   operation previously performed then it returns the cached inverse value, 
##   otherwise it wil compute the inverse store and return that value. If the 
##   matrix stored is not a square matrix this function returns NULL
##
################################################################################
cacheSolve <- function(cachematrix, ...) {
        ## Return a matrix that is the inverse of 'x'
  m_inverse <- cachematrix$getinverse()
  if(!is.null(m_inverse)) {
    message("getting cached data")
    return(m_inverse)
  }
  m_data <- cachematrix$get()
  m_inverse <- solve(m_data, ...)
  cachematrix$setinverse(m_inverse)
  m_inverse
}
