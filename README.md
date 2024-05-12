# GNU Make Extensions

Makext is a collection of useful extensions for Makefiles, aimed at
simplifying and enhancing the functionality of Make-based projects. These
extensions provide additional features and convenience functions to
improve the build process, manage dependencies, and streamline common
tasks.

> [!NOTE]
> This extensions are abusing GNU Make in some sense since it was not 
> meant to really be a task runner. Keep that in mind. However, dispite
> that, I constantly find myself using it as such.

Features include:

- Enhanced help message generation with support for custom descriptions.
- Automatic description inclusion in help message.
- Automatic license inclusion in help message.

## How to use

First you will need to download `makext.mk` file from the repository to
the same directory where you have `Makefile`.

```sh
wget -O makext.mk https://github.com/mitjafelicijan/makext/raw/master/makext.mk
```

Now you can include it in your `Makefile`.

```make
include makext.mk

help: .help
```

> [!IMPORTANT]
> Make sure you create first target `help: .help` before any other
> targets in your `Makefile`. GNU Make will execute first target if
> no target provided as an argument when calling `make`.

## Help extension

This is all that is needed to start using `makext`. One of the extensions
is `.help` which displays all the targets in the `Makefile` and their
descriptions which are provided as comments next to the target definition.

Lets check how and example `Makefile` would look. It
is recommended to use `.PHONY` for targets that are not
actual files. In the example below I am not doing that
though, but it is wise to follow that rule. Check [4.6 Phony
Targets](https://www.gnu.org/software/make/manual/make.html#Phony-Targets)
section in the GNU Make manual.

```make
include makext.mk

help: .help

build-app: clean-cache # Build the application
	@echo "Building the application..."

clean-cache: # Clean the cache
	@echo "Cleaning the cache..."

deploy-prod: # Deploy to production
	@echo "Deploying to production..."

run-tests:
	@echo "Running tests..."
```

This will give us under we execute command `make` the following result.

```text
$ make
Targets:
  build-app                 Build the application
  clean-cache               Clean the cache
  deploy-prod               Deploy to production
```

- Targets without defined comment next to the target will be ignored
  from help list. In this case `run-tests` is missing from the list.
- Targets that start with `.` will also be ignored.
- Prerequisites in targets will be ommited from the result.

## Description & License information

You can provide description for the project that will be displayed
together with `help`. To do this provide this information in the
`MK_DESCRIPTION` variable.

Same goes for license information. Provide this information by creating
`MK_LICENSE` variable.

If these variables are not present this information will not be displayed
in the help.

> [!IMPORTANT]
> Variables `MK_DESCRIPTION` and `MK_LICENSE` must be defined before you
> include `makext.mk` to your `Makefile`. This is needed because the way
> GNU Make is parsing Makefiles.

```make
MK_DESCRIPTION="This provides some additional tools for makefiles."
MK_LICENSE="Released under the BSD two-clause license, see the LICENSE file for more information."

include makext.mk

help: .help

build-app: clean-cache # Build the application
	@echo "Building the application..."

clean-cache: # Clean the cache
	@echo "Cleaning the cache..."
```

The following example will produce the following result.

```text
$ make
This provides some additional tools for makefiles.

Targets:
  build-app                 Build the application
  clean-cache               Clean the cache

Released under the BSD two-clause license, see the LICENSE file for
more information.
```

## Acknowledgement

- https://stackoverflow.com/a/59087509

## License

[makext](https://github.com/mitjafelicijan/makext) was written by [Mitja
Felicijan](https://mitjafelicijan.com) and is released under the BSD
two-clause license, see the LICENSE file for more information.
