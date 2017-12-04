module ZerowithRidders

    use iso_fortran_env
    implicit none

    INTEGER, parameter :: qp = REAL64
    INTEGER, parameter :: maxi = 2000
    REAL(qp), parameter :: tol = 1.E-6

    abstract interface
        pure function ResidualFunction(x,parameters)
            Double precision, intent(in) :: x
            Double precision, intent(in), optional :: parameters(:)
            Double precision :: ResidualFunction
        end function ResidualFunction
    end interface

contains
    pure function FINDZEROWITHRIDDERS( ResidualFuncao, parameters, x_min, x_max )

        !use iso_fortran_env
        implicit none

        !!! declarações

        !maxi = < Maximum iterations number >
        !ε := < Tolerance value for the residual >
        ! varin := < variable value at left boundary >
        ! varout := < variable value at right boundary >
        ! resin :=ResidualFunction(varin;...)
        ! resout :=ResidualFunction(varout;...)
        !INTEGER, parameter :: maxi = 2000
        !REAL(REAL64), parameter :: tol = 1.E-6
        REAL(qp) :: varin, varout, resin, resout, vartemp,restemp,varguess,res
        procedure(ResidualFunction) :: ResidualFuncao
        REAL(qp), intent(in) :: parameters(:)
        REAL(qp), intent(in) :: x_min, x_max
        REAL(qp) :: FINDZEROWITHRIDDERS
        INTEGER :: i

        varin = x_min
        varout = x_max
        resin = ResidualFuncao(varin, parameters)
        resout = ResidualFuncao(varout, parameters)
        res = 1000.
        i=0
        !restemp = 1000.
        !print *, "inside 1", varin, varout, resin, resout
        !print *, maxi, res, tol

        DO WHILE ( (i .LT. maxi) .AND. (abs(res) .GE. tol)  )
            varguess = (varin + varout)/2.
            res = ResidualFuncao(varguess, parameters)
            !print *, varguess, res
            vartemp=varguess+(varguess-varin)*sign(res,resin-resout)/(sqrt(res**2 - resin*resout))
            restemp = ResidualFuncao(vartemp, parameters)
            !print *, vartemp, restemp
            if (res*restemp < 0) then
                varin = varguess
                resin = res
                varout = vartemp
                resout = restemp
            else
                if (restemp*resin < 0) then
                    varout = vartemp
                    resout = restemp
                else
                    varin = vartemp
                    resin = restemp
                end if
            end if
            i = i + 1
            !print *, i
        END DO
        !FINDZEROWITHRIDDERS = vartemp
        if (abs(res)<abs(restemp)) then
            FINDZEROWITHRIDDERS = varguess
        else
            FINDZEROWITHRIDDERS = vartemp
        end if
    end function

    subroutine FINDZEROWITHRIDDERS_R( ResidualFuncao, xzero, parameters, x_min, x_max, outparameters)

        implicit none

        INTEGER :: i = 0
        REAL(qp) :: varin, varout, resin, resout, vartemp,restemp,varguess,res
        procedure(ResidualFunction) :: ResidualFuncao
        REAL(qp), intent(in), optional :: parameters(:)
        REAL(qp), intent(in) :: x_min, x_max
        REAL(qp), dimension(2), intent(out), optional :: outparameters
        REAL(qp), intent(out) :: xzero

        varin = x_min
        varout = x_max
        resin = ResidualFuncao(varin, parameters)
        resout = ResidualFuncao(varout, parameters)
        res = 1000.

        DO WHILE ( (i .LT. maxi) .AND. (abs(res) .GE. tol)  )
            varguess = (varin + varout)/2.
            res = ResidualFuncao(varguess, parameters)
            vartemp=varguess+(varguess-varin)*sign(res,resin-resout)/(sqrt(res**2 - resin*resout))
            restemp = ResidualFuncao(vartemp, parameters)
            if (res*restemp < 0) then
                varin = varguess
                resin = res
                varout = vartemp
                resout = restemp
            else
                if (restemp*resin < 0) then
                    varout = vartemp
                    resout = restemp
                else
                    varin = vartemp
                    resin = restemp
                end if
            end if
            i = i + 1
            !print *, i
        END DO
        outparameters(1)=i
        !xzero = vartemp
        if (abs(res)<abs(restemp)) then
            xzero = varguess
        else
            xzero = vartemp
        end if
    end subroutine


end module ZerowithRidders
