#!/bin/bash

file=$1
width=$2
height=$3

image() {
	if [ -n "$WT_SESSION" ] || [ -n "$TMUX" ]; then
		# windows terminal (no sixels yet) or tmux (not much success with passthrough to iterm here)
		chafa -f symbols -s "${height} x ${width}" --animate off --polite on "$1"
	else
		chafa -f sixels -s "${height} x ${width}" --animate off --polite on "$1"
	fi
}

pdf() {
	CACHE="$HOME/.cache/lf/th_$(sha256sum "$file" | awk '{print $1}')"

	if [ ! -f "${CACHE}.jpg" ]; then
		pdftoppm -jpeg -f 1 -singlefile "${file}" "${CACHE}" || {
			echo "pdftoppm failed"
			exit 1
		}
	fi
	image "${CACHE}.jpg"
}

batorcat() {
	shift
	if command -v bat >/dev/null 2>&1; then
		bat --color=always --style=numbers --pager=never "${file}" "$@"
	else
		cat "$file"
	fi
}

mime_type=$(file -Lb --mime-type -- "${file}")

case "${mime_type}" in
*/directory)
	eza -T --color=always --all --git-ignore --level=2 --group-directories-first "${file}"
	;;
image/*)
	image "${file}"
	;;
text/* | application/json)
	batorcat
	;;
application/pdf)
	pdf
	;;
*)
	# file -b "$1"
	# lesspipe can list many archives, and even do docx files
	# if it does not work (e.g. message/rfc822) then batorcat can try
	# lesspipe "${file}" || batorcat "${file}" || echo "no preview awailable"
	lesspipe.sh "${file}" || echo "no preview awailable"
	;;
esac
