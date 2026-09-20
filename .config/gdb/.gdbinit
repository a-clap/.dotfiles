# ---------------------------------------------------------------------------
# Output / C++
# ---------------------------------------------------------------------------

set print pretty on
set print object on

set print demangle on
set demangle-style gnu-v3

# Nie wypisuj tysięcy elementów kontenera.
set print elements 100

# Ogranicz kompresowanie powtarzających się elementów.
set print repeats 20

# Przy tablicach pokazuj indeksy.
set print array-indexes on


# ---------------------------------------------------------------------------
# Breakpoints
# ---------------------------------------------------------------------------

# Pozwala ustawiać breakpointy zanim np. biblioteka .so zostanie załadowana.
set breakpoint pending on


# ---------------------------------------------------------------------------
# Terminal / UX
# ---------------------------------------------------------------------------

# Nie zatrzymuj outputu pytaniem:
#
#   --Type <RET> for more, q to quit...
#
set pagination off


# ---------------------------------------------------------------------------
# Command history
# ---------------------------------------------------------------------------

set history save on
set history size 10000
set history filename ~/.gdb_history

