#!/usr/bin/env bash

temp="/tmp/.cpu_usage"

function get_cpu() {
	if [[ -f "${temp}" ]]; then
		fileCont=$(cat "${temp}")
		PREV_TOTAL=$(echo "${fileCont}" | head -n 1)
		PREV_IDLE=$(echo "${fileCont}" | tail -n 1)
	else
		PREV_TOTAL=0
		PREV_IDLE=0
	fi

	CPU=(`cat /proc/stat | grep '^cpu '`)
	unset CPU[0]
	IDLE=${CPU[4]}

	TOTAL=0
	for VALUE in "${CPU[@]:0:4}"; do
		let "TOTAL=$TOTAL+$VALUE"
	done

	if [[ "${PREV_TOTAL}" != "" ]] && [[ "${PREV_IDLE}" != "" ]]; then
		let "DIFF_IDLE=$IDLE-$PREV_IDLE"
		let "DIFF_TOTAL=$TOTAL-$PREV_TOTAL"
		let "DIFF_USAGE=(1000*($DIFF_TOTAL-$DIFF_IDLE)/$DIFF_TOTAL+5)/10"
		echo "${DIFF_USAGE}"
	else
		echo "?"
	fi
	echo "${TOTAL}" > "${temp}"
	echo "${IDLE}" >> "${temp}"
}

function get_mem() {
	printf "%.0f\n" $(free -m | grep Mem | awk '{print ($3/$2)*100}')
}

function get_disc() {
	[[ $(df -h | grep /home) ]] && \
		df -h /home | awk '{print $5}' | tail -n1 | sed 's/%//g' || \
		df -h / | awk '{print $5}' | tail -n1 | sed 's/%//g'
}

case $1 in
	--cpu)
		get_cpu
	;;
	--mem)
		get_mem
	;;
	--disc)
		get_disc
	;;
	"")
		echo "No argument given. Use --cpu, --mem or --disc." \
		"Add --detailed as second argument to get a non-percentage value."
	;;
	*)
		echo "There is no case defined for given argument: \`$1\`"
	;;
esac