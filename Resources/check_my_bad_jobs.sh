#!/bin/bash

if [ "$1" == "-n" ];then
	NAGIOS=1
fi

SQUEUE=/usr/local/slurm/latest/bin/squeue
#SACCT=/usr/local/slurm/latest/bin/sacct

if [ \! -x ${SQUEUE} ]; then
	if [ "${NAGIOS}" ]; then
		echo -n "WARNING: "
	fi
	echo "ERROR: no squeue - wrong machine?"
	exit 1
fi

# If run by a normal user.
if [ $(id -u) != 0 ]
then
	SQUEUE="$SQUEUE -u `whoami`"
fi

# If we have no jobs queued, abort

if [ -z "$(${SQUEUE} -h)" ]; then
	if [ "${NAGIOS}" ]; then
		echo -n "OK: "
	fi
	#echo "No jobs queued"
	exit 0
fi

ACTIVEJOBS=$(${SQUEUE} -t R -ho "%.15i %D" | fgrep -vw 1 | awk '{print $1}' | tr '\n' ',' | sed -e 's/,$/\n/')
if [ -z ${ACTIVEJOBS} ]; then
        if [ "${NAGIOS}" ]; then
                echo -n "OK: "
        fi
        #echo "No bad jobs found"
        exit 0
fi

JOBLIST=$(${SQUEUE} -o %i -hs -j ${ACTIVEJOBS} | awk -F. '{print $1}' | uniq -c | fgrep -w 2 | awk '{print $2}' | tr '\n' ',' | sed -e 's/,$//')

export SQUEUE_FORMAT='%.10i %.9P %.15u  %.8D %.8C %N'
if [ -z "$JOBLIST" ]; then

	if [ "${NAGIOS}" ]; then
		echo -n "OK: "
	fi
	#echo "No bad jobs found"
	exit 0;
fi

if [ "${NAGIOS}" ]; then
	echo "CRITICAL: bad jobs found ${JOBLIST}"
	exit 2
fi

echo ""
echo "The following candidate jobs were found:"
echo "----------------------------------------"
${SQUEUE} -o "${SQUEUE_FORMAT}" -j ${JOBLIST}
echo ""
