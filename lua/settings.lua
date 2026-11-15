-- User-facing switches. Change a value and restart Neovim.
return {
	completion = {
		signature_help = true, -- parameter popup while typing call arguments
		auto_docs = true, -- documentation window beside the selected item
		ghost_text = false, -- preview the selected item inline, dimmed
		auto_brackets = true, -- insert () after accepting a function
		enter_accepts = true, -- false: Enter always inserts a newline, only <Tab> accepts
	},
	diagnostics = {
		update_in_insert = false, -- true: refresh errors on every keystroke
	},
	-- neogen annotation style for Python: google_docstrings, numpydoc, reST
	docstring_style = "google_docstrings",
}
