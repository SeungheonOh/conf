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
Q: q
W: w
F: e
P: r
B: t
J: y
L: u
U: i
Y: o
Quote: p
A: a
R: s
S: d
T: f
G: g
M: h
N: j
E: k
I: l
O: SemiColon
Z: z
X: x
C: c
D: v
V: b
K: n
H: m
'';
}
