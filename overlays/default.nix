final: prev:
{
  mpfr = prev.mpfr.overrideAttrs (old: {
    patches = (old.patches or []) ++ [
      ./mpfr_4.1.1.patch
    ];
  });
}
