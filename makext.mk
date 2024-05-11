# Makext is a collection of useful extensions for Makefiles, aimed at
# simplifying and enhancing the functionality of Make-based projects. These
# extensions provide additional features and convenience functions to
# improve the build process, manage dependencies, and streamline common
# tasks.
#
# Features include:
# - Enhanced help message generation with support for custom descriptions.
# - Automatic description inclusion in help message.
# - Automatic license inclusion in help message.
#
# Visit the GitHub repository at https://github.com/mitjafelicijan/makext
# to learn more and contribute to the project.

.help:
ifdef M_DESCRIPTION
	@echo "$(M_DESCRIPTION)\n" | fmt
endif
	@echo "Targets:"
	@grep '^.*:.* #' Makefile | sed -E 's/(.*):.*#(.*)/ \1###\2/' | column -t -s '###'
ifdef M_LICENSE
	@echo "\n$(M_LICENSE)" | fmt
endif
