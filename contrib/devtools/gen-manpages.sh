#!/usr/bin/env bash

export LC_ALL=C
TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

LeisureCoinD=${LeisureCoinD:-$BINDIR/LeisureCoind}
LeisureCoinCLI=${LeisureCoinCLI:-$BINDIR/LeisureCoin-cli}
LeisureCoinTX=${LeisureCoinTX:-$BINDIR/LeisureCoin-tx}
LeisureCoinQT=${LeisureCoinQT:-$BINDIR/qt/LeisureCoin-qt}

[ ! -x $LeisureCoinD ] && echo "$LeisureCoinD not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
BTCVER=($($LeisureCoinCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for LeisureCoind if --version-string is not set,
# but has different outcomes for bitcoin-qt and LeisureCoin-cli.
echo "[COPYRIGHT]" > footer.h2m
$LeisureCoinD --version | sed -n '1!p' >> footer.h2m

for cmd in $LeisureCoinD $LeisureCoinCLI $LeisureCoinTX $LeisureCoinQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${BTCVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${BTCVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
