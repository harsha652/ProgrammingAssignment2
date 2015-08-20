## makeCacheMatrix function creates a list of four function
## cacheSolve checks if calculated inversion matrix is present
## If it is present it will return the calculated version, if the inversion result is not present,
## it will calculate the inverse and returns

## The function creates a list that contains four functions: set, get, setsolve, getsolve

makeCacheMatrix <- function(x = matrix()) {

        m <- NULL              #The result of inversion is stored in m
        #A Setter function is used to set a matrix to object created by makeCacheMatrix function
        set <- function(y){
                x <<- y
                m <<- NULL
        }
        get <- function() x   # Return the input matrix
        setsolve <- function(solve) m <<- solve # Set the inversed matrix
        getsolve <- function()m                     # Return the inversed matrix
        #return a list that contains these functions, so that we can use
        #makeCacheMatrix object like these
        #x <- makeCacheMatrix(testmatrix)
        #x$set(newmatrix) # to change matrix
        #x$get # to get the setted matrix
        # x$setInv # to set the inversed matrix
        # x$getInv # to get the inversed matrix
        list(set = set, get = get, setsolve = setsolve, getsolve = getsolve)

}

## cacheSolve checks if calculated inversion matrix is present
## If it is present it will return the calculated version,
## it will calculate and return the inverse of 'x'


cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'

	m <- x$getsolve()   #get the inversed matrix from object x
	#it will be null if uncalculated
	if(!is.null(m)) # Checks if the inversion result is there
	{
  	   message("getting cached data")
  	   return(m)    #returns calculated inversion
	}
	data <- x$get()   #If the inversion result is not present, we do x$get to get the matrix object
	m <- solve(data, ...)   #solve it
	x$setsolve(m)        #it is set to the object
	m #return the solved result
}