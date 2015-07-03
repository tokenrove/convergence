Convergence
===========

Convergence was a game written by Matthew Riche and myself (Julian
Squires) in 2002.  It was never finished, although the version
presented here is not quite the final version.  I do plan to finish it
and open source the whole thing; for the moment, however, you can
consider this repository to be ambiguously licensed: _look but don't
touch_.

This is based on the last snapshot I could find.  I do have a DDS-2
backup tape that should contain the whole CVS repository, which I need
to dump anyway because it includes some build tools that don't seem to
be in this repo.

It is possible to build a ROM that plays in emulators like mednafen
(and on the real hardware) from this tree, but it's tricky, and due to
the number of strange behaviors I've encountered with the build I've
made so far, I suspect there is some subtlety I'm missing (probably a
dependency in the tools on a 32-bit machine).

You might find
[my postmortem on the project](http://www.cipht.net/convergence-postmortem.pdf)
of interest, although, like this code, it's very dated.
