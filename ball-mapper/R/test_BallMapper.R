test_that("Test BallMapper of cyclic graph",
{
  rm(list=ls())
  #source("BallMapper.R")
  arg <- seq(from=0,to=6.2,by = 0.1)
  points <- as.data.frame( cbind( sin(arg),cos(arg) ) )
  values <- as.data.frame( sin(arg) )
  epsilon <- 0.25
  l <- BallMapper(points,values,epsilon)

  #test vertices
  id <- c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21)
  size <- c(7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7)
  expected_vert = cbind( id , size  )
  expect_equal( all(expected_vert == l$vertices) , TRUE )

  #test edges
  from = c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20, 1)
  to = c(2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,21)
  expected_edges = cbind(from,to)
  expect_equal( all(expected_edges == l$edges) , TRUE )

  #test of edges_strength
  expected_edges_strength = c(2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2)
  expect_equal( all(expected_edges_strength == l$edges_strength) , TRUE )

  #test points_covered_by_landmarks
  expected_points_covered_by_landmarks <-  list()
  expected_points_covered_by_landmarks[[1]]<-c(1,2,3,62,63)
  expected_points_covered_by_landmarks[[2]]<-c(2,3,4,5,6)
  expected_points_covered_by_landmarks[[3]]<-c(5,6,7,8,9)
  expected_points_covered_by_landmarks[[4]]<-c(8,9,10,11,12)
  expected_points_covered_by_landmarks[[5]]<-c(11,12,13,14,15)
  expected_points_covered_by_landmarks[[6]]<-c(14,15,16,17,18)
  expected_points_covered_by_landmarks[[7]]<-c(17,18,19,20,21)
  expected_points_covered_by_landmarks[[8]]<-c(20,21,22,23,24)
  expected_points_covered_by_landmarks[[9]]<-c(23,24,25,26,27)
  expected_points_covered_by_landmarks[[10]]<-c(26,27,28,29,30)
  expected_points_covered_by_landmarks[[11]]<-c(29,30,31,32,33)
  expected_points_covered_by_landmarks[[12]]<-c(32,33,34,35,36)
  expected_points_covered_by_landmarks[[13]]<-c(35,36,37,38,39)
  expected_points_covered_by_landmarks[[14]]<-c(38,39,40,41,42)
  expected_points_covered_by_landmarks[[15]]<-c(41,42,43,44,45)
  expected_points_covered_by_landmarks[[16]]<-c(44,45,46,47,48)
  expected_points_covered_by_landmarks[[17]]<-c(47,48,49,50,51)
  expected_points_covered_by_landmarks[[18]]<-c(50,51,52,53,54)
  expected_points_covered_by_landmarks[[19]]<-c(53,54,55,56,57)
  expected_points_covered_by_landmarks[[20]]<-c(56,57,58,59,60)
  expected_points_covered_by_landmarks[[21]]<-c(59,60,61,62,63)
  for ( i in 1:length(expected_points_covered_by_landmarks) )
  {
    expect_equal( all(expected_points_covered_by_landmarks[[i]] == l$points_covered_by_landmarks[[i]]) , TRUE )
  }

  #test landmarks:
  expected_landmarks <- c(1,4,7,10,13,16,19,22,25,28,31,34,37,40,43,46,49,52,55,58,61)
  expect_equal( all(expected_landmarks == l$landmarks) , TRUE )

  #test coloring:
  expected_coloring <- c(0.006650168,0.292573367,0.559012026,0.775515807,0.922745069,0.987548263,0.964136712,0.854601699,0.668727662,0.423118175,0.139712801,-0.156172701,-0.438107761,-0.680907959,-0.862884678,-0.967782478,-0.986231151,-0.916582734,-0.765058710,-0.545194270,-0.276629250)
  expect_equal( all(abs(expected_coloring - l$coloring)<0.00000001) , TRUE )

  #test for coverage:
  expected_coverage <-  list()
  expected_coverage[[1]]<- c(1)
  expected_coverage[[2]]<- c(1,2)
  expected_coverage[[3]]<- c(1,2)
  expected_coverage[[4]]<- c(2)
  expected_coverage[[5]]<- c(2,3)
  expected_coverage[[6]]<- c(2,3)
  expected_coverage[[7]]<- c(3)
  expected_coverage[[8]]<- c(3,4)
  expected_coverage[[9]]<- c(3,4)
  expected_coverage[[10]]<- c(4)
  expected_coverage[[11]]<- c(4,5)
  expected_coverage[[12]]<- c(4,5)
  expected_coverage[[13]]<- c(5)
  expected_coverage[[14]]<- c(5,6)
  expected_coverage[[15]]<- c(5,6)
  expected_coverage[[16]]<- c(6)
  expected_coverage[[17]]<- c(6,7)
  expected_coverage[[18]]<- c(6,7)
  expected_coverage[[19]]<- c(7)
  expected_coverage[[20]]<- c(7,8)
  expected_coverage[[21]]<- c(7,8)
  expected_coverage[[22]]<- c(8)
  expected_coverage[[23]]<- c(8,9)
  expected_coverage[[24]]<- c(8,9)
  expected_coverage[[25]]<- c(9)
  expected_coverage[[26]]<- c(9,10)
  expected_coverage[[27]]<- c(9,10)
  expected_coverage[[28]]<- c(10)
  expected_coverage[[29]]<- c(10,11)
  expected_coverage[[30]]<- c(10,11)
  expected_coverage[[31]]<- c(11)
  expected_coverage[[32]]<- c(11,12)
  expected_coverage[[33]]<- c(11,12)
  expected_coverage[[34]]<- c(12)
  expected_coverage[[35]]<- c(12,13)
  expected_coverage[[36]]<- c(12,13)
  expected_coverage[[37]]<- c(13)
  expected_coverage[[38]]<- c(13,14)
  expected_coverage[[39]]<- c(13,14)
  expected_coverage[[40]]<- c(14)
  expected_coverage[[41]]<- c(14,15)
  expected_coverage[[42]]<- c(14,15)
  expected_coverage[[43]]<- c(15)
  expected_coverage[[44]]<- c(15,16)
  expected_coverage[[45]]<- c(15,16)
  expected_coverage[[46]]<- c(16)
  expected_coverage[[47]]<- c(16,17)
  expected_coverage[[48]]<- c(16,17)
  expected_coverage[[49]]<- c(17)
  expected_coverage[[50]]<- c(17,18)
  expected_coverage[[51]]<- c(17,18)
  expected_coverage[[52]]<- c(18)
  expected_coverage[[53]]<- c(18,19)
  expected_coverage[[54]]<- c(18,19)
  expected_coverage[[55]]<- c(19)
  expected_coverage[[56]]<- c(19,20)
  expected_coverage[[57]]<- c(19,20)
  expected_coverage[[58]]<- c(20)
  expected_coverage[[59]]<- c(20,21)
  expected_coverage[[60]]<- c(20,21)
  expected_coverage[[61]]<- c(21)
  expected_coverage[[62]]<- c(1,21)
  expected_coverage[[63]]<- c(1,21)
  for ( i in 1:length(expected_coverage) )
  {
    expect_equal( all(expected_coverage[[i]] == l$coverage[[i]]) , TRUE )
  }

  #Test of the function pointToBallList
  vertices <- c(1,2,2,3,3,4,5,5,6,6,7,8,8,9,9,10,11,11,12,12,13,14,14,15,15,16,17,17,18,18,19,20,20,21,21,22,23,23,24,24,25,26,26,27,27,28,29,29,30,30,31,32,32,33,33,34,35,35,36,36,37,38,38,39,39,40,41,41,42,42,43,44,44,45,45,46,47,47,48,48,49,50,50,51,51,52,53,53,54,54,55,56,56,57,57,58,59,59,60,60,61,62,62,63,63)
  coveringBalls <- c(1,1,2,1,2,2,2,3,2,3,3,3,4,3,4,4,4,5,4,5,5,5,6,5,6,6,6,7,6,7,7,7,8,7,8,8,8,9,8,9,9,9,10,9,10,10,10,11,10,11,11,11,12,11,12,12,12,13,12,13,13,13,14,13,14,14,14,15,14,15,15,15,16,15,16,16,16,17,16,17,17,17,18,17,18,18,18,19,18,19,19,19,20,19,20,20,20,21,20,21,21,1,21,1,21)
  expect_equal( all(pointToBallList(l$coverage)[,1] == vertices) , TRUE )
  expect_equal( all(pointToBallList(l$coverage)[,2] == coveringBalls) , TRUE )
}
)


test_that("Test coloring as a distance from reference points in  BallMapper",
{
  rm(list=ls())
  arg <- seq(from=0,to=6.2,by = 0.1)
  points <- as.data.frame( cbind( sin(arg),cos(arg) ) )
  reference_points <- as.data.frame(points[30:35,1:2])
  new_coloring_functions <- color_by_distance_to_reference_points( points , reference_points )
  newColoringMin <- (c(1.98332962,1.97089946,1.95144672,1.92711637,1.89796924,1.86407817,1.82552788,1.78241472,1.73484645,1.68294197,1.62683101,1.56665382,1.50256081,1.43471218,1.36327752 ,1.28843537, 1.21037281, 1.12928495, 1.04537446, 0.95885108,  0.86993107, 0.77883668, 0.68579561, 0.59104041, 0.49480792, 0.39733866, 0.29887626, 0.19966683,0.09995834, 0.00000000,  0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.09995834, 0.19966683, 0.29887626, 0.39733866, 0.49480792,  0.59104041, 0.68579561, 0.77883668, 0.86993107, 0.95885108, 1.04537446, 1.12928495, 1.21037281, 1.28843537, 1.36327752,  1.43471218, 1.50256081, 1.56665382, 1.62683101, 1.68294197, 1.73484645, 1.78241472, 1.82552788, 1.86407817, 1.89796924,  1.92711637, 1.95144672, 1.97089946))
  newColoringAV <- (c(1.9926984,1.9906267,1.9835795,1.9715743,1.9546413,1.9328227,1.9061730,1.8747588,1.8386588,1.7979631,1.7527734,1.7032026,1.6493748,1.5914244,1.5294962,1.4637451,1.3943354,1.3214406,1.2452429,1.1659327,1.0837083,0.9987752,0.9113456,0.8216382,0.7298771,0.6362917,0.5411159,0.4445876,0.3469481,0.2484413,0.1826331,0.1496878,0.1496878,0.1826331,0.2484413,0.3469481,0.4445876,0.5411159,0.6362917,0.7298771,0.8216382,0.9113456,0.9987752,1.0837083,1.1659327,1.2452429,1.3214406,1.3943354,1.4637451,1.5294962,1.5914244,1.6493748,1.7032026,1.7527734,1.7979631,1.8386588,1.8747588,1.9061730,1.9328227,1.9546413,1.9715743,1.9835795,1.9906267))
  expect_equal( all(abs(new_coloring_functions[,1] - newColoringMin)<0.0000001) , TRUE )
  expect_equal( all(abs(new_coloring_functions[,2] - newColoringAV)<0.0000001) , TRUE )
}
)


#test_that("Test based on the procedure that write structure of Ball Mapper to file",
#{
#   rm(list=ls())
#   arg <- seq(from=0,to=6.2,by = 0.1)
#   points <- as.data.frame( cbind( sin(arg),cos(arg) ) )
#   values <- as.data.frame( sin(arg) )
#   l <- BallMapper( points,values, 0.1 )
#   storeBallMapperGraphInFile( l , "test" )
#   r <- readBallMapperGraphFromFile( "test" )
#
#
#
#   expect_equal( all( l$vertices == r$vertices) , TRUE )
#   expect_equal( all( l$edges == r$edges) , TRUE )
#   expect_equal( all(abs(l$edges_strength-r$edges_strength)<0.0000001) , TRUE )
#   for ( i in 1:length(l$points_covered_by_landmarks) )
#   {
#      expect_equal( all( l$points_covered_by_landmarks[[i]] == r$points_covered_by_landmarks[[i]]) , TRUE )
#   }
#
#   expect_equal( all( l$landmarks == r$landmarks) , TRUE )
#   expect_equal( all(abs(l$coloring-r$coloring)<0.0000001) , TRUE )
#
#   for ( i in 1:length(l$coverage) )
#   {
#     expect_equal( all( l$coverage[[i]] == r$coverage[[i]]) , TRUE )
#   }
#}
#)
