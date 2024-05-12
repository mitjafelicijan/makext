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
ifdef MK_DESCRIPTION
	@echo "$(MK_DESCRIPTION)\n" | fmt
endif
	@echo "Targets:"
	@grep -vE '^[[:space:]]' $(MAKEFILE_LIST) | grep -E '^.*:.* #' | sed -E 's/(.*):.*#(.*)/  \1###\2/' | column -t -s '###'
ifdef MK_LICENSE
	@echo "\n$(MK_LICENSE)" | fmt
endif
