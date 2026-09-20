##########################################################################
#                                                                        #
#                         D I K K E N E K   P L A Y                      #
#                                                                        #
#        Logiciel créé par RENAUD BEN LAKHAL pour l'événement            #
#                        DIKKENEK 20 ANS                                 #
#                                                                        #
##########################################################################

DIKKENEK PLAY — diffuseur vidéo pour macOS
==========================================

L'application installée : /Applications/Dikkenek Play.app  (lancer depuis le Launchpad ou le Finder).
Ce dossier contient la source (dikkenek_play.py), les visuels (assets/) et « installer.command » :
double-cliquer dessus après toute modification pour reconstruire l'app dans /Applications.
Prérequis : VLC.app dans /Applications (moteur de lecture : MKV, MP4, MOV, MPEG-2, AC3…).
Pourquoi /Applications : macOS bloque l'accès d'une app non signée aux fichiers du Bureau ; l'app est donc
autonome (Python + PyQt6 + python-vlc embarqués) et installée hors du Bureau.

Utilisation
-----------
Dans la liste : 1 clic sur un clip = il passe en PRÉVISU · TRIPLE clic = il passe à l'antenne (en fondu). Le double-clic ne fait rien.
1. « ＋ Ajouter… » (ou glisser-déposer des fichiers dans la liste). Réordonner avec ▲ ▼.
2. Colonne « Fin du clip » (réglable en direct, même pendant la lecture) :
   - ▶ Suivante : à la fin, fondu au noir puis le clip suivant démarre automatiquement.
   - ⟳ Boucle   : tourne en boucle sans aucun fondu, jusqu'au clic sur « Vidéo suivante ».
   - ⏹ Stop     : à la fin, fondu au noir, retour au logo DIKKENEK 20 ANS ; « Vidéo suivante » (Espace)
                  repart alors sur le clip qui suit, sans toucher à la prévisualisation.
   Le fondu au noir n'intervient qu'au passage d'un clip à l'autre (ou vers le logo).
3. Choisir l'écran de sortie (projecteur / écran cinéma) puis « Plein écran : ON ».
   Quand rien n'est à l'antenne, la sortie affiche le logo DIKKENEK 20 ANS (image fixe, sans son).
4. Sélectionner un clip → « ▶ Lancer la sélection » (ou triple clic). La touche Entrée ne lance jamais la
   diffusion (elle sert à valider une heure).
   - « ⏭ VIDÉO SUIVANTE » (ou Espace) : passe au clip suivant en fondu (ou relance la sélection si hors antenne).
   - « ⏹ Fondu au noir » (ou S) : coupe l'antenne en fondu, le logo revient.
   - Triple clic sur un clip : passe à ce clip (avec fondu).
5. Volume : curseur « Volume du clip à l'antenne » (agit immédiatement) ou colonne Volume de la liste ;
   la valeur est mémorisée par clip.
6. Deux écrans dans la régie : ÉCRAN PRÉVISUALISATION (vert) = le clip que VOUS avez cliqué, lu en boucle ;
   il ne change jamais tout seul (ni horaire, ni enchaînement, ni stop) ; ÉCRAN DE DIFFUSION (rouge) = exactement ce qui sort sur
   le grand écran. Chacun peut être désactivé (économie de processeur).
7. Horaires : colonne « Heure » — cocher la case du clip puis régler l'heure (cliquer sur heures / minutes /
   secondes, flèches ▲▼ ou clavier). La case « Horaires actifs » sert seulement à tout suspendre.
   à l'heure dite, le clip part tout seul (en fondu), même depuis le logo ou pendant une boucle ; ensuite
   son réglage « Fin du clip » s'applique (Suivante / Boucle / Stop). Une fois par jour et par clip.
   L'horloge et le prochain horaire armé s'affichent sous les réglages. Un horaire déjà passé au moment où
   l'app démarre n'est pas rejoué. Sous les moniteurs : écoulé / durée, et le temps restant (rouge < 10 s).
8. Durée du fondu réglable (0 à 5 s).
   Audio : volume général de la diffusion (en plus du volume par clip) ; deux sorties audio indépendantes — « écran de diffusion » (ex. HDMI du projecteur ou table de mixage)
   et « écran prévisualisation » (ex. casque), avec son propre volume et un bouton Muet ; « Muet (aucune) » = aucune sortie.
   ↻ actualise la liste après avoir branché un appareil.
9. Pages web (quiz, site, compteur…) : « 🌐 Ajouter une URL… » crée un clip web dans la liste. Il se comporte
   comme une vidéo : horaire, « Fin du clip », fondu au noir, prévisualisation (1 clic), triple clic pour l'antenne.
   Sa colonne « Durée » se règle en heures:minutes:secondes (00:00:00 = la page reste affichée jusqu'à
   « Vidéo suivante ») ; tant que ce temps n'est pas écoulé, la page reste à l'antenne. La page est
   rendue par le moteur Chromium intégré, plein écran sur la sortie 16/9 (⏮ = recharger la page).
   Ajustement « page entière » : la page est rendue comme sur un écran de 1920 px de large, puis l'app mesure sa
   hauteur réelle et réduit le zoom jusqu'à ce que TOUT soit visible sans défilement (re-vérifié toutes les 2 s,
   utile pour un quiz dont le contenu change). Réglage « Zoom pages web (%) » pour agrandir/réduire globalement.
10. « Enregistrer liste… » / « Ouvrir liste… » pour garder une conduite (.dkkplay). La liste et les réglages
   sont aussi rappelés automatiquement au prochain lancement (~/Library/Application Support/Dikkenek Play).

Installer sur un autre Mac
--------------------------
« build_dmg.command » (double-clic) fabrique dist/DikkenekPlay-<version>.dmg : une application AUTONOME
(Python, PyQt6, libVLC et ses plugins sont embarqués — ni VLC ni Homebrew ne sont nécessaires sur l'autre Mac).
Sur l'autre Mac : ouvrir le DMG, glisser « Dikkenek Play » dans Applications.
Éviter l'alerte « application téléchargée / développeur non identifié » : elle vient d'un marqueur de quarantaine que
macOS pose uniquement sur les fichiers reçus par un navigateur, Mail, Messages ou AirDrop.
  1. Clé USB / disque externe / scp / curl / git : aucun marqueur → aucune alerte, rien à faire (méthode conseillée).
     Ex. depuis une release GitHub : curl -L -o ~/Desktop/DikkenekPlay.dmg "https://github.com/…/DikkenekPlay-2.2.dmg"
  2. DMG reçu par navigateur / AirDrop / Mail : AVANT de l'ouvrir, dans le Terminal :
        xattr -d com.apple.quarantine ~/Downloads/DikkenekPlay-2.2.dmg
     (ou, si l'app est déjà copiée :  xattr -dr com.apple.quarantine "/Applications/Dikkenek Play.app")
  3. Sinon : clic droit sur l'app → Ouvrir → Ouvrir (macOS 15+ : Réglages → Confidentialité et sécurité → « Ouvrir
     quand même »), une seule fois.
Pour supprimer cet avertissement définitivement, il faut un certificat « Developer ID Application » (programme
développeur Apple, 99 €/an) : build_dmg.command le détecte alors automatiquement, signe l'app, et notarise le DMG
si la variable NOTARY_PROFILE désigne un profil créé avec « xcrun notarytool store-credentials ».

Raccourcis : Espace = vidéo suivante (inactif pendant une saisie) · S = fondu au noir · ⌘O = ajouter ·
Retour arrière = retirer de la liste · Échap (dans la fenêtre de sortie) = quitter le plein écran.
Journal en cas de problème : ~/Library/Logs/DikkenekPlay.log
