## -----------------------------------------------------------------------------
## Linux Scripts.
## fillWithZeros app functions
##
## @package ojullien\bash\app\fillwithzeros
## @license MIT <https://github.com/ojullien/bash-fillwithzeros/blob/master/LICENSE>
## -----------------------------------------------------------------------------

FillWithZeros::fill() {

    # Parameters
    if (($# != 1)) || [[ -z "$1" ]]; then
        String::error "Usage: FillWithZeros::fill <mount point as string>"
        return 1
    fi

    # Init
    local sDir="$1"
    local -i iReturn=1

    # Do the job
    String::notice "Filling '${sDir}' with zeros ..."
    cat /dev/zero > "${sDir}/${m_ZEROFILE:?}"
    sync
    rm -f "${sDir}/${m_ZEROFILE:?}"
    iReturn=$?
    String::notice -n "Fill '${sDir}' with zeros:"
    String::checkReturnValueForTruthiness ${iReturn}

    return ${iReturn}
}

## -----------------------------------------------------------------------------
## End
## -----------------------------------------------------------------------------
FillWithZeros::finish() {

    # Init
    declare sMount=""

    # Do the job
    for sMount in "${m_MOUNTPOINTS[@]}"; do
        [[ -n ${sMount} ]] && [[ -f "${sMount}/${m_ZEROFILE:?}" ]] && rm -f "${sMount}/${m_ZEROFILE:?}"
    done
    return 0
}
trap FillWithZeros::finish EXIT SIGQUIT SIGTERM SIGINT ERR
