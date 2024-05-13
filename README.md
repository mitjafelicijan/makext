# GNU Make Extensions

Makext is a collection of useful extensions for Makefiles, aimed
at simplifying and enhancing the functionality of Make-based
projects. These extensions provide additional features and
convenience functions to improve the overall usage of [GNU
Make](https://www.gnu.org/software/make/) as a task runner.

All the extensions are written in GNU Make so no other languages are used
making this very embedable and has zero dependencies other than GNU Make.

Other than `makext.mk` all the other files in the repository are either
license or readme files or just testing data that is/are not needed to
use it.

> [!NOTE]
> This extensions are abusing GNU Make in some sense since it was not 
> meant to really be a task runner. Keep that in mind. However, despite
> that, I constantly find myself using it as such.

### Extensions

| Extension   | Description                                         |
|-------------|-----------------------------------------------------|
| help        | Displays all targets with a comment in help format. |
| assure      | Check for the existence of programs on a machine.   |
| environment | Loads environmental variables from other files.     |

Additional features:

- Automatic description inclusion in help message.
- Automatic license inclusion in help message.

Tested on:

- GNU Linux Debian 12 with GNU Make 4.3
- macOS Sonoma 14.4.1 with GNU Make 3.81

If you have an idea for a new feature [open a new
issue](https://github.com/mitjafelicijan/makext/issues/new).

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

One of the extensions is `.help` which displays all the targets in the
`Makefile` and their descriptions which are provided as comments next
to the target definition.

Lets check how and example `Makefile` would look like. It
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

This will give us the following result when we execute command `make`
without any arguments.

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
- Prerequisites in targets will be omitted from the result. See how
  `clean-cache` is missing from `build-app` target.

## Description & License information

You can provide description for the project that will be displayed
together with `help`. To do this provide this information in the
`MEX_DESCRIPTION` variable.

Same goes for license information. Provide this information by creating
`MEX_LICENSE` variable.

If these variables are not present this information will not be displayed
in the help.

Description and license information is also formatted to max 75 characters
per row.

> [!IMPORTANT]
> Variables `MEX_DESCRIPTION` and `MEX_LICENSE` must be defined before you
> include `makext.mk` to your `Makefile`. This is needed because the way
> GNU Make is parsing Makefiles.

```make
MEX_DESCRIPTION="This provides some additional tools for this project."
MEX_LICENSE="Released under the BSD two-clause license, see the LICENSE file for more information."

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
This provides some additional tools for this project.

Targets:
  build-app                 Build the application
  clean-cache               Clean the cache

Released under the BSD two-clause license, see the LICENSE file for
more information.
```

## Assure extension

Often times project uses multiple programs and to ensure that these
programs are already installed before recipes are executed `.assure` can
be used. If programs are missing recipes can only partially be executed
leaving project in a potentially broken state.

```make
MEX_ASSURE="python3 ls tree clang"

include makext.mk

build-app: .assure
	@echo "Building the application..."
```

`.assure` prerequisite will loop over the list of programs defined in
`MEX_ASSURE` variable and in case one is missing will exit `make` with
error status code 1. This will stop executing the recipe and therefore
not execute anything in target `build-app`.

## Environment extension

This extension helps loading of additional environmental files in your
project. The files should have environmental variables defined in the
usual way. Separate each file by a space and that is about it.

If a file is missing this will break the execution of make and exit with
status code 1.

```env
API_KEY=abc123
SECRET_KEY=def456
```

By defining `MEX_ENVIRONMENT` variable you can provide additional files
and they will be loaded automatically.

```make
MEX_ENVIRONMENT="local.env second.env"

include makext.mk

demo-envars:
	@echo "Environment variables"
	@echo "  HOME: $(HOME)"
	@echo "  TERM: $(TERM)"
	@echo "  ENV: $(MEX_ENVIRONMENT)"
	@echo "  AUDIO_BUCKET: $(AUDIO_BUCKET)"
	@echo "  DB_HOST: $(DB_HOST)"
```

After that they can be used in your recipes like all the other variables
you have. They will however override variables the shell already has
defined.

## Alternative tools

- https://github.com/casey/just
- https://github.com/xonixx/makesure
- https://github.com/ruby/rake
- https://github.com/taskctl/taskctl
- https://github.com/go-task/task
- https://github.com/pydoit/doit

## Acknowledgment

- https://stackoverflow.com/a/59087509

## License

[makext](https://github.com/mitjafelicijan/makext) was written by [Mitja
Felicijan](https://mitjafelicijan.com) and is released under the BSD
two-clause license, see the LICENSE file for more information.
