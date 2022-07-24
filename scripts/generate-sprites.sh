#!/bin/sh

for ASSET in $(find ./assets/ -type f -name '*.ase'); do
    # Skip files that start with _
    FILENAME=$(basename $ASSET)
    if [[ $FILENAME == _* ]]; then
        echo "Skipping asset file $ASSET"
        continue
    fi

    echo "Generating sprites for $ASSET"

    LAYERS=$(aseprite -b --list-layers --all-layers $ASSET)
    DIR=$(dirname $ASSET)

    for LAYER in ${LAYERS[@]}; do
        # Skip layers that start with _
        if [[ $LAYER == _* ]]; then
            echo "Skipping layer $LAYER"
            continue
        fi

        echo "Exporting layer \"$LAYER\""
        aseprite -b --layer "$LAYER" --sheet "$DIR/$LAYER.png" --trim-by-grid --ignore-empty $ASSET | jq '.meta.image'
    done
done
