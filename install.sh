#!/bin/bash
# ============================================================================
#  DIKKENEK PLAY — installation en une ligne (sans alerte macOS)
#  Usage sur le Mac cible :
#     curl -fsSL https://raw.githubusercontent.com/renaud-bxl/dikkenek-play/main/install.sh | bash
#  (curl ne pose pas le marqueur de quarantaine : l'app s'ouvre directement, sans "Ouvrir quand même")
#  Variante : bash install.sh /chemin/vers/DikkenekPlay-x.y.dmg  (installe un DMG local)
# ============================================================================
set -euo pipefail
REPO="renaud-bxl/dikkenek-play"                       # ex. renaudbenlakhal/dikkenek-play
APP_NAME="Dikkenek Play"
DEST="/Applications/$APP_NAME.app"
TMP="$(mktemp -d /tmp/dikkenekplay.XXXXXX)"
trap 'hdiutil detach "$MNT" -quiet >/dev/null 2>&1 || true; rm -rf "$TMP"' EXIT
MNT="$TMP/mnt"

echo "▶ DIKKENEK PLAY — installation"
if [[ "${1:-}" == *.dmg && -f "${1:-}" ]]; then
  DMG="$1"; echo "  DMG local : $DMG"
else
  echo "  Recherche de la dernière version sur GitHub ($REPO)…"
  URL="$(curl -fsSL "https://api.github.com/repos/$REPO/releases/latest" | grep -o '"browser_download_url": *"[^"]*\.dmg"' | head -1 | sed 's/.*"\(http[^"]*\)"/\1/')"
  [[ -n "$URL" ]] || { echo "✗ Aucun DMG trouvé dans la dernière release de $REPO"; exit 1; }
  DMG="$TMP/DikkenekPlay.dmg"; echo "  Téléchargement : $URL"
  curl -fL --progress-bar -o "$DMG" "$URL"
fi
echo "  Montage du DMG…"; mkdir -p "$MNT"
hdiutil attach "$DMG" -mountpoint "$MNT" -nobrowse -quiet
[[ -d "$MNT/$APP_NAME.app" ]] || { echo "✗ « $APP_NAME.app » introuvable dans le DMG"; exit 1; }
if pgrep -f "$APP_NAME.app/Contents/MacOS" >/dev/null 2>&1; then echo "  Fermeture de l'app en cours…"; pkill -f "$APP_NAME.app/Contents/MacOS" || true; sleep 1; fi
echo "  Copie dans /Applications…"
rm -rf "$DEST"; cp -R "$MNT/$APP_NAME.app" "$DEST"
xattr -cr "$DEST" 2>/dev/null || true          # aucun marqueur de quarantaine, quel que soit le canal
[[ -f "$MNT/LISEZ-MOI.txt" ]] && cp "$MNT/LISEZ-MOI.txt" "$HOME/Desktop/DIKKENEK PLAY - LISEZ-MOI.txt" 2>/dev/null || true
hdiutil detach "$MNT" -quiet
echo "✓ Installé : $DEST"
open "$DEST"
