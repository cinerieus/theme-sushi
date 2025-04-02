_load_sushi

function fish_prompt
	set -l symbol "λ "
	set -l code $status
	set -l host (echo $hostname)
	set -l who (whoami)
	echo -n -s (magenta)"["(blue)"$who"(magenta)"@"(blue)"$host"(magenta)"] "(off)

	if test "$code" = 0
		echo -n -s (magenta)"$symbol"(off)
	else
		echo -n -s (dim)"$symbol"(off)
	end
end
