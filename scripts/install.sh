#!/usr/bin/env bash

REPO_DIR=$(git rev-parse --show-toplevel)
source "$REPO_DIR/scripts/coloring.sh"

function show_package_status () {
    yay -Q > "/tmp/packages.lst"
    clear

    while read package; do
        ver=$(grep -R "$package " ""/tmp/packages.lst"" | head -1)
        [[ -z "$ver" ]] &&
            echo "$(color "" red) ${package}" ||
            echo "$(color "" green) $(echo $ver | cut -d " " -f1) $(color ${ver##* } white)"
    done < $REPO_DIR/$1

    rm "/tmp/packages.lst"
}

while "true"; do
    clear

    select option in Exit Packages-Essentials Packages-Hyprland Symlink-Configuration Post-Installation; do
        case $option in
        Exit)
            exit
        ;;
        Packages-Essentials)
            show_package_status essentials.lst

            echo "Install package list: $(color  essentials.lst magenta)?"
            select yn in "Yes" "No"; do
                case $yn in
                    Yes ) yay -S - < essentials.lst; break;;
                    No ) break;;
                esac
            done

            break
        ;;
        Packages-Hyprland)
            show_package_status hyprland.lst

            echo "Install package list: $(color  hyprland.lst magenta)?"
            select yn in "Yes" "No"; do
                case $yn in
                    Yes ) yay -S - < hyprland.lst; break;;
                    No ) break;;
                esac
            done

            break
        ;;
        Symlink-Configuration)
            $REPO_DIR/scripts/symlink-config.sh
            break
        ;;
        Post-Installation)
            # Thunar
            yay -S thunar thunar-volman gvfs-git xdg-user-dirs
            xdg-user-dirs-update
            break
        ;;
        esac
    done
done
