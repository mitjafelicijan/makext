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

# Checks if operating system is Windows and exists with error.
ifeq ($(OS),Windows_NT)
$(error makext does not support Windows operating system)
endif

# Help extension that lists all the targets with descriptions
# and adds description and license information if data provided.
.PHONY: .help
.help:
ifdef MEX_DESCRIPTION
	@echo "$(MEX_DESCRIPTION)\n" | fmt
endif
	@echo "Targets:"
	@grep -vE '^[[:space:]]' $(MAKEFILE_LIST) | grep -E '^.*:.* #' | sed -E 's/(.*):(.*):.*#(.*)/  \2###\3/' | column -t -s '###'
ifdef MEX_LICENSE
	@echo "\n$(MEX_LICENSE)" | fmt
endif

# Checks `MEX_ASSURE` variable if all the programs declared actually
# exist on a machine. If not this exists make with error.
.PHONY: .assure
.assure:
ifndef MEX_ASSURE
	@echo "Variable MEX_ASSURE is not defined. Can not check for programs."
else
	@for prog in $(shell echo $(MEX_ASSURE)); do \
		if ! which $$prog > /dev/null; then \
			echo "Error: '$$prog' not found on this machine."; \
			exit 1; \
		fi; \
	done
endif
