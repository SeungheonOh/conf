final: prev:
rec {
  # mpfr_fixed = prev.mpfr.overrideAttrs (old: {
  #   patches = (old.patches or []) ++ [
  #     ./mpfr_4.1.1.patch
  #   ];
  # });
  # cgal = prev.cgal.overrideAttrs (old: {
  #   buildInputs = [ prev.boost prev.gmp mpfr_fixed ];
  # });
  # openscad = prev.openscad.overrideAttrs (old: {
  #   buildInputs = (prev.lib.remove prev.mpfr old.buildInputs) ++ [ mpfr_fixed ];
  # });
  # prusa-slicer = prev.prusa-slicer.overrideAttrs (old: {
  #   buildInputs = (prev.lib.remove prev.mpfr old.buildInputs) ++ [ mpfr_fixed ];
  # });
}
