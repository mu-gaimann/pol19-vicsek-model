#!/bin/bash

# Executable file
execfile="../src/main.out"

# Set constants
output_path="../data/largesys-polarwave/"
velocity="0.5"
neighborhood_radius="1"
pbc="1"
time_total="200"
time_step="1"
polar_interact_prob="1"

# Interval boundaries and steps for parameter sweeps
box_size_low="50";
box_size_high="50"
box_size_step="1"

agent_number_low="0"
agent_number_high="25000"
agent_number_step="1000"

noise_strength_low="0.2";
noise_strength_high="0.2"
noise_strength_step="0.05"

# Work around floating point math
box_iterations="$( bc <<<"($box_size_high - $box_size_low) / $box_size_step" )"
noise_iterations="$( bc <<<"($noise_strength_high - $noise_strength_low) / $noise_strength_step" )"
agent_number_iterations="$( bc <<<"($agent_number_high - $agent_number_low) / $agent_number_step" )"
box_iter_ind="0"
noise_iter_ind="0"
agent_number_iter_ind="0"


# Call executable with various parameters

# Initialize
mkdir -p $output_path
box_size=$box_size_low

# Vary box size (density) and noise strength
while [ $box_iter_ind -le $box_iterations ]; do

  # Reset agent number variable
  agent_number=$agent_number_low
  agent_number_iter_ind="0"
  while [ $agent_number_iter_ind -le $agent_number_iterations ]; do

        # Reset noise variable
        noise_strength=$noise_strength_low
        noise_iter_ind="0"
        while [ $noise_iter_ind -le $noise_iterations ]; do

            # Run script
            echo Computing BOXSIZ $box_size AGNTNO $agent_number NOISTR $noise_strength
            $execfile $agent_number $output_path $velocity $box_size $noise_strength $neighborhood_radius $pbc $time_total $time_step $polar_interact_prob
            wait

            noise_strength="$( bc <<<"$noise_strength + $noise_strength_step" )"
            noise_iter_ind=$((noise_iter_ind+1))
        done

        agent_number="$( bc <<<"$agent_number+ $agent_number_step" )"
        agent_number_iter_ind=$((agent_number_iter_ind+1))
        echo
   done

  echo
  echo
  box_size="$( bc <<<"$box_size + $box_size_step" )"
  box_iter_ind=$((box_iter_ind+1))

done




# slide number missing! use different pictures for birds! (bacteria!)
# interaction radius defines environment
# explain forumula! arg
# motivate nematic model properly! (show pic of nematic bacteria etc)
# captions for figure at nematic slide

# agents are DEAD! -> inherently different description needed for fish
# NO COEXISTING PHASE here!!
