{ config, lib, pkgs, ... }:
{
  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enabled = "kime";
      kime.extraConfig = ''
engine:
  translation_layer: ./colemak-dh-translation.yaml
  latin:
    preferred_direct: true
      '';
    };
  };
  environment.etc."xdg/kime/colemak-dh-translation.yaml".text = ''
Q: Q
W: W
F: E
P: R
B: T
J: Y
L: U
U: I
Y: O
Quote: P
A: A
R: S
S: D
T: F
G: G
M: H
N: J
E: K
I: L
O: SemiColon
Z: Z
X: X
C: C
D: V
V: B
K: N
H: M

S-Q: S-Q
S-W: S-W
S-F: S-E
S-P: S-R
S-B: S-T
S-J: S-Y
S-L: S-U
S-U: S-I
S-Y: S-O
S-Quote: S-P
S-A: S-A
S-R: S-S
S-S: S-D
S-T: S-F
S-G: S-G
S-M: S-H
S-N: S-J
S-E: S-K
S-I: S-L
S-O: S-SemiColon
S-Z: S-Z
S-X: S-X
S-C: S-C
S-D: S-V
S-V: S-B
S-K: S-N
S-H: S-M
'';
}
