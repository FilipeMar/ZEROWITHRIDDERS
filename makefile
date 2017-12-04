#makefile

objects = ZerowithRidders.o testing.o #order of compilation
exe = testing
Comp = gfortran   #gnu compiler; /usr/bin/ifort # Intel compiler
FFLAGS1 = -c -std=f2008 -Wextra -Wall -pedantic -fbounds-check
FFLAGS2 = -o #FFLAGS = -g
FFLAGS = -O3

$(exe) : $(objects)
	$(Comp) ${FFLAGS} ${FFLAGS2} testing $(objects)

#ZerowithRidders.o : ZerowithRidders.f08
#	$(Comp) ${FFLAGS} ${FFLAGS1} ZerowithRidders.f08

#testing.o : testing.f08
#	$(Comp) ${FFLAGS} ${FFLAGS1} testing.f08 ZerowithRidders.mod

%.o : %.f08
	$(Comp) ${FFLAGS} ${FFLAGS1} $<

clean:
	rm -f $(exe)

cleanall:
	rm $(exe) $(objects) *.mod

#1
#gfortran -c -std=f2008 -Wextra -Wall -pedantic -fbounds-check -O3 optim.f08
#2
#gfortran -c -std=f2008 -Wextra -Wall -pedantic -fbounds-check -O3 testing.f08 optim.mod
#3
#gfortran -o testing -O3 testing.o optim.o
#4
#./testing
