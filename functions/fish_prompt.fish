_load_sushi

function fish_prompt
	set -l symbol "λ "
	set -l code $status
	set -l host (echo $hostname)
	set -l who (whoami)
	echo -n -s (magenta)"["(cyan)"$who"(magenta)"@"(cyan)"$host"(magenta)"] "(off)

	if git::is_repo
		set -l branch (git::branch_name 2>/dev/null)
		set -l ref (git show-ref --head --abbrev | awk '{print substr($0,0,7)}' | sed -n 1p)

		if git::is_stashed
			echo -n -s (white)"^"(off)
		end

		echo -n -s (magenta)"("(off)

		if git::is_dirty
			printf (white)"*"(off)
		end

		if command git symbolic-ref HEAD > /dev/null 2>&1
			if git::is_staged
				printf (cyan)"$branch"(off)
			else
				printf (yellow)"$branch"(off)
			end
		else
			printf (dim)"$ref"(off)
		end

		for remote in (git remote)
			set -l behind_count (echo (command git rev-list $branch..$remote/$branch 2>/dev/null | wc -l | tr -d " "))
			set -l ahead_count (echo (command git rev-list $remote/$branch..$branch 2>/dev/null | wc -l | tr -d " "))

			if test $ahead_count -ne 0; or test $behind_count -ne 0; and test (git remote | wc -l) -gt 1
				echo -n -s " "(orange)$remote(off)
			end

			if test $ahead_count -ne 0
				echo -n -s (white)" +"$ahead_count(off)
			end

			if test $behind_count -ne 0
				echo -n -s (white)" -"$behind_count(off)
			end
		end

		echo -n -s (magenta)") "(off)
	end

	if test "$code" = 0
		echo -n -s (magenta)"$symbol"(off)
	else
		echo -n -s (dim)"$symbol"(off)
	end
end
