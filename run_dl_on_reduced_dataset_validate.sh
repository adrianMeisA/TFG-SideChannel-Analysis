#!/bin/bash
path_lists=$1
path_models=$2
path_acc=$3

# list of the scenarii
declare -a tagmaps=('executable_classification'
                        'novelty_classification'
                        'packer_identification'
                        'virtualization_identification'
                        'family_classification'
                        'obfuscation_classification'
                        'type_classification')


# number of tagmaps
nb_of_tagmaps=${#tagmaps[@]}

for  (( i=0; i<${nb_of_tagmaps}; i++ ));
do
    for b in `seq 4 4 28`; do
	    echo "Computing MLP, tagmap: ${tagmaps[$i]}, band:$b"
	    python dl_analysis/evaluate.py --band $b --list ${path_lists}/extracted_bd_files_lists_tagmaps=${tagmaps[$i]}.npy\
		    --acc ${path_acc} --model ${path_models}/mlp/mlp_${tagmaps[$i]}_band_$b.h5
    done
done



for  (( i=0; i<${nb_of_tagmaps}; i++ ));
do
    for b in `seq 4 4 28`; do
        echo "Computing CNN, tagmap: ${tagmaps[$i]}, band: $b"
        python dl_analysis/evaluate.py --band $b --list ${path_lists}/extracted_bd_files_lists_tagmaps=${tagmaps[$i]}.npy\
            --acc ${path_acc} --model ${path_models}/cnn/cnn_${tagmaps[$i]}_band_$b.h5
    done

done
