_load_sushi

function fish_right_prompt
	if test "$theme_complete_path" = "yes"
		set cwd (prompt_pwd)
	else
		set cwd (basename (prompt_pwd))
	end
	printf (magenta)"["(dim)$cwd(magenta)"] "(off)
	printf (dim)(date +%H(magenta):(dim)%M(magenta):(dim)%S)(off)
end
