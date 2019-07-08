## -----------------------------------------------------------------------------
## Linux Scripts.
## fillWithZeros app configuration file.
##
## @package ojullien\bash\app\fillwithzeros
## @license MIT <https://github.com/ojullien/bash-fillwithzeros/blob/master/LICENSE>
## -----------------------------------------------------------------------------

readonly m_ZEROFILE="zerofile"

declare sDisk="" sMount=""
declare -g -a m_HARDDISKS=() m_MOUNTPOINTS=()

mapfile -t m_HARDDISKS < <(lsblk --noheadings --nodeps --list --output NAME | grep "sd")
for sDisk in "${m_HARDDISKS[@]}"; do
    sMount=$(findmnt --noheadings --output TARGET "/dev/${sDisk}1")
    if [[ -n ${sMount} ]]; then
        m_MOUNTPOINTS+=("${sMount}")
    fi
done

## -----------------------------------------------------------------------------
## Trace
## -----------------------------------------------------------------------------
FillWithZeros::trace() {
    String::separateLine
    String::notice "App configuration: FillWithZeros"
    String::notice "\tHard disks:\t${m_HARDDISKS[*]}"
    String::notice "\tMount points:\t${m_MOUNTPOINTS[*]}"
    return 0
}
