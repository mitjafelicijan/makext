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
#
# `makext` was written by Mitja Felicijan and is released under the BSD
# two-clause license, see the LICENSE file for more information.

# Help extension that lists all the targets with descriptions
# and adds description and license information if data provided.
.PHONY: .help
.help:
ifdef MK_DESCRIPTION
	@echo "$(MK_DESCRIPTION)\n" | fmt
endif
	@echo "Targets:"
	@grep -vE '^[[:space:]]' $(MAKEFILE_LIST) | grep -E '^.*:.* #' | sed -E 's/(.*):(.*):.*#(.*)/  \2###\3/' | column -t -s '###'
ifdef MK_LICENSE
	@echo "\n$(MK_LICENSE)" | fmt
endif
