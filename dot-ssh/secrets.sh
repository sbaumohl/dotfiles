#!/bin/sh
#
# secrets.sh - bundle/restore the contents of this directory with age.
#
#   ./secrets.sh encrypt <key-file>   tar+zstd every file here (except the
#                                     archive and this script) and encrypt it
#                                     to secrets.tar.zst.age
#   ./secrets.sh decrypt <key-file>   decrypt secrets.tar.zst.age with the
#                                     given age identity and unpack it here
#
# <key-file> is an age identity (AGE-SECRET-KEY.../ssh private key); for
# encrypt the recipient is derived from it with age-keygen -y. A file of
# public age recipients also works for encrypt.

set -eu

DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
SELF=$(basename -- "$0")
ARCHIVE_NAME="secrets.tar.zst.age"
ARCHIVE="$DIR/$ARCHIVE_NAME"

die() { printf '%s: %s\n' "$SELF" "$*" >&2; exit 1; }

usage() {
	cat >&2 <<USAGE
usage: $SELF encrypt|decrypt <key-file>

  encrypt  archive this directory into $ARCHIVE_NAME
  decrypt  restore $ARCHIVE_NAME into this directory
USAGE
	exit 2
}

need() { command -v "$1" >/dev/null 2>&1 || die "missing required command: $1"; }

# Files to bundle: everything under $DIR except this script, the archive,
# and any stray tarball.
list_files() {
	find . -type f \
		! -name "$SELF" \
		! -name '*.age' \
		! -name '*.tar' \
		! -name '*.tar.*' \
		! -name '*.tgz' \
		! -name '*.tzst' \
		-print
}

do_encrypt() {
	key=$1
	need tar; need zstd; need age
	[ -f "$key" ] || die "key file not found: $key"

	umask 077
	work=$(mktemp -d)
	trap 'rm -rf "$work"' EXIT INT HUP TERM

	# Derive recipients: an age identity yields its public key; otherwise
	# assume the file already contains public recipients.
	recipients="$work/recipients"
	if command -v age-keygen >/dev/null 2>&1 && age-keygen -y "$key" >"$recipients" 2>/dev/null; then
		:
	elif grep -q '^\(age1\|ssh-\)' "$key" 2>/dev/null; then
		cp -- "$key" "$recipients"
	else
		die "cannot derive an age recipient from $key"
	fi
	[ -s "$recipients" ] || die "no recipients found in $key"

	cd "$DIR"
	files=$(list_files)
	[ -n "$files" ] || die "nothing to encrypt in $DIR"

	# Staged rather than piped: /bin/sh has no pipefail, so a failing tar or
	# zstd in a pipeline would silently produce a truncated archive.
	printf '%s\n' "$files" >"$work/files"
	tar --create --no-recursion --numeric-owner \
		--files-from="$work/files" --file "$work/archive.tar"
	zstd -q -T0 -19 -o "$work/archive.tar.zst" "$work/archive.tar"
	age --recipients-file "$recipients" \
		--output "$work/archive.age" "$work/archive.tar.zst"

	cat -- "$work/archive.age" >"$ARCHIVE.tmp.$$"
	mv -- "$ARCHIVE.tmp.$$" "$ARCHIVE"
	chmod 600 "$ARCHIVE"

	printf '%s: wrote %s\n' "$SELF" "$ARCHIVE"
	printf '%s\n' "$files" | sed 's|^\./|  |'
}

do_decrypt() {
	key=$1
	need tar; need zstd; need age
	[ -f "$key" ] || die "identity file not found: $key"
	[ -f "$ARCHIVE" ] || die "archive not found: $ARCHIVE"

	umask 077
	work=$(mktemp -d)
	trap 'rm -rf "$work"' EXIT INT HUP TERM

	age --decrypt --identity "$key" --output "$work/archive.tar.zst" "$ARCHIVE"
	zstd -d -q -o "$work/archive.tar" "$work/archive.tar.zst"
	cd "$DIR"
	tar --extract --preserve-permissions --file "$work/archive.tar"

	printf '%s: restored %s into %s\n' "$SELF" "$ARCHIVE_NAME" "$DIR"
}

[ $# -eq 2 ] || usage

case $1 in
	encrypt) do_encrypt "$2" ;;
	decrypt) do_decrypt "$2" ;;
	*) usage ;;
esac
