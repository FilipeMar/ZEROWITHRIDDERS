! testing routines

program testingfuncs

    use iso_fortran_env
    use ZerowithRidders
    implicit none

    !INTEGER, parameter :: qp = REAL64 !REAL128
    REAL(qp), parameter :: x_min = -0.5, x_max = 3.5
    REAL(qp), dimension(3) :: parameters=(/1,2,3/)
    REAL(qp) :: xzero
    REAL(qp), dimension(2) :: outparameters

    !print *, parameters
    !xzero = ResidualFuncao(0.d0,parameters)
    !print *, "Zero:", xzero
    xzero = FINDZEROWITHRIDDERS( ResidualFuncao, parameters, x_min, x_max )

    print *, "Zero (FINDZEROWITHRIDDERS):", xzero

    print *, "----------"

    call FINDZEROWITHRIDDERS_R( ResidualFuncao, xzero, parameters, x_min, x_max, outparameters)
    print *, "iteração ",outparameters(1),":> ", "Zero (FINDZEROWITHRIDDERS_R):", xzero
    print *, "f(xzero)= cos(xzero)= ", ResidualFuncao(xzero)

contains
    REAL(qp) pure function ResidualFuncao(x,parameters)
        REAL(qp), intent(in) :: x
        REAL(qp), intent(in), optional :: parameters(:)
        !REAL(REAL64), intent(out) :: ResidualFunction
        ResidualFuncao = cos(x)
    end function ResidualFuncao

end program testingfuncs
