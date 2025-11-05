#!/bin/bash

file=$1
width=$2
height=$3

is_installed() {
    command -v "$1" >/dev/null 2>&1
}


image() {
	if ! is_installed chafa; then
		echo "chafa is not installed. Please install chafa to preview images."
		exit 1
	fi
	if [ -n "$WT_SESSION" ] || [ -n "$TMUX" ]; then
		# windows terminal (no sixels yet) or tmux (not much success with passthrough to iterm here)
		chafa -f symbols -s "${height} x ${width}" --animate off --polite on "$1"
	else
		chafa -f sixels -s "${height} x ${width}" --animate off --polite on "$1"
	fi
}

pdf() {
	if ! is_installed pdftoppm; then
		echo "pdftoppm is not installed. Please install pdftoppm to preview pdfs."
		exit 1
	fi
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
	if is_installed bat; then
		bat --color=always --style=numbers --pager=never "${file}" "$@"
	else
		cat "$file"
	fi
}

mime_type=$(file -Lb --mime-type -- "${file}")

case "${mime_type}" in
*/directory)
	eza -T --color=always --all --git-ignore --level=2 --group-directories-first "${file}"
  exit 1
	;;
image/*)
	image "${file}"
  exit 1
	;;
text/* | application/json)
	batorcat
  exit 1
	;;
application/pdf)
	pdf
  exit 1
	;;
*)
	# file -b "$1"
	# lesspipe can list many archives, and even do docx files
	# if it does not work (e.g. message/rfc822) then batorcat can try
	# lesspipe "${file}" || batorcat "${file}" || echo "no preview awailable"
	lesspipe.sh "${file}" || echo "no preview awailable"
  exit 1
	;;
esac
